local missions = require("missions")
local mission = require(missions.RAID_GLUTTONY_0)
local lib = require("lib.mission_lib")
local berth_combat = require("raid_gluttony_0.berth_combat")(mission)

-- Two authored states of one slice set: 0 playable, 1 the landing cutscene.
-- Only a state change builds the cutscene's type-6 component.
local BERTH_CINEMATIC_STATE =
    lib.one(mission.states.STATE_80B48062_0002_0001_80B4805D, "berth cinematic state")
local BERTH_PLAYABLE_STATE =
    lib.one(mission.states.STATE_80B48062_0002_0000_80B4805C, "berth playable state")

-- Script reload preserves these marks in native mission state.
local BERTH_KEY = "berth"
local CINE_KEY = "cine"
local SPAWNED_KEY = "spawned"
local PLAYING_KEY = "playing"

local CINE_IDLE = 0
local CINE_RUNNING = 1
local CINE_DONE = 2
local entry_transition_request

local ACTIVE_OBJECTS = lib.list(
    mission.Slot.O_WATERFALL_LEVER_0,
    mission.Slot.O_WATERFALL_LEVER_1,
    mission.Slot.O_WATERFALL_LEVER_2,
    mission.Slot.O_WATERFALL_LEVER_3,
    mission.Slot.O_WATERFALL_LEVER_4,
    mission.Slot.O_WATERFALL_LEVER_5,
    mission.Slot.O_SEWER_LEVER_0,
    mission.Slot.O_SEWER_LEVER_1,
    mission.Slot.O_SEWER_LEVER_2,
    mission.Slot.O_SEWER_LEVER_3,
    mission.Slot.O_SEWER_LEVER_4,
    mission.Slot.O_SEWER_LEVER_5,
    mission.Slot.O_BERTH_GLYPH_0,
    mission.Slot.O_BERTH_GLYPH_1,
    mission.Slot.O_BERTH_GLYPH_2,
    mission.Slot.O_BERTH_GLYPH_3,
    mission.Slot.O_BERTH_GLYPH_4
)

local CLOSED_DEVICES = lib.list(
    mission.Slot.D_WATERFALL_LEVER_0,
    mission.Slot.D_WATERFALL_LEVER_1,
    mission.Slot.D_WATERFALL_LEVER_2,
    mission.Slot.D_WATERFALL_LEVER_3,
    mission.Slot.D_WATERFALL_LEVER_4,
    mission.Slot.D_WATERFALL_LEVER_5,
    mission.Slot.D_SEWER_LEVER_0,
    mission.Slot.D_SEWER_LEVER_1,
    mission.Slot.D_SEWER_LEVER_2,
    mission.Slot.D_SEWER_LEVER_3,
    mission.Slot.D_SEWER_LEVER_4,
    mission.Slot.D_SEWER_LEVER_5
)

local function initialize_berth(context, state)
    context:activate_objects{slots = ACTIVE_OBJECTS, active = true}
    for _, slot in ipairs(CLOSED_DEVICES) do
        context:slot(slot):transition{
            transition = context.sdk.device_transitions.close,
            snap = true,
        }
    end
    berth_combat.start_scenes(context, state)
    -- The type-31 trigger holds this generation until its type-60 occupancy test passes.
    context:slot(mission.Slot.PT_FRONT_DOOR):fire_trigger()
end

-- Goes out when the player can see and move, not at the spawn.
local function show_opening_guidance(context, state)
    if not state:variable(BERTH_KEY) or not state:variable(PLAYING_KEY) then
        return
    end
    context:slot(mission.Slot.M_DIRECTIVE_SENSOR_80B48072):set_directive{
        directive = mission.Directive.ENTER_THE_ROYAL_POOLS,
    }
    context:slot(mission.Slot.M_DIALOG_SENSOR_80B48072):play_dialogue_cue{
        cue = mission.DialogueCue.M_DIALOG_SENSOR_80B48072.CUE_0,
    }
end

-- Every intent below is refused until the client holds the playable region.
local function enter_playable(context, state)
    if state:variable(BERTH_KEY) then
        return
    end
    context:set_variable(BERTH_KEY, true)
    initialize_berth(context, state)
    show_opening_guidance(context, state)
end

local function cinematic_phase(state)
    return state:variable(CINE_KEY) or CINE_IDLE
end

local function begin_entry_cinematic(context, state)
    -- The client holds the cutscene region, so only the Auth is owed.
    if cinematic_phase(state) ~= CINE_IDLE then
        return
    end
    context:set_variable(CINE_KEY, CINE_RUNNING)
    context:slot(mission.Slot.PF_CINEMATIC_BOOKEND_CINEMATIC):set_cinematic_active{active = true}
end

local function request_playable(context)
    entry_transition_request =
        context:select_state(BERTH_PLAYABLE_STATE, {retire_placed_props = true})
end

local function end_entry_cinematic(context, state)
    if cinematic_phase(state) == CINE_DONE then
        return
    end
    context:set_variable(CINE_KEY, CINE_DONE)
    -- Clear before the state change, or the rebuilt component replays the cutscene.
    context:slot(mission.Slot.PF_CINEMATIC_BOOKEND_CINEMATIC):set_cinematic_active{active = false}
    -- The state change also arms the teleport. Without the move no berth Auth can bind.
    request_playable(context)
end

return {
    -- The arrival names region 17, so the mission opens on the state that owns it. Bubble 2
    -- declares the entrance spawn set, so it answers the arrival and the move after the cutscene.
    -- The SDK names no spawn sets.
    initial_state = {
        region_index = BERTH_CINEMATIC_STATE.region_index,
        spawn_set_hash = 0x8029E4B4,
    },
    on_event_region_changed = function(context, state, event)
        if event.region_index == BERTH_CINEMATIC_STATE.region_index then
            begin_entry_cinematic(context, state)
        end
        if event.region_index == BERTH_PLAYABLE_STATE.region_index then
            enter_playable(context, state)
        end
    end,
    on_event_client_state_changed = function(context, state, event)
        -- The client zeroes its teleport byte inside the spawn call, so 0 marks the spawn.
        if event.teleport_state == context.sdk.client_teleport_reset then
            context:set_variable(SPAWNED_KEY, true)
        end
        -- The settle report moves no leg, spawn or teleport field. Control is back.
        if state:variable(SPAWNED_KEY) and not state:variable(PLAYING_KEY)
            and event.region_index == nil and event.current_region_index == nil
            and event.spawn_state == nil and event.teleport_state == nil then
            context:set_variable(PLAYING_KEY, true)
            show_opening_guidance(context, state)
        end
    end,
    on_event_squad_state = function(context, state, event)
        if state:variable(BERTH_KEY) then
            berth_combat.on_squad_state(context, state, event)
        end
    end,
    on_event_squad_provoked = function(context, state, event)
        if state:variable(BERTH_KEY) then
            berth_combat.on_squad_provoked(context, state, event)
        end
    end,
    on_event_damage_state = function(context, state, event)
        if state:variable(BERTH_KEY) then
            berth_combat.on_damage_state(context, state, event)
        end
    end,
    on_event_entity_died = function(context, state, event)
        if state:variable(BERTH_KEY) then
            berth_combat.on_entity_died(context, state, event)
        end
    end,
    -- End and refused start arrive here.
    on_event_cinematic_terminated = function(context, state, event)
        end_entry_cinematic(context, state)
    end,
    -- A skip request has its own event kind.
    on_event_cinematic_skip_requested = function(context, state, event)
        end_entry_cinematic(context, state)
    end,
    on_event_effect_result = function(context, state, event)
        if not entry_transition_request or not event.request_key
            or not event.request_key:matches(entry_transition_request) then
            return
        end
        entry_transition_request = nil
        if event.outcome == "refused" or event.outcome == "expired" then
            -- A refused cleanup must not prevent the player from spawning.
            context:select_state(BERTH_PLAYABLE_STATE)
        end
    end,
    on_load = function(context, state, event)
        -- A reattach lands in-world, so it must not replay the cutscene.
        if cinematic_phase(state) == CINE_DONE then
            if not state:variable(BERTH_KEY) then
                request_playable(context)
            end
        else
            end_entry_cinematic(context, state)
        end
    end,
    on_event_player_trigger = function(context, state, event)
        if lib.is_slot(context, event, mission.Slot.PT_FRONT_DOOR) then
            context:slot(mission.Slot.D_FRONT_DOOR):transition{
                transition = context.sdk.device_transitions.open,
                snap = false,
            }
        end
    end,
}
