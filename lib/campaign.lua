-- Step chain shared by the campaign mission drafts.
-- A step shows its goal when the previous step ends. It ends on its own trigger, monitor, kill,
-- ghost link, interaction or scene, and, unless a barrier holds the player, on any later step's
-- trigger or monitor.
local lib = require("lib.mission_lib")
local flow = require("lib.flow")
local EventKind = require("sunrise.activity_sdk").EventKind

local campaign = {}

--- Names one squad and the type-1 slot that carries it.
--- @param squad Generated squad identity.
--- @param source Generated slot identity for the same squad.
--- @param group Optional extracted task group for the encounter objective.
function campaign.unit(squad, source, group)
    return {squad = lib.one(squad, "squad"), source = lib.one(source, "squad slot"), group = group}
end

--- A dialogue cue and the volume the client holds it for.
function campaign.line(cue, filter)
    return {cue = lib.one(cue, "dialogue cue"), filter = filter}
end

--- A generator seed that changes with the attempt and never reaches zero.
--- The sandbox has no random source, so the attempt the host owns is the only varying number.
--- @param context Callback context.
--- @return A positive 31-bit integer.
function campaign.run_seed(context)
    local attempt = tonumber(context.attempt_generation) or 1
    local seed = attempt % 0x7FFFFFFF
    if seed == 0 then return 1 end
    return seed
end

--- Moves each device slot with one transition.
function campaign.move(context, slots, transition)
    for _, slot in ipairs(slots) do
        context:slot(slot):transition{transition = context.sdk.device_transitions[transition]}
    end
end

-- A filtered line waits in the client until the player enters the filter volume.
local function say(content, context, line)
    context:slot(content.dialogue_sensor):play_dialogue_cue{
        cue = line.cue, filter = line.filter ~= nil and context:slot(line.filter) or nil,
    }
end

local function speak(content, context, holder)
    for _, line in ipairs(holder.lines or {}) do say(content, context, line) end
end

-- Assign the objective before the placement. A squad body that changes after its members exist
-- reports alive 0 for about a second, and a cohort reads that as cleared.
local function populate(content, context, state, encounter)
    for _, unit in ipairs(encounter.squads or {}) do
        if encounter.objective ~= nil then
            context:slot(unit.source):assign_combat_objective{
                objective = context:slot(encounter.objective), task_group = unit.group,
            }
        end
        context:squad(unit.squad):place{}
    end
    speak(content, context, encounter)
    if encounter.on_start ~= nil then encounter.on_start(context, state) end
end

local function list(value)
    if value == nil then return {} end
    if type(value) == "table" then return value end
    return {value}
end

-- A goal without a navpoint keeps its text and shows no marker. Inside the waypoint volume the
-- marker hides. Sending the same goal again moves the marker without a popup.
local function show(content, context, step)
    context:slot(content.directive_sensor):set_directive{
        directive = step.directive,
        navpoint = step.navpoint ~= nil and context:slot(step.navpoint) or nil,
        waypoint = step.waypoint ~= nil and context:slot(step.waypoint) or nil,
    }
end

-- An armed trigger reports on every update while the player stays inside, so the first report
-- disarms it. The variable keeps a burst of reports to one disarm.
local function armed_key(id)
    return "armed/" .. id
end

local function arm_trigger(context, id)
    context:set_variable(armed_key(id), true)
    context:slot(id):fire_trigger()
end

-- A type-30 monitor reports its own entered edge and needs no disarm. One player is enough.
local function watch_monitor(context, id)
    context:slot(id):set_occupancy_condition{value = 1}
end

local function disarm_reported(context, state, event)
    local id = event.slot ~= nil and event.slot.id or nil
    if id ~= nil and state:variable(armed_key(id)) == true then
        context:clear_variable(armed_key(id))
        context:slot(id):disarm_trigger()
    end
end

-- The link and the interaction row register their objects, so they go before the goal. A row not
-- yet used shows a generic prompt, and without the row the client never reports a use.
local function begin(content, step)
    return function(context, state)
        local ends = step.ends or {}
        if ends.ghost_link ~= nil then
            context:slot(ends.ghost_link):set_ghost_link{active = true}
        end
        if ends.interact ~= nil then
            context:slot(ends.interact):set_interactable_object{used = true}
        end
        if step.scene ~= nil then
            local scene = context:scene(step.scene)
            scene:activate{spawn = step.scene_spawn == true}
            -- An input fires a trigger the scene's graph waits on; it follows the activation.
            for _, key in ipairs(step.inputs or {}) do scene:send_event{key = key} end
        end
        if step.directive ~= nil then show(content, context, step) end
        speak(content, context, step)
        -- Arming again reports a player who is already inside the volume.
        if step.revisit then
            for _, trigger in ipairs(list(ends.trigger)) do arm_trigger(context, trigger) end
        end
        if step.on_start ~= nil then step.on_start(context, state) end
    end
end

local SLOT_PREFIX = "slot/"

-- A slot id is slot/<object tag>/...; a marker needs its object registered on the client.
local function object_of(slot)
    if string.sub(slot, 1, #SLOT_PREFIX) ~= SLOT_PREFIX then return nil end
    return string.sub(slot, #SLOT_PREFIX + 1, #SLOT_PREFIX + 8)
end

-- A flow group holds at most 64 conditions; a repeated fact adds nothing.
local GROUP = 64

local function any_of(options)
    local seen, unique = {}, {}
    for _, option in ipairs(options) do
        local key = type(option) == "table" and option.fact or nil
        if key == nil or not seen[key] then
            if key ~= nil then seen[key] = true end
            unique[#unique + 1] = option
        end
    end
    while #unique > GROUP do
        local folded = {}
        for start = 1, #unique, GROUP do
            local part = {}
            for index = start, math.min(start + GROUP - 1, #unique) do
                part[#part + 1] = unique[index]
            end
            folded[#folded + 1] = {any = part}
        end
        unique = folded
    end
    if #unique == 0 then return nil end
    return {any = unique}
end

local function check(content)
    lib.one(content.key, "campaign key")
    lib.one(content.directive_sensor, "directive sensor")
    assert(#lib.one(content.legs, "campaign legs") > 0, "a campaign needs a leg")
    assert(#lib.one(content.steps, "campaign steps") > 0, "a campaign needs a step")
    local armed, watched = {}, {}
    for _, leg in ipairs(content.legs) do
        lib.one(leg.state, lib.one(leg.id, "leg id") .. " state")
        for _, trigger in ipairs(leg.arm or {}) do armed[trigger] = leg.id end
        for _, monitor in ipairs(leg.watch or {}) do watched[monitor] = leg.id end
    end
    for _, step in ipairs(content.steps) do
        lib.one(step.id, "step id")
        if step.lines ~= nil then lib.one(content.dialogue_sensor, "dialogue sensor") end
        if step.inputs ~= nil then lib.one(step.scene, step.id .. " input scene") end
        local output = (step.ends or {}).output
        if output ~= nil then
            lib.one(output.slot, step.id .. " output slot")
            lib.one(output.key, step.id .. " output key")
        end
        for _, trigger in ipairs(list((step.ends or {}).trigger)) do
            assert(armed[trigger], step.id .. " ends on a trigger no leg arms")
        end
        for _, monitor in ipairs(list((step.ends or {}).monitor)) do
            assert(watched[monitor], step.id .. " ends on a monitor no leg watches")
        end
        local hurt = (step.ends or {}).health
        if hurt ~= nil then
            lib.one(hurt.slot, step.id .. " health slot")
            assert(type(hurt.at) == "number" and hurt.at >= 0 and hurt.at <= 1,
                step.id .. " health fraction must be between zero and one")
        end
    end
    for _, cuts in ipairs({content.intro or {}, content.outro or {}}) do
        for index, cut in ipairs(cuts) do
            lib.one(cut.state, "cutscene " .. index .. " state")
            lib.one(cut.cinematic, "cutscene " .. index .. " cinematic")
        end
    end
    local step_ids = {arrival = true}
    for _, step in ipairs(content.steps) do step_ids[step.id] = true end
    for _, encounter in ipairs(content.encounters or {}) do
        lib.one(encounter.id, "encounter id")
        assert(step_ids[encounter.after or "arrival"], encounter.id .. " waits on an unknown step")
        if encounter.trigger ~= nil then
            assert(armed[encounter.trigger], encounter.id .. " waits on a trigger no leg arms")
        end
        if encounter.monitor ~= nil then
            assert(watched[encounter.monitor], encounter.id .. " waits on a monitor no leg watches")
        end
    end
end

--- Builds the mission table from a content declaration.
--- @param content Table with key, sensors, legs with their trigger and monitor lists, steps,
--- encounters, optional intro and outro lists of {state, cinematic} cutscenes, and an optional
--- spawn_set naming the launch points the client filters its spawn by.
--- @return The table the runtime loads: initial_state, on_start, on_load and event handlers.
function campaign.new(content)
    check(content)
    local legs, steps = content.legs, content.steps
    local first = legs[1]
    local intro = content.intro or {}
    local outro = content.outro or {}
    local facts, trigger_fact, graph = {}, {}, nil
    local objects, object_watches = {}, {}

    -- Each opening cutscene runs in its own state, in list order, before the first leg.
    local PLAYING, ENDED = 1, 2
    local function intro_key(index)
        return content.key .. ".intro." .. index
    end
    local function intro_done(state)
        return #intro == 0 or state:variable(intro_key(#intro)) == ENDED
    end
    local function outro_key(index)
        return content.key .. ".outro." .. index
    end
    local function prepare_cuts(context, state)
        if #intro == 0 and #outro == 0 then return end
        local owner = content.key .. ".cutscene_attempt"
        if state:variable(owner) == context.attempt_generation then return end
        for index in ipairs(intro) do context:clear_variable(intro_key(index)) end
        for index in ipairs(outro) do context:clear_variable(outro_key(index)) end
        context:set_variable(owner, context.attempt_generation)
    end
    local function entered_region(event)
        if event.kind == EventKind.REGION_CHANGED then return event.region_index end
        if event.kind == EventKind.CLIENT_STATE_CHANGED and event.entered == true then
            return event.held_region_index
        end
        return nil
    end

    -- The client spawns on the arrival answer. Its region leg and its empty reports both arrive
    -- while it is still loading. A move after a cutscene may not hold the spawn again, so there
    -- the region report also counts.
    facts[#facts + 1] = {id = "arrival", observe = function(_, state, event)
        local region = first.state.region_index
        if event.kind == EventKind.CLIENT_STATE_CHANGED and event.entered == true
            and event.held_region_index == region then return true end
        return #intro > 0 and intro_done(state) and entered_region(event) == region
    end}
    for _, leg in ipairs(legs) do
        local region = leg.state.region_index
        facts[#facts + 1] = {id = "leg." .. leg.id, observe = function(_, _, event)
            return entered_region(event) == region
        end}
    end
    local function watch(trigger, kind)
        if trigger_fact[trigger] == nil then
            local id = "t" .. (#facts + 1)
            trigger_fact[trigger] = id
            facts[#facts + 1] = {id = id, observe = function(context, _, event)
                return event.kind == kind and lib.is_slot(context, event, trigger)
            end}
        end
        return flow.fact(trigger_fact[trigger])
    end
    -- A revisited volume was crossed earlier, so its report counts only once the step is on.
    local function fresh(step, number)
        return flow.fact(step.id .. ".t" .. number)
    end
    for _, step in ipairs(steps) do
        local ends = step.ends or {}
        for number, trigger in ipairs(list(ends.trigger)) do
            if step.revisit then
                facts[#facts + 1] = {id = step.id .. ".t" .. number,
                    observe = function(context, state, event)
                        return event.kind == EventKind.PLAYER_TRIGGER
                            and graph:started(context, state, step.id)
                            and lib.is_slot(context, event, trigger)
                    end}
            else
                watch(trigger, EventKind.PLAYER_TRIGGER)
            end
        end
        for _, monitor in ipairs(list(ends.monitor)) do watch(monitor, EventKind.TRIGGER_ENTERED) end
        if step.revisit and ends.region ~= nil then
            local region = nil
            for _, leg in ipairs(legs) do
                if leg.id == ends.region then region = leg.state.region_index end
            end
            lib.one(region, step.id .. " return region")
            facts[#facts + 1] = {id = step.id .. ".region",
                observe = function(context, state, event)
                    return graph:started(context, state, step.id)
                        and entered_region(event) == region
                end}
        end
        if ends.ghost_link ~= nil then
            local link, started = ends.ghost_link, step.id .. ".scan"
            facts[#facts + 1] = {id = started, observe = function(context, state, event)
                return event.kind == EventKind.GHOST_LINK_STATE and graph:started(context, state, step.id)
                    and lib.is_slot(context, event, link)
                    and event.active == true and (event.progress or 0) > 0
            end}
            facts[#facts + 1] = {id = step.id .. ".scanned",
                observe = function(context, state, event)
                    return event.kind == EventKind.GHOST_LINK_STATE and graph:fact(context, state, started)
                        and lib.is_slot(context, event, link) and event.active == false
                end}
        end
        for number, object in ipairs(ends.destroyed or {}) do
            local watched = object_watches[object]
            if watched == nil then
                watched = {key = content.key .. ".object." .. (#objects + 1)}
                objects[#objects + 1] = watched
                object_watches[object] = watched
            end
            facts[#facts + 1] = {id = step.id .. ".gone" .. number,
                observe = function(context, state, event)
                    return event.kind == EventKind.OBJECT_STATE and graph:started(context, state, step.id)
                        and lib.is_slot(context, event, object) and event.present == false
                        and type(event.generation) == "number" and event.generation > 0
                        and state:variable(watched.key) == event.generation
                end}
        end
        if ends.interact ~= nil then
            local object = ends.interact
            facts[#facts + 1] = {id = step.id .. ".used", observe = function(context, state, event)
                return event.kind == EventKind.OBJECT_INTERACTED and graph:started(context, state, step.id)
                    and lib.is_slot(context, event, object)
            end}
        end
        -- A damage burst may cross a later phase's threshold before that step starts.
        if ends.health ~= nil then
            local target, at = ends.health.slot, ends.health.at
            facts[#facts + 1] = {id = step.id .. ".hurt", observe = function(context, _, event)
                return event.kind == EventKind.DAMAGE_STATE
                    and lib.is_slot(context, event, target)
                    and type(event.health) == "number" and event.health >= 0
                    and event.health <= at
            end}
        end
        -- A scene may have played before; only a report after its step counts.
        if ends.scene ~= nil then
            local scene = ends.scene
            facts[#facts + 1] = {id = step.id .. ".played",
                observe = function(context, state, event)
                return event.kind == EventKind.SCENE_FINISHED and graph:started(context, state, step.id)
                    and lib.is_slot(context, event, scene)
            end}
        end
        -- An output reported before its step started belongs to an earlier run.
        if ends.output ~= nil then
            local scene, key = ends.output.slot, ends.output.key
            facts[#facts + 1] = {id = step.id .. ".output",
                observe = function(context, state, event)
                return event.kind == EventKind.SCENE_OUTPUT and graph:started(context, state, step.id)
                    and lib.is_slot(context, event, scene) and event.key == key
            end}
        end
    end
    -- Encounters live in a second graph, so each graph stays inside the step and fact limits.
    local encounter_facts, encounter_fact, encounter_graph = {}, {}, nil
    for _, encounter in ipairs(content.encounters or {}) do
        local source = encounter.trigger or encounter.monitor
        local kind = encounter.trigger ~= nil and EventKind.PLAYER_TRIGGER or EventKind.TRIGGER_ENTERED
        if source ~= nil and encounter_fact[source] == nil then
            local id = "t" .. (#encounter_facts + 1)
            encounter_fact[source] = id
            encounter_facts[#encounter_facts + 1] = {id = id, observe = function(context, _, event)
                return event.kind == kind and lib.is_slot(context, event, source)
            end}
        end
    end

    local placed = {}
    for _, encounter in ipairs(content.encounters or {}) do placed[encounter.id] = encounter end
    local function cleared(ids)
        local squads = {}
        for _, id in ipairs(ids) do
            for _, unit in ipairs(lib.one(placed[id], "encounter " .. id).squads) do
                squads[#squads + 1] = unit.squad
            end
        end
        return function(context, state)
            for _, id in ipairs(ids) do
                if not encounter_graph:started(context, state, id) then return false end
            end
            return context:cohort{squads = squads}.cleared
        end
    end

    local function own_end(step)
        local ends, options = step.ends or {}, {}
        for number, trigger in ipairs(list(ends.trigger)) do
            options[#options + 1] = step.revisit and fresh(step, number) or watch(trigger)
        end
        for _, monitor in ipairs(list(ends.monitor)) do options[#options + 1] = watch(monitor) end
        if ends.region ~= nil then
            options[#options + 1] = flow.fact(step.revisit and step.id .. ".region"
                or "leg." .. ends.region)
        end
        if ends.clear ~= nil then options[#options + 1] = cleared(list(ends.clear)) end
        if ends.ghost_link ~= nil then options[#options + 1] = flow.fact(step.id .. ".scanned") end
        if ends.interact ~= nil then options[#options + 1] = flow.fact(step.id .. ".used") end
        if ends.scene ~= nil then options[#options + 1] = flow.fact(step.id .. ".played") end
        if ends.output ~= nil then options[#options + 1] = flow.fact(step.id .. ".output") end
        if ends.health ~= nil then options[#options + 1] = flow.fact(step.id .. ".hurt") end
        if ends.await ~= nil then options[#options + 1] = ends.await end
        if ends.destroyed ~= nil then
            local all = {}
            for number = 1, #ends.destroyed do
                all[number] = flow.fact(step.id .. ".gone" .. number)
            end
            options[#options + 1] = {all = all}
        end
        return options
    end

    local chain = {{id = "arrival", await = flow.fact("arrival")}}
    local previous = "arrival"
    for index, step in ipairs(steps) do
        local options = own_end(step)
        if #options > 0 and not step.barrier then
            for later = index + 1, #steps do
                local ends = steps[later].ends or {}
                for _, trigger in ipairs(steps[later].revisit and {} or list(ends.trigger)) do
                    options[#options + 1] = watch(trigger)
                end
                for _, monitor in ipairs(list(ends.monitor)) do
                    options[#options + 1] = watch(monitor)
                end
                if ends.region ~= nil and not steps[later].revisit then
                    options[#options + 1] = flow.fact("leg." .. ends.region)
                end
            end
        end
        -- A step with no end finishes at once; the next step starts with it.
        local await = any_of(options)
        chain[#chain + 1] = {id = step.id, after = {previous}, run = begin(content, step),
            await = await}
        previous = step.id
    end
    if #outro > 0 then
        chain[#chain + 1] = {id = "outro", after = {previous},
            run = function(context) context:select_state(outro[1].state) end,
            await = function(_, state) return state:variable(outro_key(#outro)) == ENDED end}
        previous = "outro"
    end
    -- Trigger facts latch, so an encounter whose trigger fired early places once its step starts.
    local placements = {}
    for _, encounter in ipairs(content.encounters or {}) do
        local after = encounter.after or "arrival"
        local source = encounter.trigger or encounter.monitor
        -- The arrival step is waiting from the start, so arrival itself must have happened.
        local function begun(context, state)
            if after == "arrival" then return graph:fact(context, state, "arrival") end
            return graph:started(context, state, after)
        end
        local when = function(context, state)
            return begun(context, state) and (source == nil
                or encounter_graph:fact(context, state, encounter_fact[source]))
                and (encounter.when == nil or encounter.when(context, state) == true)
        end
        placements[#placements + 1] = {id = encounter.id, when = when,
            run = function(context, state) populate(content, context, state, encounter) end}
    end
    -- The finished mission shows no goal and no map marker.
    chain[#chain + 1] = {id = "done", after = {previous}, run = function(context)
        if content.finish ~= nil then content.finish(context) end
        context:slot(content.directive_sensor):clear_directives()
        if content.complete ~= false then context:complete_mission{} end
    end}

    graph = flow.new{key = content.key, facts = facts, steps = chain}
    if #placements > 0 then
        encounter_graph = flow.new{key = content.key .. ".enc", facts = encounter_facts,
            steps = placements}
    end

    -- A trigger reports only once the host arms it, and arming registers its object, so each
    -- leg arms its triggers when the player reaches it.
    local function arm(context, region)
        local objects = {}
        for _, leg in ipairs(legs) do
            if leg.state.region_index == region then
                for _, trigger in ipairs(leg.arm or {}) do
                    arm_trigger(context, trigger)
                    objects[object_of(trigger) or trigger] = true
                end
                for _, monitor in ipairs(leg.watch or {}) do
                    watch_monitor(context, monitor)
                    objects[object_of(monitor) or monitor] = true
                end
            end
        end
        return objects
    end
    local function active(context, state)
        for index, step in ipairs(steps) do
            local following = steps[index + 1] ~= nil and steps[index + 1].id
                or (#outro > 0 and "outro" or "done")
            if graph:started(context, state, step.id)
                and not graph:started(context, state, following) then
                return step
            end
        end
        return nil
    end
    local function prepare_objects(context, state)
        if #objects == 0 then return end
        local owner = content.key .. ".object_attempt"
        if state:variable(owner) == context.attempt_generation then return end
        for _, watched in ipairs(objects) do context:clear_variable(watched.key) end
        context:set_variable(owner, context.attempt_generation)
    end
    -- Positive generations are present; negative generations retain the last absent report.
    local function observe_object(context, state, event)
        if event.kind ~= EventKind.OBJECT_STATE or event.slot == nil
            or type(event.generation) ~= "number" or event.generation <= 0 then return nil end
        local watched = object_watches[event.slot.id]
        if watched == nil then return nil end
        local retained = state:variable(watched.key)
        local generation = retained ~= nil and (retained < 0 and -retained or retained) or 0
        if event.generation < generation then return nil end
        if event.present == true then
            context:set_variable(watched.key, event.generation)
        elseif event.present == false and event.generation > generation then
            context:set_variable(watched.key, -event.generation)
        end
        return watched
    end
    -- The step graph runs first; a placement reads which steps have started.
    local function handle(context, state, event)
        if event.attempt_generation ~= context.attempt_generation then return end
        prepare_objects(context, state)
        local watched = observe_object(context, state, event)
        graph:handle(context, state, event)
        if watched ~= nil and event.present == false then
            context:set_variable(watched.key, -event.generation)
        end
        if encounter_graph ~= nil then
            encounter_graph:handle(context, state, event)
            graph:advance(context, state)
        end
    end
    local function advance(context, state)
        prepare_objects(context, state)
        graph:advance(context, state)
        if encounter_graph ~= nil then
            encounter_graph:advance(context, state)
            graph:advance(context, state)
        end
    end
    -- A goal sent before its marker's object registered shows no marker, so the goal still
    -- showing is sent again once the new region registers that object.
    local function enter(context, state, event, region)
        local before = active(context, state)
        local objects = arm(context, region)
        handle(context, state, event)
        if before == nil or before.directive == nil or active(context, state) ~= before then
            return
        end
        local marker = before.navpoint or before.waypoint
        if marker ~= nil and objects[object_of(marker)] then show(content, context, before) end
    end
    -- An interactable spawns with its group's seed, so it stays out until its step sends its row.
    local omit = {}
    for _, id in ipairs(content.omit or {}) do omit[#omit + 1] = id end
    for _, step in ipairs(steps) do
        local object = step.ends ~= nil and step.ends.interact or nil
        if object ~= nil then omit[#omit + 1] = object end
    end
    -- The client holds the cutscene's region, so only the start is owed.
    local function start_cut(context, state, region, cuts, key)
        for index, cut in ipairs(cuts) do
            if state:variable(key(index)) ~= ENDED then
                if cut.state.region_index == region and state:variable(key(index)) == nil then
                    context:set_variable(key(index), PLAYING)
                    context:slot(cut.cinematic):set_cinematic_active{active = true}
                end
                return
            end
        end
    end
    local function start_cuts(context, state, region)
        start_cut(context, state, region, intro, intro_key)
        if #outro > 0 and graph:started(context, state, "outro") then
            start_cut(context, state, region, outro, outro_key)
        end
    end
    local function end_cut(context, state, index, cuts, key)
        if state:variable(key(index)) == ENDED then return end
        context:set_variable(key(index), ENDED)
        -- Stop before a state change can rebuild the cutscene component.
        context:slot(cuts[index].cinematic):set_cinematic_active{active = false}
        if index < #cuts then
            context:select_state(cuts[index + 1].state)
            if cuts[index + 1].state.region_index == cuts[index].state.region_index then
                start_cut(context, state, cuts[index].state.region_index, cuts, key)
            end
        elseif cuts == intro then
            context:select_state(first.state, omit)
            context:hold_spawn{active = false}
        end
    end
    local function end_reported_cut(context, state, event, cuts, key)
        for index, cut in ipairs(cuts) do
            if state:variable(key(index)) == PLAYING
                and lib.is_slot(context, event, cut.cinematic) then
                end_cut(context, state, index, cuts, key)
                return
            end
        end
    end
    local function end_reported(context, state, event)
        if event.attempt_generation ~= context.attempt_generation then return end
        end_reported_cut(context, state, event, intro, intro_key)
        end_reported_cut(context, state, event, outro, outro_key)
        advance(context, state)
    end

    return {
        initial_state = {
            region_index = (#intro > 0 and intro[1].state or first.state).region_index,
            spawn_set_hash = content.spawn_set,
            omit = omit,
        },
        on_start = function(context, state)
            prepare_cuts(context, state)
            if #intro > 0 and not intro_done(state) then context:hold_spawn{active = true} end
            advance(context, state)
        end,
        -- A reattach lands in the world, so a cutscene still marked playing is ended, not replayed.
        on_load = function(context, state)
            prepare_cuts(context, state)
            for _, series in ipairs({{intro, intro_key}, {outro, outro_key}}) do
                for index in ipairs(series[1]) do
                    if state:variable(series[2](index)) == PLAYING then
                        end_cut(context, state, index, series[1], series[2])
                        break
                    end
                end
            end
            if #intro > 0 and intro_done(state) and not graph:fact(context, state, "arrival") then
                context:select_state(first.state, omit)
            end
            advance(context, state)
        end,
        on_event_region_changed = function(context, state, event)
            if event.attempt_generation ~= context.attempt_generation then return end
            start_cuts(context, state, event.region_index)
            enter(context, state, event, event.region_index)
        end,
        -- Only the arrival answer feeds the graph. A pending leg report names a region the
        -- client has not loaded.
        on_event_client_state_changed = function(context, state, event)
            if event.attempt_generation ~= context.attempt_generation then return end
            if event.entered == true then
                start_cuts(context, state, event.held_region_index)
                enter(context, state, event, event.held_region_index)
            end
        end,
        -- End and a refused start arrive here; a skip request has its own event kind. Both end the
        -- cutscene, or a skipped intro never releases the held spawn.
        on_event_cinematic_terminated = end_reported,
        on_event_cinematic_skip_requested = end_reported,
        on_event_player_trigger = function(context, state, event)
            if event.attempt_generation ~= context.attempt_generation then return end
            disarm_reported(context, state, event)
            handle(context, state, event)
        end,
        -- A watched monitor reports here, not through the player-trigger event.
        on_event_trigger_entered = handle,
        on_event_scene_finished = handle,
        on_event_scene_output = handle,
        on_event_damage_state = handle,
        on_event_timer_elapsed = handle,
        on_event_squad_state = handle,
        on_event_device_state = handle,
        on_event_object_interacted = handle,
        on_event_ghost_link_state = handle,
        on_event_object_state = handle,
    }
end

return campaign
