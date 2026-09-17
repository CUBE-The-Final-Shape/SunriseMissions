-- Adieu. Red War campaign draft; not tested in game.
-- One leg over regions 24 to 27. Steps follow the step objects, their lines and the trigger volume
-- positions: the canal, the climb past the dead Guardians, the mountain, the beasts, the canyon.
local missions = require("missions")
local mission = require(missions.MISSION_JOURNEY)
local campaign = require("lib.campaign")
local unit, line = campaign.unit, campaign.line
local Slot, Squad, Directive = mission.Slot, mission.Squad, mission.Directive
local cue = mission.DialogueCue.M_DIALOG_SENSOR_80B5E02A

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
}

-- The climb starts where the falcon first lands.
local climb = {
    id = "climb",
    trigger = Slot.PT_FALCON_CLIMB,
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
}

return campaign.new{
    key = "journey",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80B5E02A,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80B5E02A,
    legs = {
        {id = "the_walk", state = mission.states.STATE_80B5E01F_0003_0000_80B5E018, arm = {
            Slot.PT_GHOST_FINDING, Slot.PT_GOTO_CLIMB, Slot.PT_FALCON_CLIMB,
            Slot.PT_DLG_CITY_EXIT,
            Slot.PT_CLIMB_FLYOVER, Slot.PT_FIND_GUARDIANS_HIGH, Slot.PT_GOTO_MOUNTAIN,
            Slot.PT_GOTO_CANYON, Slot.PT_BEAST, Slot.PT_GOTO_HAW, Slot.PT_END_NAV,
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
            ends = {trigger = Slot.PT_FIND_GUARDIANS_HIGH}},
        -- "These Guardians... They had no chance without their powers."
        {id = "gun", directive = Directive.ARM_YOURSELF, navpoint = Slot.AP_GET_GUN,
            lines = {line(cue.CUE_24), line(cue.CUE_27)},
            ends = {interact = Slot.O_AUTO_RIFLE}},
        {id = "falcon", directive = Directive.FOLLOW_YOUR_VISION_B4B4B71D,
            navpoint = Slot.SLOT_000B_80B5E415,
            ends = {trigger = Slot.PT_GOTO_MOUNTAIN}},
        -- "It's that falcon again. Is it following us?"
        {id = "mountain", directive = Directive.FOLLOW_YOUR_VISION_ABA9EFFB,
            navpoint = Slot.AP_GOTO_CANYON,
            lines = {line(cue.CUE_28, Slot.SLOT_0008_80B5E434)},
            ends = {trigger = Slot.PT_GOTO_CANYON}},
        {id = "bowl", directive = Directive.FOLLOW_YOUR_VISION_CA83E2E7,
            navpoint = Slot.AP_GOTO_HAW,
            ends = {trigger = Slot.PT_GOTO_HAW}},
        {id = "canyon", directive = Directive.FOLLOW_YOUR_VISION, navpoint = Slot.AP_HAWTHORNE,
            ends = {trigger = Slot.PT_END_NAV}},
    },
    encounters = {city, climb, guardians, beasts},
}
