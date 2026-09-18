-- Open world. One zone per authored state row, population that respawns, public event sites and
-- Lost Sectors. A zone owns its entities; only the held zone receives requests.
-- Deaths arrive on the type-1 squad Sense, so nothing here reads the client.
local lib = require("lib.mission_lib")

local freeroam = {}

-- One service timer drives every cooldown. A destination has up to 64 zones and the host
-- retains 32 timers, so a timer per zone or per site would not fit.
local TICK_TIMER = "tick"
local TICK_KEY = "now"
local HELD_KEY = "held"
local ENTERED_KEY = "in"

-- The service cadence bounds how late a respawn can be, so it stays well under the wait.
local DEFAULT_TICK_MS = 5000
-- Dawn's freeroam_respawn_ms default.
local DEFAULT_RESPAWN_MS = 30000
local DEFAULT_EVENT_COOLDOWN_MS = 120000

-- The client copies this into the event banner. Anything but 0 is unverified.
local EVENT_STATE = 0
local EVENT_LEAVE_SECONDS = 30.0

local PHASE_RUNNING = 1
local PHASE_CLEARED = 2

local SECTOR_KEY = "sec"
local SECTOR_ACTIVE = 1
local SECTOR_CLEARED = 2
local SECTOR_CLEARED_KEY = "sk"
local CRYSTAL_DONE_KEY = "cx"
local ACTIVE_SITE_KEY = "as"

--- Pairs a squad with the type-1 slot its Sense reports on.
function freeroam.unit(squad, slot)
    return {squad = lib.one(squad, "unit squad"), slot = lib.one(slot, "unit slot")}
end

-- Ticks, never milliseconds: the script has no clock and the service timer is the only cadence.
local function ticks_for(milliseconds, tick_ms)
    local count = milliseconds // tick_ms
    if count < 1 then
        return 1
    end
    return count
end

local function now_tick(scope)
    return scope:variable(TICK_KEY) or 0
end

-- A due key names one respawnable inside its zone. Durable keys hold 63 bytes.
local function due_key(index)
    return "d" .. index
end

local function schedule(scope, index, delay_ticks)
    scope:set_variable(due_key(index), now_tick(scope) + delay_ticks)
end

local function due(scope, index)
    local at = scope:variable(due_key(index))
    return at ~= nil and at <= now_tick(scope)
end

local function clear_due(scope, index)
    scope:clear_variable(due_key(index))
end

-- Every respawnable in a zone gets one index, so a due key is short and stable across visits.
local function number_zone(zone)
    local index = 0
    for _, unit in ipairs(zone.patrol) do
        index = index + 1
        unit.index = index
    end
    for _, site in ipairs(zone.events) do
        index = index + 1
        site.index = index
        site.phase_key = "p" .. index
        site.cleared_key = "k" .. index
    end
end

-- One member per authored lane. Each lane carries its own actor class and behaviour, so a
-- lane may be thinned but never emptied: zeroing one spawns the wrong members without AI.
local LANE_CAP = 1

local function capped_counts(squad)
    local counts = squad:counts()
    local authored = squad.default_counts
    for index = 1, counts.count do
        if (authored[index] or 0) > LANE_CAP then
            counts:set(index, LANE_CAP)
        end
    end
    return counts
end

local function place_one(context, unit, mode)
    local squad = context:squad(unit.squad)
    squad:place{counts = capped_counts(squad), mode = mode}
end

local function place_units(context, units, mode)
    for _, unit in ipairs(units) do
        place_one(context, unit, mode)
    end
end

-- A zero request retires every member. A squad still holding a live body ignores a new
-- placement, so a reset empties it and the next entry fills it.
local function retire_units(context, units)
    for _, unit in ipairs(units) do
        local squad = context:squad(unit.squad)
        local counts = squad:counts()
        for index = 1, counts.count do
            counts:set(index, 0)
        end
        squad:place{counts = counts, mode = context.sdk.squad_modes.replace}
    end
end

local function set_objects(context, slots, active)
    if #slots > 0 then
        context:activate_objects{slots = slots, active = active}
    end
end

-- Sites and sectors both answer "did this squad's slot report?".
local function unit_reporting(context, event, units)
    for _, unit in ipairs(units) do
        if lib.is_slot(context, event, unit.slot) then
            return unit
        end
    end
    return nil
end

-- ---------------------------------------------------------------------------
-- Public event sites
-- ---------------------------------------------------------------------------

local function start_site(context, scope, site)
    scope:set_variable(site.phase_key, PHASE_RUNNING)
    scope:set_variable(site.cleared_key, 0)
    clear_due(scope, site.index)
    set_objects(context, site.chest, false)
    context:slot(site.objective):reset_objectives()
    place_units(context, site.squads, context.sdk.squad_modes.replace)
    -- The sensor's own slot bounds the watched area.
    context:slot(site.sensor):set_public_event_state{
        state = EVENT_STATE,
        area = context:slot(site.sensor),
        leave_seconds = EVENT_LEAVE_SECONDS,
    }
end

-- One event runs at a time. Starting every site in a zone at once places hundreds of squads
-- in one frame, which retail never does.
local function start_active_site(context, scope, zone, ordinal)
    if #zone.events == 0 then
        return
    end
    local index = ((ordinal - 1) % #zone.events) + 1
    scope:set_variable(ACTIVE_SITE_KEY, index)
    start_site(context, scope, zone.events[index])
end

local function active_site(scope, zone)
    local index = scope:variable(ACTIVE_SITE_KEY)
    if index == nil or zone.events[index] == nil then
        return nil
    end
    return zone.events[index]
end

-- A site ends when every squad it placed is gone. Not every event is a boss kill.
local function site_squad_cleared(context, scope, site, cooldown_ticks)
    if scope:variable(site.phase_key) ~= PHASE_RUNNING then
        return
    end
    local cleared = (scope:variable(site.cleared_key) or 0) + 1
    scope:set_variable(site.cleared_key, cleared)
    if cleared < #site.squads then
        return
    end
    scope:set_variable(site.phase_key, PHASE_CLEARED)
    set_objects(context, site.chest, true)
    schedule(scope, site.index, cooldown_ticks)
end

-- ---------------------------------------------------------------------------
-- Lost Sectors
-- ---------------------------------------------------------------------------

local function start_sector(context, scope, sector)
    scope:set_variable(SECTOR_KEY, SECTOR_ACTIVE)
    scope:set_variable(SECTOR_CLEARED_KEY, 0)
    scope:set_variable(CRYSTAL_DONE_KEY, 0)
    set_objects(context, sector.chest, false)
    -- A blocker object is retired, not moved. A door is a type-23 channel.
    set_objects(context, sector.blockers, false)
    for _, door in ipairs(sector.doors) do
        context:slot(door.slot):set_channel{
            channel = door.channel,
            value = door.value,
            snap = true,
        }
    end
    -- The authored effect and its filter hold the boss until its gate squads die.
    if sector.shield ~= nil then
        context:slot(sector.shield.effect):set_object_filter{
            target = context:slot(sector.shield.filter),
            inside = true,
        }
    end
    place_units(context, sector.squads, context.sdk.squad_modes.replace)
    -- A crystal stays inert until its guardian dies. The monitor answers its destruction.
    for _, crystal in ipairs(sector.crystals) do
        context:activate_objects{slots = {crystal.object}, active = false}
        context:slot(crystal.monitor):watch_damage{target = context:slot(crystal.object)}
    end
end

local function drop_shield(context, sector)
    if sector.shield ~= nil then
        context:slot(sector.shield.effect):set_object_active{active = false}
    end
end

local function open_crystal(context, event, sector)
    for _, crystal in ipairs(sector.crystals) do
        if crystal.guard ~= nil and lib.is_slot(context, event, crystal.guard) then
            context:activate_objects{slots = {crystal.object}, active = true}
            return true
        end
    end
    return false
end

local function expose_boss_crystal(context, sector)
    for _, crystal in ipairs(sector.crystals) do
        if crystal.boss then
            context:activate_objects{slots = {crystal.object}, active = true}
        end
    end
end

local function crystal_destroyed(context, scope, event, sector)
    for _, crystal in ipairs(sector.crystals) do
        if lib.is_slot(context, event, crystal.monitor) then
            if crystal.boss then
                drop_shield(context, sector)
                return
            end
            local done = (scope:variable(CRYSTAL_DONE_KEY) or 0) + 1
            scope:set_variable(CRYSTAL_DONE_KEY, done)
            if done >= sector.guarded_crystals then
                expose_boss_crystal(context, sector)
            end
            return
        end
    end
end

local function clear_sector(context, scope, sector)
    if scope:variable(SECTOR_KEY) ~= SECTOR_ACTIVE then
        return
    end
    scope:set_variable(SECTOR_KEY, SECTOR_CLEARED)
    -- The chest opens and grants nothing: no script call reaches an account.
    set_objects(context, sector.chest, true)
end

-- Retail unlocks the chest on the boss. Without an authored boss name, a full clear stands in.
local function sector_squad_cleared(context, scope, sector)
    local cleared = (scope:variable(SECTOR_CLEARED_KEY) or 0) + 1
    scope:set_variable(SECTOR_CLEARED_KEY, cleared)
    if cleared >= #sector.squads then
        clear_sector(context, scope, sector)
    end
end

-- ---------------------------------------------------------------------------
-- Zones
-- ---------------------------------------------------------------------------

-- A Lost Sector is private content in a bubble this link already hosts, so its population
-- needs no state selection. Selecting one makes the placements wait for the client's slice-set
-- switch, which does not run until the public bubble unloads.
local function enter_zone(context, scope, zone)
    if zone.sector ~= nil then
        start_sector(context, scope, zone.sector)
        return
    end
    context:select_state(zone.state)
    place_units(context, zone.ambient, context.sdk.squad_modes.reinforce)
    place_units(context, zone.patrol, context.sdk.squad_modes.reinforce)
    start_active_site(context, scope, zone, 1)
end

-- A patrol squad that died before the visit ended is owed a placement on return.
local function resume_zone(context, scope, zone)
    for _, unit in ipairs(zone.patrol) do
        if scope:variable(due_key(unit.index)) ~= nil then
            place_one(context, unit, context.sdk.squad_modes.reinforce)
            clear_due(scope, unit.index)
        end
    end
end

local function service_zone(context, scope, zone)
    for _, unit in ipairs(zone.patrol) do
        if due(scope, unit.index) then
            clear_due(scope, unit.index)
            place_one(context, unit, context.sdk.squad_modes.reinforce)
        end
    end
    -- A finished site hands the zone to the next one, so the zone always has one event.
    local site = active_site(scope, zone)
    if site ~= nil and due(scope, site.index) then
        clear_due(scope, site.index)
        start_active_site(context, scope, zone, (scope:variable(ACTIVE_SITE_KEY) or 1) + 1)
    end
end

--- Builds the open-world handler table for one destination.
function freeroam.new(definition)
    local zones = lib.one(definition.zones, "zones")
    local tick_ms = definition.tick_ms or DEFAULT_TICK_MS
    local respawn_ticks = ticks_for(definition.respawn_ms or DEFAULT_RESPAWN_MS, tick_ms)
    local cooldown_ticks =
        ticks_for(definition.event_cooldown_ms or DEFAULT_EVENT_COOLDOWN_MS, tick_ms)

    local by_region = {}
    for _, zone in ipairs(zones) do
        zone.patrol = zone.patrol or {}
        zone.ambient = zone.ambient or {}
        zone.events = zone.events or {}
        zone.tag = "z" .. zone.region
        if zone.sector ~= nil then
            zone.sector.squads = zone.sector.squads or {}
            zone.sector.chest = zone.sector.chest or {}
            zone.sector.doors = zone.sector.doors or {}
            zone.sector.blockers = zone.sector.blockers or {}
            zone.sector.crystals = zone.sector.crystals or {}
            zone.sector.gates = zone.sector.gates or {}
            local guarded = 0
            for _, crystal in ipairs(zone.sector.crystals) do
                if not crystal.boss then
                    guarded = guarded + 1
                end
            end
            zone.sector.guarded_crystals = guarded
        end
        number_zone(zone)
        assert(by_region[zone.region] == nil, "two zones share a region")
        by_region[zone.region] = zone
    end

    -- One link, one job. The mission link hosts the private content: Lost Sectors and patrol.
    -- A public bubble link hosts its own bubble's combat and events. Neither may touch the
    -- other's zones, or both place the same population.
    local function owns(context, zone)
        if context.activity_role == "public" then
            return zone.sector == nil
        end
        return zone.sector ~= nil
    end

    local function held_zone(state)
        local region = state:variable(HELD_KEY)
        if region == nil then
            return nil
        end
        return by_region[region]
    end

    -- A durable variable is only readable after its commit, so two events in one dispatch
    -- would both see the zone as unbuilt and place its population twice.
    local built = {}

    -- Leaving a sector's bubble empties it. Retiring and placing in one dispatch loses the
    -- placement, so the run that leaves clears the bodies and the next entry fills them.
    local function reset_departed(context, state, region)
        for _, zone in ipairs(zones) do
            if zone.sector ~= nil and zone.region ~= region and built[zone.tag] then
                retire_units(context, zone.sector.squads)
                local scope = lib.scope(context, state, zone.tag)
                scope:clear_variable(ENTERED_KEY)
                scope:clear_variable(SECTOR_KEY)
                scope:clear_variable(SECTOR_CLEARED_KEY)
                scope:clear_variable(CRYSTAL_DONE_KEY)
                built[zone.tag] = nil
            end
        end
    end

    local function build_zone(context, state, zone)
        local scope = lib.scope(context, state, zone.tag)
        if built[zone.tag] or scope:variable(ENTERED_KEY) then
            built[zone.tag] = true
            resume_zone(context, scope, zone)
            return
        end
        built[zone.tag] = true
        scope:set_variable(ENTERED_KEY, true)
        enter_zone(context, scope, zone)
    end

    return {
        -- A sector starts as soon as the client names it, not when it finishes switching slice
        -- sets. This places no state, so it cannot stall behind the switch or disturb a spawn.
        -- It needs a region already held: during the first load nothing is, and building then
        -- black-screens the client.
        on_event_client_state_changed = function(context, state, event)
            if event.held_region_index == nil or event.region_index == nil then
                return
            end
            local zone = by_region[event.region_index]
            if zone == nil or zone.sector == nil or not owns(context, zone) then
                return
            end
            build_zone(context, state, zone)
            context:start_timer(TICK_TIMER, tick_ms)
        end,

        -- Every other zone builds on the region change, because it selects a state and that
        -- must not happen for a region the client is not in.
        on_event_region_changed = function(context, state, event)
            local zone = by_region[event.region_index]
            context:set_variable(HELD_KEY, event.region_index)
            reset_departed(context, state, event.region_index)
            if zone == nil or not owns(context, zone) then
                return
            end
            build_zone(context, state, zone)
            context:start_timer(TICK_TIMER, tick_ms)
        end,

        on_event_squad_state = function(context, state, event)
            local zone = held_zone(state)
            if zone == nil or not owns(context, zone) or event.alive_count ~= 0
                or event.previous_alive_count <= 0 then
                return
            end
            local scope = lib.scope(context, state, zone.tag)
            local unit = unit_reporting(context, event, zone.patrol)
            if unit ~= nil then
                schedule(scope, unit.index, respawn_ticks)
                return
            end
            local site = active_site(scope, zone)
            if site ~= nil and unit_reporting(context, event, site.squads) ~= nil then
                site_squad_cleared(context, scope, site, cooldown_ticks)
                return
            end
            local sector = zone.sector
            if sector == nil then
                return
            end
            if sector.boss ~= nil then
                if lib.is_slot(context, event, sector.boss) then
                    clear_sector(context, scope, sector)
                    return
                end
            elseif unit_reporting(context, event, sector.squads) ~= nil then
                sector_squad_cleared(context, scope, sector)
                return
            end
            if open_crystal(context, event, sector) then
                return
            end
            -- A gate squad frees the boss: drop the authored effect that protects it.
            for _, gate in ipairs(sector.gates) do
                if lib.is_slot(context, event, gate) then
                    drop_shield(context, sector)
                    return
                end
            end
        end,

        -- The type-20 monitor echoes the crystal's health, so destruction needs no client read.
        on_event_damage_state = function(context, state, event)
            local zone = held_zone(state)
            if zone == nil or zone.sector == nil or not owns(context, zone) then
                return
            end
            if type(event.health) ~= "number" or event.health > 0 then
                return
            end
            crystal_destroyed(context, lib.scope(context, state, zone.tag), event, zone.sector)
        end,

        on_event_timer_elapsed = function(context, state, event)
            if event.timer_name ~= TICK_TIMER then
                return
            end
            local zone = held_zone(state)
            if zone == nil or not owns(context, zone) then
                return
            end
            local scope = lib.scope(context, state, zone.tag)
            scope:set_variable(TICK_KEY, now_tick(scope) + 1)
            service_zone(context, scope, zone)
            context:start_timer(TICK_TIMER, tick_ms)
        end,
    }
end

return freeroam
