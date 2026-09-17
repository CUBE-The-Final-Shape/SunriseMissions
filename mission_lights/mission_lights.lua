-- Riptide. Red War campaign draft; not tested in game.
-- Leg order: base -> platform -> generator, from the trigger volume positions. Steps follow the
-- step objects and their lines: the console, the walk out to the converters, the pistons, the
-- circuit breaker.
local missions = require("missions")
local mission = require(missions.MISSION_LIGHTS)
local campaign = require("lib.campaign")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive = mission.Slot, mission.Squad, mission.Directive
local cue = mission.DialogueCue.M_DIALOG_SENSOR

-- "Did we lead the Fallen here?" Both platform groups start at the platform entry.
local platform_fallen = {
    id = "platform_fallen",
    trigger = Slot.MISSION_LIGHTS_025_DIALOG_START_TRIGGER,
    objective = Slot.FALLEN_OBJECTIVE_80B3F2B6,
    squads = {
        unit(Squad.FALLEN_BASE_INF01_SQUAD, Slot.FALLEN_BASE_INF01_SQUAD),
        unit(Squad.FALLEN_GENERATOR_INF01_SQUAD, Slot.FALLEN_GENERATOR_INF01_SQUAD),
        unit(Squad.FALLEN_GENERATOR_INF02_SQUAD, Slot.FALLEN_GENERATOR_INF02_SQUAD),
        unit(Squad.FALLEN_GENERATOR_DROPSHIP_SQUAD, Slot.FALLEN_GENERATOR_DROPSHIP_SQUAD),
    },
}

local platform_hive = {
    id = "platform_hive",
    trigger = Slot.MISSION_LIGHTS_025_DIALOG_START_TRIGGER,
    objective = Slot.HIVE_OBJECTIVE,
    squads = {
        unit(Squad.HIVE_BASE_INF01_SQUAD, Slot.HIVE_BASE_INF01_SQUAD),
        unit(Squad.HIVE_GENERATOR_INF01_SQUAD, Slot.HIVE_GENERATOR_INF01_SQUAD),
        unit(Squad.HIVE_GENERATOR_INF02_SQUAD, Slot.HIVE_GENERATOR_INF02_SQUAD),
        unit(Squad.HIVE_GENERATOR_SHRIEKER01_SQUAD, Slot.HIVE_GENERATOR_SHRIEKER01_SQUAD),
    },
}

-- The corridor groups past the platform carry no encounter objective.
local corridors = {
    id = "corridors",
    trigger = Slot.FALLEN_CORRIDORS_VANDALS_SPAWN_TRIGGER,
    squads = {
        unit(Squad.FALLEN_CORRIDORS_INF01_SQUAD, Slot.FALLEN_CORRIDORS_INF01_SQUAD),
        unit(Squad.FALLEN_CORRIDORS_INF02_SQUAD, Slot.FALLEN_CORRIDORS_INF02_SQUAD),
        unit(Squad.FALLEN_AMBIENT1_DROPSHIP_SQUAD, Slot.FALLEN_AMBIENT1_DROPSHIP_SQUAD),
        unit(Squad.FALLEN_AMBIENT2_DROPSHIP_SQUAD, Slot.FALLEN_AMBIENT2_DROPSHIP_SQUAD),
    },
}

local exploder_intro = {
    id = "exploder_intro",
    trigger = Slot.FALLEN_EXPLODER_INTRO_SCENE_START_TRIGGER,
    squads = {
        unit(Squad.HIVE_FALLEN_EXPLODER_INTRO_SCENE_INF01_SQUAD,
             Slot.HIVE_FALLEN_EXPLODER_INTRO_SCENE_INF01_SQUAD),
        unit(Squad.HIVE_FALLEN_EXPLODER_INTRO_SCENE_INF02_SQUAD,
             Slot.HIVE_FALLEN_EXPLODER_INTRO_SCENE_INF02_SQUAD),
        unit(Squad.HIVE_FALLEN_EXPLODER_INTRO_SCENE_INF03_SQUAD,
             Slot.HIVE_FALLEN_EXPLODER_INTRO_SCENE_INF03_SQUAD),
        unit(Squad.FALLEN_FALLEN_EXPLODER_INTRO_SCENE_SHANK01_SQUAD,
             Slot.FALLEN_FALLEN_EXPLODER_INTRO_SCENE_SHANK01_SQUAD),
        unit(Squad.FALLEN_FALLEN_EXPLODER_INTRO_SCENE_SHANK02_SQUAD,
             Slot.FALLEN_FALLEN_EXPLODER_INTRO_SCENE_SHANK02_SQUAD),
    },
}

local corridor_exploders = {
    id = "corridor_exploders",
    trigger = Slot.FALLEN_CORRIDORS_EXPLODERS01_SPAWN_TRIGGER,
    squads = {
        unit(Squad.FALLEN_CORRIDORS_EXPLODERS01_SQUAD, Slot.FALLEN_CORRIDORS_EXPLODERS01_SQUAD),
    },
}

local transformers = {
    id = "transformers",
    trigger = Slot.INTERIOR_FALLEN_TRANSFORMERS_TRIGGER,
    on_start = function(context)
        move(context, {Slot.INTERIOR_SWITCH_DOOR_DEVICE, Slot.INTERIOR_FALLEN_DOOR_HACKER_DEVICE,
            Slot.INTERIOR_BASEMENT_DOOR_DEVICE}, "open")
    end,
    squads = {
        unit(Squad.FALLEN_INT_SWITCH01_SQUAD, Slot.FALLEN_INT_SWITCH01_SQUAD),
        unit(Squad.FALLEN_INT_SWITCH02_SQUAD, Slot.FALLEN_INT_SWITCH02_SQUAD),
        unit(Squad.FALLEN_INT_DOOR_OPENER01_SQUAD, Slot.FALLEN_INT_DOOR_OPENER01_SQUAD),
        unit(Squad.FALLEN_INT_DOOR_OPENER02_SQUAD, Slot.FALLEN_INT_DOOR_OPENER02_SQUAD),
        unit(Squad.FALLEN_INT_TRANSFORMERS01_SQUAD, Slot.FALLEN_INT_TRANSFORMERS01_SQUAD),
        unit(Squad.FALLEN_INT_TRANSFORMERS02_SQUAD, Slot.FALLEN_INT_TRANSFORMERS02_SQUAD),
        unit(Squad.FALLEN_INT_TRANSFORMERS_SNIPER_SQUAD,
             Slot.FALLEN_INT_TRANSFORMERS_SNIPER_SQUAD),
        unit(Squad.FALLEN_INT_TRANSFORMERS_EXPLODERS01_SQUAD,
             Slot.FALLEN_INT_TRANSFORMERS_EXPLODERS01_SQUAD),
        unit(Squad.FALLEN_INT_TRANSFORMERS_BACK01_SQUAD,
             Slot.FALLEN_INT_TRANSFORMERS_BACK01_SQUAD),
        unit(Squad.FALLEN_INT_TRANSFORMERS_BACK02_SQUAD,
             Slot.FALLEN_INT_TRANSFORMERS_BACK02_SQUAD),
    },
}

-- The way out to the converters: catwalks, cables, then the Hive below the central platform.
local catwalks = {
    id = "catwalks",
    trigger = Slot.FALLEN_CATWALKS_LANDING01_SPAWN_TRIGGER,
    after = "out",
    objective = Slot.FALLEN_CATWALKS_OBJECTIVE,
    squads = {
        unit(Squad.FALLEN_CATWALKS_LANDING01_SQUAD, Slot.FALLEN_CATWALKS_LANDING01_SQUAD),
        unit(Squad.FALLEN_CATWALKS_LAYER01_SQUAD, Slot.FALLEN_CATWALKS_LAYER01_SQUAD),
        unit(Squad.FALLEN_CATWALKS_SNIPERS01_SQUAD, Slot.FALLEN_CATWALKS_SNIPERS01_SQUAD),
        unit(Squad.FALLEN_CATWALKS_SNIPERS02_SQUAD, Slot.FALLEN_CATWALKS_SNIPERS02_SQUAD),
        unit(Squad.FALLEN_CATWALKS_SNIPERS03_SQUAD, Slot.FALLEN_CATWALKS_SNIPERS03_SQUAD),
        unit(Squad.FALLEN_CATWALKS_END01_SQUAD, Slot.FALLEN_CATWALKS_END01_SQUAD),
    },
}

local cables = {
    id = "cables",
    trigger = Slot.FALLEN_CABLES_DROPSHIP_SPAWN_TRIGGER,
    after = "out",
    objective = Slot.FALLEN_CABLES_OBJECTIVE,
    squads = {
        unit(Squad.FALLEN_CABLES_DIP1_INF01_SQUAD, Slot.FALLEN_CABLES_DIP1_INF01_SQUAD),
        unit(Squad.FALLEN_CABLES_DIP1_INF02_SQUAD, Slot.FALLEN_CABLES_DIP1_INF02_SQUAD),
        unit(Squad.FALLEN_CABLES_DIP1_INF03_SQUAD, Slot.FALLEN_CABLES_DIP1_INF03_SQUAD),
        unit(Squad.FALLEN_CABLES_DIP1_INF04_SQUAD, Slot.FALLEN_CABLES_DIP1_INF04_SQUAD),
        unit(Squad.FALLEN_CABLES_DIP1_SHANKS01_SQUAD, Slot.FALLEN_CABLES_DIP1_SHANKS01_SQUAD),
        unit(Squad.FALLEN_CABLES_MID01_SQUAD, Slot.FALLEN_CABLES_MID01_SQUAD),
        unit(Squad.FALLEN_CABLES_DROPSHIP_SQUAD, Slot.FALLEN_CABLES_DROPSHIP_SQUAD),
    },
}

local hive_cables = {
    id = "hive_cables",
    trigger = Slot.HIVE_CABLES_THRALL_SLEEPERS_SPAWN_TRIGGER,
    after = "out",
    objective = Slot.HIVE_CABLES_OBJECTIVE,
    squads = {
        unit(Squad.HIVE_CABLES_MID01_SQUAD, Slot.HIVE_CABLES_MID01_SQUAD),
        unit(Squad.HIVE_CABLES_THRALL_EXPLODERS01A_SQUAD,
             Slot.HIVE_CABLES_THRALL_EXPLODERS01A_SQUAD),
        unit(Squad.HIVE_CABLES_THRALL_EXPLODERS01B_SQUAD,
             Slot.HIVE_CABLES_THRALL_EXPLODERS01B_SQUAD),
        unit(Squad.HIVE_CABLES_THRALL_EXPLODERS01C_SQUAD,
             Slot.HIVE_CABLES_THRALL_EXPLODERS01C_SQUAD),
        unit(Squad.HIVE_CABLES_THRALL_EXPLODERS01D_SQUAD,
             Slot.HIVE_CABLES_THRALL_EXPLODERS01D_SQUAD),
        unit(Squad.HIVE_CABLES_THRALL_EXPLODERS02_SQUAD,
             Slot.HIVE_CABLES_THRALL_EXPLODERS02_SQUAD),
        unit(Squad.HIVE_CABLES_THRALL_SLEEPERS1_SQUAD, Slot.HIVE_CABLES_THRALL_SLEEPERS1_SQUAD),
        unit(Squad.HIVE_CABLES_THRALL_SLEEPERS2_SQUAD, Slot.HIVE_CABLES_THRALL_SLEEPERS2_SQUAD),
        unit(Squad.HIVE_CABLES_THRALL_SLEEPERS3_SQUAD, Slot.HIVE_CABLES_THRALL_SLEEPERS3_SQUAD),
        unit(Squad.HIVE_CABLES_THRALL_SLEEPERS4_SQUAD, Slot.HIVE_CABLES_THRALL_SLEEPERS4_SQUAD),
        unit(Squad.HIVE_CABLES_THRALL_SLEEPERS5_SQUAD, Slot.HIVE_CABLES_THRALL_SLEEPERS5_SQUAD),
        unit(Squad.HIVE_CABLES_THRALL_WAVE1_SQUAD, Slot.HIVE_CABLES_THRALL_WAVE1_SQUAD),
        unit(Squad.HIVE_CABLES_THRALL_WAVE2_SQUAD, Slot.HIVE_CABLES_THRALL_WAVE2_SQUAD),
    },
}

local hive_platform = {
    id = "hive_platform",
    trigger = Slot.HIVE_PLATFORM_SPAWN_TRIGGER,
    after = "out",
    objective = Slot.HIVE_PLATFORM_OBJECTIVE,
    squads = {
        unit(Squad.HIVE_PLATFORM_INF01_SQUAD, Slot.HIVE_PLATFORM_INF01_SQUAD),
        unit(Squad.HIVE_PLATFORM_INF02_SQUAD, Slot.HIVE_PLATFORM_INF02_SQUAD),
    },
}

-- The connector leads from the first piston to the second.
local connector = {
    id = "connector",
    trigger = Slot.CONNECTOR_SPAWN_TRIGGER,
    after = "second_piston",
    objective = Slot.HIVE_CONNECTOR_OBJECTIVE,
    squads = {
        unit(Squad.HIVE_CONNECTOR_INF01_SQUAD, Slot.HIVE_CONNECTOR_INF01_SQUAD),
        unit(Squad.HIVE_CONNECTOR_THRALL01_SQUAD, Slot.HIVE_CONNECTOR_THRALL01_SQUAD),
        unit(Squad.HIVE_CONNECTOR_SHRIEKER01_SQUAD, Slot.HIVE_CONNECTOR_SHRIEKER01_SQUAD),
    },
}

local gen2 = {
    id = "gen2",
    trigger = Slot.GEN2_SPAWN_TRIGGER,
    after = "second_piston",
    objective = Slot.HIVE_GEN2_OBJECTIVE,
    squads = {
        unit(Squad.HIVE_GEN2_INF01_SQUAD, Slot.HIVE_GEN2_INF01_SQUAD),
        unit(Squad.HIVE_GEN2_INF02_SQUAD, Slot.HIVE_GEN2_INF02_SQUAD),
        unit(Squad.HIVE_GEN2_SHRIEKER01_SQUAD, Slot.HIVE_GEN2_SHRIEKER01_SQUAD),
    },
}

-- The Wizards on the central platform block the breaker.
local final = {
    id = "final",
    trigger = Slot.FINAL_ENCOUNTER_START_TRIGGER,
    after = "wizards",
    objective = Slot.HIVE_FINAL_OBJECTIVE,
    squads = {
        unit(Squad.HIVE_FINAL_INF01_SQUAD, Slot.HIVE_FINAL_INF01_SQUAD),
        unit(Squad.HIVE_FINAL_INF02_SQUAD, Slot.HIVE_FINAL_INF02_SQUAD),
        unit(Squad.HIVE_FINAL_INF03_SQUAD, Slot.HIVE_FINAL_INF03_SQUAD),
        unit(Squad.HIVE_FINAL_THRALL01_SQUAD, Slot.HIVE_FINAL_THRALL01_SQUAD),
        unit(Squad.HIVE_FINAL_THRALL02_SQUAD, Slot.HIVE_FINAL_THRALL02_SQUAD),
        unit(Squad.HIVE_FINAL_SHRIEKER01_SQUAD, Slot.HIVE_FINAL_SHRIEKER01_SQUAD),
        unit(Squad.HIVE_FINAL_WIZARD01_SQUAD, Slot.HIVE_FINAL_WIZARD01_SQUAD),
        unit(Squad.HIVE_FINAL_WIZARD02_SQUAD, Slot.HIVE_FINAL_WIZARD02_SQUAD),
    },
}

return campaign.new{
    key = "lights",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR,
    dialogue_sensor = Slot.M_DIALOG_SENSOR,
    legs = {
        {id = "base", state = mission.states.STATE_80B3ED9A_0002_0000_80B3ED8E, arm = {
            Slot.PLAYER_TRIGGER_80B9904B,
        }},
        {id = "platform", state = mission.states.STATE_80B3ED9A_0007_0000_80B3ED95, arm = {
            Slot.MISSION_LIGHTS_025_DIALOG_START_TRIGGER, Slot.PLAYER_TRIGGER_80B99468,
        }},
        {id = "generator", state = mission.states.STATE_80B3ED9A_0006_0000_80B3ED94, arm = {
            Slot.FALLEN_CORRIDORS_VANDALS_SPAWN_TRIGGER,
            Slot.FALLEN_EXPLODER_INTRO_SCENE_START_TRIGGER,
            Slot.FALLEN_CORRIDORS_EXPLODERS01_SPAWN_TRIGGER,
            Slot.INTERIOR_FALLEN_TRANSFORMERS_TRIGGER, Slot.PLAYER_TRIGGER_80B993B6,
            Slot.FALLEN_CATWALKS_LANDING01_SPAWN_TRIGGER,
            Slot.FALLEN_CABLES_DROPSHIP_SPAWN_TRIGGER, Slot.PLAYER_TRIGGER_80B993AB,
            Slot.HIVE_CABLES_THRALL_SLEEPERS_SPAWN_TRIGGER, Slot.HIVE_PLATFORM_SPAWN_TRIGGER,
            Slot.PLAYER_TRIGGER_80B993CC, Slot.CONNECTOR_SPAWN_TRIGGER, Slot.GEN2_SPAWN_TRIGGER,
            Slot.PLAYER_TRIGGER_80B993C1, Slot.FINAL_ENCOUNTER_START_TRIGGER,
            Slot.PLAYER_TRIGGER_80B9939F,
        }},
    },
    steps = {
        -- Sloane: "Now that we've reached the Control Center, we still need to power up the place."
        {id = "base", directive = Directive.RESTORE_POWER_TO_THE_STATION_D0624D78,
            navpoint = Slot.NAV_POINT_80B9904B, lines = {line(cue.CUE_0)},
            ends = {trigger = Slot.PLAYER_TRIGGER_80B9904B}},
        -- "Did we lead the Fallen here?" "Sloane, Amanda. The Hive have infected everything."
        {id = "platform", directive = Directive.RESTORE_POWER_TO_THE_STATION_BA3B252E,
            navpoint = Slot.NAV_POINT_80B99468,
            lines = {line(cue.CUE_2, Slot.SLOT_0003_80B99468),
                line(cue.CUE_3, Slot.SLOT_0004_80B99468)},
            ends = {trigger = Slot.PLAYER_TRIGGER_80B99468}},
        -- "We can see the wave energy converters from here. Now just flip the switch."
        {id = "console", directive = Directive.RESTORE_POWER_TO_THE_STATION_DBB4AD88,
            navpoint = Slot.NAV_POINT_80B993DF, waypoint = Slot.SLOT_0003_80B993DF,
            lines = {line(cue.CUE_4, Slot.MISSION_LIGHTS_030_DIALOG_FILTER_VOLUME)},
            ends = {ghost_link = Slot.GENERATOR_SCAN_GHOSTLINK}},
        -- "Accessing systems now." The pistons jam: "you're gonna have to go out there."
        {id = "out", directive = Directive.FIGURE_OUT_WHAT_S_WRONG_WITH_THE_CONVERTERS,
            navpoint = Slot.NAV_POINT_80B993B6,
            lines = {line(cue.CUE_5), line(cue.CUE_6), line(cue.CUE_7)},
            ends = {trigger = Slot.PLAYER_TRIGGER_80B993B6}},
        {id = "cables", directive = Directive.FIGURE_OUT_WHAT_S_WRONG_WITH_THE_CONVERTERS,
            navpoint = Slot.NAV_POINT_80B993AB,
            ends = {trigger = Slot.PLAYER_TRIGGER_80B993AB}},
        -- "Did you hear that?"
        {id = "below", directive = Directive.FIGURE_OUT_WHAT_S_WRONG_WITH_THE_CONVERTERS,
            navpoint = Slot.NAV_POINT_80B993CC, lines = {line(cue.CUE_13)},
            ends = {trigger = Slot.PLAYER_TRIGGER_80B993CC}},
        -- "The Hive have gunked up the pistons." The reminder waits on the central platform.
        {id = "first_piston", directive = Directive.REPAIR_THE_CONVERTERS,
            navpoint = Slot.NAV_POINT1,
            lines = {line(cue.CUE_11), line(cue.CUE_15, Slot.SLOT_0004_80B9939F),
                line(cue.CUE_16, Slot.SLOT_0005_80B9939F),
                line(cue.CUE_21, Slot.TRIGGER_VOLUME_80B9939F)},
            ends = {destroyed = {Slot.GEN1_GROWTH_TUTORIAL_OBJECT, Slot.GEN1_GROWTH1_OBJECT,
                Slot.GEN1_GROWTH2_OBJECT}}},
        -- "First piston's good to go."
        {id = "second_piston", directive = Directive.REPAIR_THE_CONVERTERS,
            navpoint = Slot.SLOT_000C_80B9939F, lines = {line(cue.CUE_17)},
            on_start = function(context)
                move(context, {Slot.GEN1_PISTON_DEVICE, Slot.CONNECTOR_DOOR_DEVICE}, "open")
            end,
            ends = {destroyed = {Slot.GEN2_GROWTH1_OBJECT}}},
        -- "Final piston is clear. Try the Central Platform."
        {id = "central", directive = Directive.RESTORE_POWER_TO_THE_STATION_CEC098C3,
            navpoint = Slot.NAV_POINT_80B993C1, lines = {line(cue.CUE_22)},
            on_start = function(context) move(context, {Slot.GEN2_PISTON_DEVICE}, "open") end,
            ends = {trigger = Slot.PLAYER_TRIGGER_80B993C1}},
        -- "Circuit breaker's going to be around there somewhere."
        {id = "wizards", directive = Directive.RESTORE_POWER_TO_THE_STATION,
            navpoint = Slot.NAV_POINT_80B993D4, lines = {line(cue.CUE_24)},
            ends = {clear = "final"}},
        {id = "breaker", directive = Directive.RESTORE_POWER_TO_THE_STATION_CEC098C3,
            navpoint = Slot.NAV_POINT_80B993D4,
            ends = {interact = Slot.FINAL_PLATFORM_BREAKER_OBJECT}},
        -- "Yeah! Power's back!"
        {id = "power", lines = {line(cue.CUE_25)},
            on_start = function(context)
                move(context, {Slot.FINAL_PLATFORM_BREAKER_DEVICE, Slot.FINAL_GENERATOR_HUB_DEVICE,
                    Slot.LIGHTING_MAIN_EVENT_DEVICE_80B3F24C}, "power_on")
            end},
    },
    encounters = {
        platform_fallen, platform_hive, corridors, exploder_intro, corridor_exploders,
        transformers, catwalks, cables, hive_cables, hive_platform, connector, gen2, final,
    },
}
