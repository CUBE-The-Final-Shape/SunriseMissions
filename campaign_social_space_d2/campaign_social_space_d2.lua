local missions = require("missions")
local mission = require(missions.CAMPAIGN_SOCIAL_SPACE_D2)
local lib = require("lib.mission_lib")

-- The Farm. One bubble, one authored state, region 0.
-- Squads first, then the state: the rest binds under its lease.
-- A paired scene over the same anchors is one place twice. One group per place.

local FARM_STATE = lib.one(mission.states.STATE_80B84013_0000_0000_80B84012, "farm state")

local SQUADS = lib.list(
    -- barn: desks, mechanics, the porch and the archivist rooms below it
    mission.Squad.DAY_ARCHIVIST_INDOOR_1_SQUAD,
    mission.Squad.DAY_ARCHIVIST_INDOOR_2_SQUAD,
    mission.Squad.DAY_BARN_CIV_3_SQUAD,
    mission.Squad.DAY_BARN_DESK_1_SQUAD,
    mission.Squad.DAY_BARN_DESK_3_SQUAD,
    mission.Squad.DAY_BARN_DESK_4_SQUAD,
    mission.Squad.DAY_BARN_DESK_5_SQUAD,
    mission.Squad.DAY_BARN_MECHS_2_SQUAD,
    mission.Squad.DAY_BARN_MECHS_3_SQUAD,
    mission.Squad.DAY_BARN_MECHS_4_SQUAD,
    mission.Squad.DAY_BARN_MECHS_5_SQUAD,
    mission.Squad.DAY_BARN_MECHS_6A_SQUAD,
    mission.Squad.DAY_BARN_MECHS_6B_SQUAD,
    mission.Squad.DAY_BARN_MECHS_7A_SQUAD,
    mission.Squad.DAY_BARN_MECHS_7B_SQUAD,
    mission.Squad.DAY_BARN_PORCH_1_SQUAD,
    mission.Squad.DAY_BARN_PORCH_3_SQUAD,
    mission.Squad.GUARANTEED_BARN_GUARD_1_SQUAD,
    mission.Squad.GUARANTEED_MECH_SUPERVISOR_1_SQUAD,

    -- landing dock and the firepit beside it
    mission.Squad.DAY_DOCK_MECH_1_SQUAD,
    mission.Squad.DAY_DOCK_MECH_2_SQUAD,
    mission.Squad.DAY_DOCK_PAIR_1_PAIRED_NPC_STATE_MACHINE_1_SQUAD,
    mission.Squad.DAY_DOCK_PAIR_1_PAIRED_NPC_STATE_MACHINE_2_SQUAD,
    mission.Squad.SQUAD_2,
    mission.Squad.SQUAD_3,

    -- garage, two groups at four posts
    mission.Squad.DAY_GARAGE_1_SQUAD_80B84407,
    mission.Squad.DAY_GARAGE_2_SQUAD_80B84407,
    mission.Squad.DAY_GARAGE_1_SQUAD_80B8440E,
    mission.Squad.DAY_GARAGE_2_SQUAD_80B8440E,

    -- indoor command room and the Redjack bay
    mission.Squad.INDOOR_COMMAND_1A_SQUAD,
    mission.Squad.INDOOR_COMMAND_1B_SQUAD,
    mission.Squad.INDOOR_COMMAND_2A_SQUAD,
    mission.Squad.INDOOR_COMMAND_2B_SQUAD,
    mission.Squad.REDJACK_REPAIR_A_SQUAD,
    mission.Squad.REDJACK_REPAIR_B_SQUAD,

    -- field, roofs and the foreman's audience
    mission.Squad.DAY_GRASS_WALKERS_1_SQUAD,
    mission.Squad.DAY_GRASS_WALKERS_5_SQUAD,
    mission.Squad.DAY_ROOF_SOLO_1_SQUAD,
    mission.Squad.DAY_ROOF_SOLO_2_SQUAD,
    mission.Squad.GUARANTEED_FOREMAN_SQUAD,
    mission.Squad.GUARANTEED_FOREMAN_AUDIENCE_1_SQUAD,
    mission.Squad.GUARANTEED_FOREMAN_AUDIENCE_2_SQUAD,
    mission.Squad.CLEANER_TALKER_SQUAD_80B8477A,
    mission.Squad.CLEANER_TALKER_SQUAD_80B84792,
    mission.Squad.CLEANER_TALKER_B_SQUAD,

    -- 80B845F6 is the away team's second scene at the same two anchors. Group A only.
    mission.Squad.SQ_WORKER_1_80B845C8,
    mission.Squad.SQ_WORKER_2_80B845C8,

    -- 80B84773 is the walk's second scene at the same three anchors. Group 1 only.
    mission.Squad.SQ_WORKER_1_80B84746,
    mission.Squad.SQ_WORKER_2_80B84746,
    mission.Squad.SQ_WORKER_3_80B84746,

    -- refugees and the guard who logs them in
    mission.Squad.SQ_ARRIVAL_DOCUMENTER,
    mission.Squad.SQ_SURVIVOR1,
    mission.Squad.SQ_SURVIVOR2,
    mission.Squad.SQ_SURVIVOR3,
    mission.Squad.SQ_SURVIVOR4,

    -- vendors. The client builds none of them itself.
    mission.Squad.SQ_ZAVALA,
    mission.Squad.SQ_IKORA,
    mission.Squad.SQ_CAYDE,
    mission.Squad.SQ_ARTIE,
    mission.Squad.SQ_CRUCIBLE,
    mission.Squad.SQ_CRYPTARCH,
    mission.Squad.SQ_HAWTHORNE,
    mission.Squad.SQ_POSTMASTER,
    mission.Squad.SQ_EVERVERSE
)

local OBJECTS = lib.list(
    -- vendor plaza dressing and its three frames
    mission.Slot.O_FALCON_1,
    mission.Slot.O_SHAXX_BANNER_1,
    mission.Slot.O_SHAXX_BANNER_2,
    mission.Slot.O_REDJACK_GUARD_1,
    mission.Slot.O_REDJACK_GUARD_2,
    mission.Slot.O_REDJACK_GUARD_3,
    mission.Slot.POT_CIVILIAN_FEM02_DATAPAD_STAND,

    -- the two cleaner circles behind the foreman
    mission.Slot.O_CLEANER_1_80B8477A,
    mission.Slot.O_CLEANER_2_80B8477A,
    mission.Slot.O_CLEANER_3_80B8477A,
    mission.Slot.O_CLEANER_4_80B8477A,
    mission.Slot.O_CLEANER_5_80B8477A,
    mission.Slot.O_CLEANER_6_80B8477A,
    mission.Slot.O_CLEANER_1_80B84792,
    mission.Slot.O_CLEANER_2_80B84792,
    mission.Slot.O_CLEANER_3_80B84792,
    mission.Slot.O_CLEANER_4_80B84792,
    mission.Slot.O_CLEANER_5_80B84792,
    mission.Slot.O_CLEANER_6_80B84792,

    -- welders. Each group is its own bay; a repeated animation name is not one actor twice.
    mission.Slot.POT_CIV_MAINT_FEM01_WELD_FORWARD_1_80B849F4,
    mission.Slot.POT_CIV_MAINT_MALE01_DPAD_TYPING_STAND_1,
    mission.Slot.POT_CIV_MAINT_MALE02_WELD_DOWN_1_80B849F4,
    mission.Slot.POT_CIV_MAINT_FEM02_WELD_UP_1,
    mission.Slot.POT_CIV_MAINT_FEM01_WELD_FORWARD_1_80B84A04,
    mission.Slot.POT_CIV_MAINT_MALE02_WELD_DOWN_1_80B84A04,
    mission.Slot.POT_CIV_MAINT_FEM01_WELD_DOWN_1,
    mission.Slot.POT_CIV_MAINT_FEM01_WELD_FORWARD_2,

    -- the hawk each kept scene carries
    mission.Slot.O_HAWK_AWAY_TEAM_80B845C8,
    mission.Slot.O_HAWK_AWAY_TEAM_80B84746,
    mission.Slot.O_SOCCER_HAWK,

    -- the ball. Its goals, scoreboards and flares stay out: nothing keeps score.
    mission.Slot.O_MILITARY_FOOTBALL
)

-- TODO: drive the Vertigo course (80B849B3 orbs and waypoints); no script owns its stages yet.
-- TODO: drive the field's goals and scoreboards (80B847F7); no script owns the score yet.
-- TODO: place 80B847EC's ship and commando once the farm cinematics are understood.
-- TODO: name 80B84A18's four objects before activating them.

local SCENES = lib.list(
    mission.Scene.SC_FIREPLACE_TRIO_FOCUS,
    mission.Scene.DAY_GRASS_WALKERS_1_SCENE,
    mission.Scene.DAY_GRASS_WALKERS_5_SCENE,
    mission.Scene.FARM_AWAY_TEAM_A,
    mission.Scene.FARM_SOCCER_HAWK_FLIGHT,
    mission.Scene.ARRIVAL_SCENE,
    mission.Scene.FARM_WORKERS_WALK_1
)

-- A sensor holds one state. Where the data authors several, the first ordinal is the idle.
local function idle(name, sensor, state)
    return {sensor = lib.one(sensor, name .. " sensor"), state = lib.one(state, name .. " idle")}
end

local IDLES = lib.list(
    idle("zavala", mission.Slot.SQ_ZAVALA_IDLE,
        mission.PerformanceState.SQ_ZAVALA_IDLE.STATE_08BA6CD2),
    idle("ikora", mission.Slot.SQ_IKORA_IDLE,
        mission.PerformanceState.SQ_IKORA_IDLE.STATE_C7D3EBEA),
    idle("cayde", mission.Slot.SQ_CAYDE_IDLE,
        mission.PerformanceState.SQ_CAYDE_IDLE.STATE_11D3E6E3),
    idle("artie", mission.Slot.SQ_ARTIE_IDLE,
        mission.PerformanceState.SQ_ARTIE_IDLE.STATE_806FF3C1),
    idle("crucible", mission.Slot.SQ_CRUCIBLE_IDLE,
        mission.PerformanceState.SQ_CRUCIBLE_IDLE.STATE_D9474D64),
    idle("cryptarch", mission.Slot.SQ_CRYPTARCH_IDLE,
        mission.PerformanceState.SQ_CRYPTARCH_IDLE.STATE_BDA20EE3),
    idle("hawthorne", mission.Slot.SQ_HAWTHORNE_IDLE,
        mission.PerformanceState.SQ_HAWTHORNE_IDLE.STATE_FD41C0E5),
    idle("postmaster", mission.Slot.SQ_POSTMASTER_IDLE,
        mission.PerformanceState.SQ_POSTMASTER_IDLE.STATE_870A7D66)
)

-- The Eververse sensor has no authored state, so that vendor gets no idle request.

-- A reattach reopens this script in a fresh VM, so the mark lives in mission state.
local BUILT_KEY = "farm_built"

local function build(context)
    lib.place_all(context, SQUADS, context.sdk.squad_modes.reinforce)
    context:select_state(FARM_STATE)
    context:activate_objects{slots = OBJECTS, active = true}
    lib.activate_scenes(context, SCENES)
    lib.play_idles(context, IDLES)
end

return {
    on_event_region_changed = function(context, state, event)
        if event.region_index ~= FARM_STATE.region_index or state:variable(BUILT_KEY) then
            return
        end
        context:set_variable(BUILT_KEY, true)
        build(context)
    end,
}
