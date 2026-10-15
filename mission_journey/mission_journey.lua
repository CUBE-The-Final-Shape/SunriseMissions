-- Adieu. Server scene and encounter port; live behavior remains unverified.
-- Injury effects, loadout grants and the two section teleports remain absent.
local missions = require("missions")
local mission = require(missions.MISSION_JOURNEY)
local campaign = require("lib.campaign")
local lib = require("lib.mission_lib")
local EventKind = require("sunrise.activity_sdk").EventKind
local unit, line = campaign.unit, campaign.line
local Slot, Squad, Directive, Scene = mission.Slot, mission.Squad, mission.Directive, mission.Scene
local cue = mission.DialogueCue.M_DIALOG_SENSOR_80B5E02A
local Input = mission.SceneInput
local pride = lib.one(Input.SC_PRIDE_ROCK.T_PRIDE_ROCK, "pride rock event")
local beast = lib.one(Input.SC_BEASTMASTER.KEY_286C14D7, "beastmaster event")

-- A scene id is longer than a variable name may be, so the key uses the scene's row.
local function scene_key(context, scene)
    return "journey.scene." .. context.attempt_generation .. "." .. context:scene(scene).row
end

local function start_scene(context, state, scene, props)
    local key = scene_key(context, scene)
    if state:variable(key) ~= nil then return end
    if props ~= nil then context:activate_objects{slots = props, active = true} end
    context:scene(scene):activate{}
    context:set_variable(key, true)
end

local function stop_scene(context, state, scene)
    local key = scene_key(context, scene)
    if state:variable(key) ~= true then return end
    context:scene(scene):stop{}
    context:set_variable(key, false)
end

local scenery = {
    {trigger = Slot.PT_SCENE_ROOFTOP, scene = Scene.SC_ROOFTOP_SCENE,
        inputs = lib.list(Input.SC_ROOFTOP_SCENE.PLAYER_TRIGGER,
            Input.SC_ROOFTOP_SCENE.KEY_5A9CAA14)},
    {trigger = Slot.PT_SCENE_ROOFTOP, scene = Scene.SC_REAL_ROOFTOP,
        inputs = lib.list(Input.SC_REAL_ROOFTOP.KEY_6A1120BD)},
    {trigger = Slot.PT_SCENE_TANK, scene = Scene.SC_BRIDGE_SCENE,
        inputs = lib.list(Input.SC_BRIDGE_SCENE.T_COMPLETE)},
    {trigger = Slot.PT_SHADOW_SCENE, scene = Scene.SC_SHADOW_SCENE,
        inputs = lib.list(Input.SC_SHADOW_SCENE.T_COMPLETE)},
    {trigger = Slot.PT_OMG_GOGOGO, scene = Scene.SC_OMG_WHAT_ZBB,
        inputs = lib.list(Input.SC_OMG_WHAT_ZBB.T_OMG_GOGOGO)},
    {trigger = Slot.PT_GHOST_EXIT_1, scene = Scene.SC_GHOST_SEARCHING,
        inputs = lib.list(Input.SC_GHOST_SEARCHING.T_GHOST_EXIT_1)},
    {trigger = Slot.PT_GHOST_EXIT_2, scene = Scene.SC_GHOST_SEARCHING,
        inputs = lib.list(Input.SC_GHOST_SEARCHING.T_GHOST_EXIT_2)},
    {trigger = Slot.PT_GHOST_EXIT_3, scene = Scene.SC_GHOST_SEARCHING,
        inputs = lib.list(Input.SC_GHOST_SEARCHING.T_GHOST_EXIT_3)},
    {trigger = Slot.PT_GHOST_FINDING, scene = Scene.SC_GHOST_FINDING,
        props = {Slot.O_GHOST_FINDING}},
    {trigger = Slot.PT_PLAYER_COLLAPSE, scene = Scene.SC_GHOST_FINDING,
        props = {Slot.O_GHOST_FINDING}, inputs = lib.list(Input.SC_GHOST_FINDING.KEY_86685186)},
    {trigger = Slot.PT_FALCON_CLIMB, scene = Scene.SC_FALCON_CLIMB_1,
        props = {Slot.O_FALCON_CLIMB_1}, inputs = lib.list(Input.SC_FALCON_CLIMB_1.T_FALCON_FLY)},
    {trigger = Slot.PT_FOLLOW_FALCON, scene = Scene.SC_FALCON_CLIMB_2,
        props = {Slot.O_FALCON_CLIMB_2}, inputs = lib.list(Input.SC_FALCON_CLIMB_2.KEY_F849C1B2)},
    {trigger = Slot.PT_FALCON_1, scene = Scene.SC_FALCON_1, props = {Slot.O_FALCON_1},
        inputs = lib.list(Input.SC_FALCON_1.T_FALCON_FLY)},
    {trigger = Slot.PT_FALCON_3, scene = Scene.SC_FALCON_3, props = {Slot.O_FALCON_3},
        inputs = lib.list(Input.SC_FALCON_3.T_FALCON_FLY)},
    {trigger = Slot.PT_FALCON_4, scene = Scene.SC_FALCON_4, props = {Slot.O_FALCON_4},
        inputs = lib.list(Input.SC_FALCON_4.KEY_F849C1B2)},
}
-- A nil scene would only fail once its trigger fires.
for _, action in ipairs(scenery) do lib.one(action.scene, "scenery scene") end

-- The burning City around the canal is dressed, not fought. These squads carry no objective.
local city = {
    id = "city",
    squads = {
        unit(Squad.SC_BRIDGE_1_SQUAD, Slot.SC_BRIDGE_1_SQUAD),
        unit(Squad.SC_BRIDGE_3_SQUAD, Slot.SC_BRIDGE_3_SQUAD),
        unit(Squad.SC_BRIDGE_5_SQUAD, Slot.SC_BRIDGE_5_SQUAD),
        unit(Squad.SC_BRIDGE_7_SQUAD, Slot.SC_BRIDGE_7_SQUAD),
        unit(Squad.SC_BRIDGE_TANK_SQUAD, Slot.SC_BRIDGE_TANK_SQUAD),
        unit(Squad.SC_BRIDGE_TANK_SQUAD_1, Slot.SC_BRIDGE_TANK_SQUAD_1),
        unit(Squad.SC_BRIDGE_TANK_SQUAD_2, Slot.SC_BRIDGE_TANK_SQUAD_2),
        unit(Squad.SC_ROOFTOP_01_SQUAD, Slot.SC_ROOFTOP_01_SQUAD),
        unit(Squad.SC_ROOFTOP_02_SQUAD, Slot.SC_ROOFTOP_02_SQUAD),
        unit(Squad.SC_ROOFTOP_03_SQUAD, Slot.SC_ROOFTOP_03_SQUAD),
        unit(Squad.SC_ROOFTOP_04_SQUAD, Slot.SC_ROOFTOP_04_SQUAD),
        unit(Squad.SC_ROOFTOP_05_SQUAD, Slot.SC_ROOFTOP_05_SQUAD),
        unit(Squad.SC_ROOFTOP_06_SQUAD, Slot.SC_ROOFTOP_06_SQUAD),
        unit(Squad.SQ_WALK_BY_1, Slot.SQ_WALK_BY_1),
        unit(Squad.SQ_WALK_BY_2, Slot.SQ_WALK_BY_2),
        unit(Squad.SC_SHADOW_TANK_SQUAD_1, Slot.SC_SHADOW_TANK_SQUAD_1),
        unit(Squad.SC_SHADOW_TANK_SQUAD_2, Slot.SC_SHADOW_TANK_SQUAD_2),
        unit(Squad.SC_SHADOW_TANK_SQUAD_3, Slot.SC_SHADOW_TANK_SQUAD_3),
        unit(Squad.SC_REAL_ROOFTOP_1, Slot.SC_REAL_ROOFTOP_1),
        unit(Squad.SC_REAL_ROOFTOP_2, Slot.SC_REAL_ROOFTOP_2),
        unit(Squad.SC_REAL_ROOFTOP_3, Slot.SC_REAL_ROOFTOP_3),
        unit(Squad.SC_REAL_ROOFTOP_4, Slot.SC_REAL_ROOFTOP_4),
        unit(Squad.SC_REAL_ROOFTOP_6, Slot.SC_REAL_ROOFTOP_6),
        unit(Squad.SC_REAL_ROOFTOP_7, Slot.SC_REAL_ROOFTOP_7),
        unit(Squad.SC_REAL_ROOFTOP_8, Slot.SC_REAL_ROOFTOP_8),
        unit(Squad.SQ_OMG_WALKER_1, Slot.SQ_OMG_WALKER_1),
        unit(Squad.SQ_OMG_WALKER_2, Slot.SQ_OMG_WALKER_2),
        unit(Squad.SQ_OMG_WALKER_3, Slot.SQ_OMG_WALKER_3),
        unit(Squad.SQ_OMG_WALKER_4, Slot.SQ_OMG_WALKER_4),
        unit(Squad.SQ_OMG_JUMPER_1, Slot.SQ_OMG_JUMPER_1),
        unit(Squad.SQ_OMG_JUMPER_2, Slot.SQ_OMG_JUMPER_2),
        unit(Squad.SQ_OMG_JUMPER_3, Slot.SQ_OMG_JUMPER_3),
        unit(Squad.SQ_OMG_JUMPER_4, Slot.SQ_OMG_JUMPER_4),
        unit(Squad.SQ_SAD_GHOST_1, Slot.SQ_SAD_GHOST_1),
        unit(Squad.SQ_SAD_GHOST_2, Slot.SQ_SAD_GHOST_2),
    },
    on_start = function(context, state)
        start_scene(context, state, Scene.SC_GHOST_SEARCHING)
    end,
}

-- The climb starts where the falcon first lands.
local climb = {
    id = "climb",
    after = "camp_combat",
    objective = Slot.OBJ_CLIMB_BEASTS,
    squads = {
        unit(Squad.SQ_CLIMB_BEAST_PRIME, Slot.SQ_CLIMB_BEAST_PRIME),
        unit(Squad.SQ_CLIMB_BEAST_A, Slot.SQ_CLIMB_BEAST_A),
        unit(Squad.SQ_CLIMB_BEAST_A_1, Slot.SQ_CLIMB_BEAST_A_1),
        unit(Squad.SQ_CLIMB_BEAST_B, Slot.SQ_CLIMB_BEAST_B),
        unit(Squad.SQ_CLIMB_BEAST_B_1, Slot.SQ_CLIMB_BEAST_B_1),
        unit(Squad.SQ_CLIMB_BEAST_C, Slot.SQ_CLIMB_BEAST_C),
        unit(Squad.SQ_CLIMB_BEAST_C_1, Slot.SQ_CLIMB_BEAST_C_1),
        unit(Squad.SQ_CLIMB_BEAST_D, Slot.SQ_CLIMB_BEAST_D),
        unit(Squad.SQ_CLIMB_BEAST_D_1, Slot.SQ_CLIMB_BEAST_D_1),
        unit(Squad.SQ_CLIMB_BEAST_E, Slot.SQ_CLIMB_BEAST_E),
        unit(Squad.SQ_CLIMB_BEAST_E_1, Slot.SQ_CLIMB_BEAST_E_1),
        unit(Squad.SQ_CLIMB_BEAST_F, Slot.SQ_CLIMB_BEAST_F),
        unit(Squad.SQ_CLIMB_BEAST_F_1, Slot.SQ_CLIMB_BEAST_F_1),
    },
    on_start = function(context, state)
        start_scene(context, state, Scene.SC_PRIDE_ROCK)
        context:scene(Scene.SC_PRIDE_ROCK):send_event{key = pride}
    end,
}

-- The dead Guardians on the climb.
local guardians = {
    id = "guardians",
    trigger = Slot.PT_CLIMB_FLYOVER,
    squads = {
        unit(Squad.SQ_HARVEY_1, Slot.SQ_HARVEY_1),
        unit(Squad.SQ_HARVEY_2, Slot.SQ_HARVEY_2),
        unit(Squad.SQ_HARVEY_3, Slot.SQ_HARVEY_3),
        unit(Squad.SQ_HARVEY_4, Slot.SQ_HARVEY_4),
    },
}

-- The beast bowl lies between the canyon goto and Hawthorne's goto; it can be skipped.
local beasts = {
    id = "beasts",
    trigger = Slot.PT_BEAST,
    objective = Slot.OBJ_BOWL_BEAST,
    squads = {
        unit(Squad.BEAST_WARBEAST_0_SQUAD, Slot.BEAST_WARBEAST_0_SQUAD),
        unit(Squad.BEAST_WARBEAST_1A_SQUAD, Slot.BEAST_WARBEAST_1A_SQUAD),
        unit(Squad.BEAST_WARBEAST_1B_SQUAD, Slot.BEAST_WARBEAST_1B_SQUAD),
        unit(Squad.BEAST_WARBEAST_2_SQUAD, Slot.BEAST_WARBEAST_2_SQUAD),
        unit(Squad.BEAST_WARBEAST_2A_SQUAD, Slot.BEAST_WARBEAST_2A_SQUAD),
        unit(Squad.BEAST_WARBEAST_3_SQUAD, Slot.BEAST_WARBEAST_3_SQUAD),
        unit(Squad.BEAST_WARBEAST_3A_SQUAD, Slot.BEAST_WARBEAST_3A_SQUAD),
        unit(Squad.BEAST_WARBEAST_4_SQUAD, Slot.BEAST_WARBEAST_4_SQUAD),
        unit(Squad.BEAST_WARBEAST_4A_SQUAD, Slot.BEAST_WARBEAST_4A_SQUAD),
        unit(Squad.BEAST_WARBEAST_5_SQUAD, Slot.BEAST_WARBEAST_5_SQUAD),
        unit(Squad.BEAST_WARBEAST_5A_SQUAD, Slot.BEAST_WARBEAST_5A_SQUAD),
        unit(Squad.SQ_BOWL_LEGS, Slot.SQ_BOWL_LEGS),
        unit(Squad.SQ_BOWL_LEGS_1, Slot.SQ_BOWL_LEGS_1),
    },
    on_start = function(context, state)
        start_scene(context, state, Scene.SC_BEASTMASTER)
        context:scene(Scene.SC_BEASTMASTER):send_event{key = beast}
    end,
}

local script = campaign.new{
    key = "journey",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80B5E02A,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80B5E02A,
    intro = {
        {state = mission.states.STATE_80B5E01F_0003_0001_80B5E019,
            cinematic = Slot.INTRO_CINEMATIC_CINEMATIC},
    },
    outro = {
        {state = mission.states.STATE_80B5E01F_0003_0002_80B5E01A,
            cinematic = Slot.MID_A_CINEMATIC_CINEMATIC},
        {state = mission.states.STATE_80B5E01F_0003_0003_80B5E01E,
            cinematic = Slot.MID_B_CINEMATIC_CINEMATIC},
    },
    legs = {
        {id = "the_walk", state = mission.states.STATE_80B5E01F_0003_0000_80B5E018, arm = {
            Slot.PT_GHOST_FINDING, Slot.PT_GOTO_CLIMB, Slot.PT_FALCON_CLIMB,
            Slot.PT_DLG_CITY_EXIT,
            Slot.PT_CLIMB_FLYOVER, Slot.PT_FIND_GUARDIANS_HIGH, Slot.PT_GOTO_MOUNTAIN,
            Slot.PT_GOTO_CANYON, Slot.PT_BEAST, Slot.PT_GOTO_HAW, Slot.PT_END_NAV,
            Slot.PT_GOTO_ARRIVAL,
            Slot.PT_SCENE_ROOFTOP, Slot.PT_SCENE_TANK, Slot.PT_SHADOW_SCENE, Slot.PT_OMG_GOGOGO,
            Slot.PT_GHOST_EXIT_1, Slot.PT_GHOST_EXIT_2, Slot.PT_GHOST_EXIT_3,
            Slot.PT_PLAYER_COLLAPSE, Slot.PT_FOLLOW_FALCON,
            Slot.PT_FALCON_1, Slot.PT_FALCON_3, Slot.PT_FALCON_4,
        }},
    },
    steps = {
        -- The Ghost searches the canal: "Guardian? Where are you? Can you hear me?"
        {id = "ghost", directive = Directive.FIND_YOUR_GHOST,
            lines = {line(cue.CUE_1)},
            ends = {trigger = Slot.PT_GHOST_FINDING}},
        -- "You're alive." The Light is gone, then the emergency broadcast at the canal exit.
        {id = "canal", directive = Directive.REGROUP, navpoint = Slot.SLOT_0011_80B5E3F3,
            lines = {line(cue.CUE_14), line(cue.CUE_15), line(cue.CUE_16),
                line(cue.CUE_20, Slot.TV_DLG_CITY_EXIT)},
            ends = {trigger = Slot.PT_GOTO_CLIMB}},
        {id = "rally", directive = Directive.REGROUP, navpoint = Slot.AP_DEAD_GUARDIANS,
            on_start = function(context, state)
                stop_scene(context, state, Scene.SC_GHOST_SEARCHING)
                stop_scene(context, state, Scene.SC_GHOST_FINDING)
                context:activate_objects{slots = {Slot.O_GHOST_FINDING, Slot.O_GHOST_SEARCHING},
                    active = false}
                start_scene(context, state, Scene.SC_FALCON_CLIMB_1, {Slot.O_FALCON_CLIMB_1})
                start_scene(context, state, Scene.SC_FALCON_CLIMB_2, {Slot.O_FALCON_CLIMB_2})
            end,
            ends = {trigger = Slot.PT_FIND_GUARDIANS_HIGH}},
        -- "These Guardians... They had no chance without their powers."
        {id = "gun", directive = Directive.ARM_YOURSELF, navpoint = Slot.AP_GET_GUN,
            lines = {line(cue.CUE_24), line(cue.CUE_27)},
            barrier = true,
            ends = {interact = Slot.O_AUTO_RIFLE}},
        {id = "camp_combat", barrier = true, ends = {clear = "climb"}},
        {id = "falcon", directive = Directive.FOLLOW_YOUR_VISION_B4B4B71D,
            navpoint = Slot.SLOT_000B_80B5E415,
            ends = {trigger = Slot.PT_GOTO_MOUNTAIN}},
        -- "It's that falcon again. Is it following us?"
        {id = "mountain", directive = Directive.FOLLOW_YOUR_VISION_ABA9EFFB,
            navpoint = Slot.AP_GOTO_CANYON,
            on_start = function(context, state)
                start_scene(context, state, Scene.SC_FALCON_1, {Slot.O_FALCON_1})
                start_scene(context, state, Scene.SC_FALCON_3, {Slot.O_FALCON_3})
                start_scene(context, state, Scene.SC_FALCON_4, {Slot.O_FALCON_4})
            end,
            lines = {line(cue.CUE_28, Slot.SLOT_0008_80B5E434)},
            ends = {trigger = Slot.PT_GOTO_CANYON}},
        {id = "bowl", directive = Directive.FOLLOW_YOUR_VISION_CA83E2E7,
            navpoint = Slot.AP_GOTO_HAW,
            ends = {trigger = Slot.PT_GOTO_HAW}},
        {id = "canyon", directive = Directive.FOLLOW_YOUR_VISION, navpoint = Slot.AP_HAWTHORNE,
            lines = {line(cue.CUE_29)},
            ends = {trigger = Slot.PT_GOTO_ARRIVAL}},
    },
    encounters = {city, climb, guardians, beasts},
}

local handle_trigger = script.on_event_player_trigger
script.on_event_player_trigger = function(context, state, event)
    handle_trigger(context, state, event)
    if event.attempt_generation ~= context.attempt_generation
        or event.kind ~= EventKind.PLAYER_TRIGGER
        or state:variable("flow.journey.step.outro") ~= nil then return end
    for index, action in ipairs(scenery) do
        local key = "journey.scenery." .. context.attempt_generation .. "." .. index
        if state:variable(key) == nil and lib.is_slot(context, event, action.trigger) then
            context:set_variable(key, true)
            start_scene(context, state, action.scene, action.props)
            if state:variable(scene_key(context, action.scene)) == true then
                for _, input in ipairs(action.inputs or {}) do
                    context:scene(action.scene):send_event{key = input}
                end
            end
        end
    end
end

return script
