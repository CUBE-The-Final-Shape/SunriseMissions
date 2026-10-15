-- Haunted Forest entry port; round progression remains absent and live behavior is unverified.
-- Capture uses eight seconds of accepted plate occupancy as host policy.
-- Generator arena exclusion, generated-enemy scoring, round travel and rewards are absent.
local missions = require("missions")
local mission = require(missions.INFINITE_ABYSS)
local lib = require("lib.mission_lib")
local EventKind = require("sunrise.activity_sdk").EventKind
local Slot, Directive = mission.Slot, mission.Directive
local REGION = mission.states.STATE_81550015_000D_0000_8155000E.region_index
local SPAWN_SET = 0x79E3AB1F
local CAPTURE_MS = 8000
local TIMER = "abyss.capture"
local OWNER, PHASE, INSIDE, ARRIVED, TIMER_SEQUENCE = "abyss.owner", "abyss.phase",
    "abyss.inside", "abyss.arrived", "abyss.capture_sequence"
local PLATE = Slot.PF_SIDE_PLATFORM_0_PM_CAPTURE_PLATE
local DEVICE = Slot.PF_SIDE_PLATFORM_0_D_CAPTURE_PLATE
local SUCCESS = Slot.PF_SIDE_PLATFORM_0_O_SYNC_PLATE_SUCCESS

local function position(context, value)
    context:slot(DEVICE):set_channel{
        channel = context.sdk.device_channels.position, value = context.sdk.unit(value),
    }
end

local function stop_capture(context)
    context:cancel_timer(TIMER)
    context:clear_variable(TIMER_SEQUENCE)
end

local function prepare(context, state)
    if state:variable(OWNER) == context.attempt_generation then return end
    context:set_variable(OWNER, context.attempt_generation)
    context:set_variable(PHASE, "entry")
    context:clear_variable(INSIDE)
    context:clear_variable(ARRIVED)
    stop_capture(context)
    context:activate_objects{slots = {
        Slot.PF_SIDE_PLATFORM_0_O_PLATFORM_0, Slot.PF_SIDE_PLATFORM_0_O_PLATFORM_1,
        Slot.PF_SIDE_PLATFORM_0_O_CAPTURE_PLATE,
    }, active = true}
    context:activate_objects{slots = {SUCCESS}, active = false}
    position(context, 0.2)
    context:slot(PLATE):set_occupancy_condition{value = 1}
    context:slot(Slot.M_DIRECTIVE_SENSOR):set_directive{
        directive = Directive.ENTER_THE_HAUNTED_FOREST,
        waypoint = context:slot(Slot.PF_SIDE_PLATFORM_0_TV_CAPTURE_PLATE),
    }
end

local function capture_if_occupied(context, state)
    if state:variable(PHASE) ~= "entry" or state:variable(INSIDE) ~= true
        or state:variable(ARRIVED) ~= true or state:variable(TIMER_SEQUENCE) ~= nil then return end
    position(context, 0.1)
    context:set_variable(TIMER_SEQUENCE, context:start_timer(TIMER, CAPTURE_MS))
end

local function enter(context, state, event)
    if event.attempt_generation ~= context.attempt_generation then return end
    prepare(context, state)
    local region = event.kind == EventKind.REGION_CHANGED and event.region_index
        or (event.entered == true and event.held_region_index or nil)
    if region == nil then return end
    context:set_variable(ARRIVED, region == REGION)
    if region ~= REGION then
        context:clear_variable(INSIDE)
        stop_capture(context)
    else
        capture_if_occupied(context, state)
    end
end

local function occupy(context, state, event)
    if event.attempt_generation ~= context.attempt_generation
        or not lib.is_slot(context, event, PLATE) then return end
    prepare(context, state)
    if state:variable(PHASE) ~= "entry" then return end
    local inside = event.kind == EventKind.TRIGGER_ENTERED
    context:set_variable(INSIDE, inside)
    if inside then
        capture_if_occupied(context, state)
    else
        stop_capture(context)
        position(context, 0.2)
    end
end

local function captured(context, state, event)
    if event.attempt_generation ~= context.attempt_generation or event.timer_name ~= TIMER
        or event.timer_sequence ~= state:variable(TIMER_SEQUENCE)
        or state:variable(PHASE) ~= "entry" or state:variable(INSIDE) ~= true
        or state:variable(ARRIVED) ~= true then return end
    context:clear_variable(TIMER_SEQUENCE)
    context:set_variable(PHASE, "traversal")
    context:activate_objects{slots = {SUCCESS}, active = true}
    local seed = tonumber(context.attempt_generation) % 0x7FFFFFFF
    context:slot(Slot.MAP_GENERATOR_SENSOR):generate_map{
        seed = seed > 0 and seed or 1, enabled = true,
    }
    context:slot(Slot.M_DIRECTIVE_SENSOR):set_directive{
        directive = Directive.CLEAR_THE_HAUNTED_FOREST,
    }
end

return {
    initial_state = {region_index = REGION, spawn_set_hash = SPAWN_SET, omit = {SUCCESS}},
    on_start = prepare,
    on_load = prepare,
    on_event_region_changed = enter,
    on_event_client_state_changed = enter,
    on_event_trigger_entered = occupy,
    on_event_trigger_exited = occupy,
    on_event_timer_elapsed = captured,
}
