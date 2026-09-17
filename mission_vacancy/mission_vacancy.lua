-- Hope. Red War campaign draft; not tested in game.
-- Leg order: flotilla -> base. The flotilla's last step points at the base bubble. Steps follow
-- the step objects, their lines and the trigger volume positions.
local missions = require("missions")
local mission = require(missions.MISSION_VACANCY)
local campaign = require("lib.campaign")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive = mission.Slot, mission.Squad, mission.Directive
local cue = mission.DialogueCue.M_DIALOG_SENSOR_80B980D8

-- The Hive nest in the cylinder rooms past the dark corridor.
local nest = {
    id = "nest",
    trigger = Slot.ROOM_CORRIDOR_ENTRY_PLAYER_TRIGGER,
    objective = Slot.VACANCY_FLOTILLA_APPLE_OBJECTIVE,
    squads = {
        unit(Squad.NEST_MELEE_A_01_SQUAD, Slot.NEST_MELEE_A_01_SQUAD),
        unit(Squad.NEST_MELEE_A_02_SQUAD, Slot.NEST_MELEE_A_02_SQUAD),
        unit(Squad.NEST_MELEE_B_01_SQUAD, Slot.NEST_MELEE_B_01_SQUAD),
        unit(Squad.NEST_MELEE_B_02_SQUAD, Slot.NEST_MELEE_B_02_SQUAD),
        unit(Squad.NEST_MELEE_C_01_SQUAD, Slot.NEST_MELEE_C_01_SQUAD),
        unit(Squad.NEST_MELEE_C_02_SQUAD, Slot.NEST_MELEE_C_02_SQUAD),
        unit(Squad.NEST_MELEE_D_01_SQUAD, Slot.NEST_MELEE_D_01_SQUAD),
        unit(Squad.NEST_MELEE_D_02_SQUAD, Slot.NEST_MELEE_D_02_SQUAD),
        unit(Squad.NEST_MELEE_E_01_SQUAD, Slot.NEST_MELEE_E_01_SQUAD),
        unit(Squad.NEST_MELEE_E_02_SQUAD, Slot.NEST_MELEE_E_02_SQUAD),
        unit(Squad.NEST_MELEE_F_01_SQUAD, Slot.NEST_MELEE_F_01_SQUAD),
        unit(Squad.NEST_MELEE_F_02_SQUAD, Slot.NEST_MELEE_F_02_SQUAD),
        unit(Squad.NEST_MELEE_G_01_SQUAD, Slot.NEST_MELEE_G_01_SQUAD),
        unit(Squad.NEST_MELEE_G_02_SQUAD, Slot.NEST_MELEE_G_02_SQUAD),
        unit(Squad.NEST_MELEE_H_01_SQUAD, Slot.NEST_MELEE_H_01_SQUAD),
        unit(Squad.NEST_MELEE_H_02_SQUAD, Slot.NEST_MELEE_H_02_SQUAD),
        unit(Squad.NEST_MELEE_I_01_SQUAD, Slot.NEST_MELEE_I_01_SQUAD),
        unit(Squad.NEST_MELEE_I_02_SQUAD, Slot.NEST_MELEE_I_02_SQUAD),
        unit(Squad.NEST_MELEE_J_01_SQUAD, Slot.NEST_MELEE_J_01_SQUAD),
        unit(Squad.NEST_MELEE_J_02_SQUAD, Slot.NEST_MELEE_J_02_SQUAD),
    },
}

local ring = {
    id = "ring",
    trigger = Slot.RING_ENTRY_PLAYER_TRIGGER,
    squads = {unit(Squad.RING_SUPPORT_SQUAD, Slot.RING_SUPPORT_SQUAD)},
}

local access = {
    id = "access",
    trigger = Slot.ACCESS_MID_PLAYER_TRIGGER,
    objective = Slot.VACANCY_FLOTILLA_CHERRY_ACCESS_OBJECTIVE,
    squads = {
        unit(Squad.ACCESS_SUPPORT_A_SQUAD, Slot.ACCESS_SUPPORT_A_SQUAD),
        unit(Squad.ACCESS_SUPPORT_B_SQUAD, Slot.ACCESS_SUPPORT_B_SQUAD),
        unit(Squad.ACCESS_SUPPORT_C_SQUAD, Slot.ACCESS_SUPPORT_C_SQUAD),
    },
}

-- The underhang is the way past the fan.
local underhang = {
    id = "underhang",
    trigger = Slot.UNDERHANG_ENTRY_PLAYER_TRIGGER,
    after = "fan",
    objective = Slot.VACANCY_FLOTILLA_CHERRY_UNDERHANG_OBJECTIVE,
    squads = {
        unit(Squad.UNDERHANG_SUPPORT_A_SQUAD, Slot.UNDERHANG_SUPPORT_A_SQUAD),
        unit(Squad.UNDERHANG_SUPPORT_B_SQUAD, Slot.UNDERHANG_SUPPORT_B_SQUAD),
        unit(Squad.UNDERHANG_SUPPORT_C_SQUAD, Slot.UNDERHANG_SUPPORT_C_SQUAD),
        unit(Squad.UNDERHANG_SUPPORT_D_SQUAD, Slot.UNDERHANG_SUPPORT_D_SQUAD),
        unit(Squad.UNDERHANG_MELEE_A_SQUAD, Slot.UNDERHANG_MELEE_A_SQUAD),
        unit(Squad.UNDERHANG_MELEE_B_SQUAD, Slot.UNDERHANG_MELEE_B_SQUAD),
    },
}

local lab = {
    id = "lab",
    trigger = Slot.LOADING_ENTRY_PLAYER_TRIGGER,
    objective = Slot.VACANCY_FLOTILLA_CHERRY_LAB_LOADING_OBJECTIVE,
    squads = {
        unit(Squad.LAB_ANCHOR_A_SQUAD, Slot.LAB_ANCHOR_A_SQUAD),
        unit(Squad.LAB_MELEE_A_SQUAD, Slot.LAB_MELEE_A_SQUAD),
        unit(Squad.LAB_MELEE_B_SQUAD, Slot.LAB_MELEE_B_SQUAD),
        unit(Squad.LOADING_ANCHOR_A_SQUAD, Slot.LOADING_ANCHOR_A_SQUAD),
        unit(Squad.LOADING_SUPPORT_A_SQUAD, Slot.LOADING_SUPPORT_A_SQUAD),
        unit(Squad.LOADING_SUPPORT_B_SQUAD, Slot.LOADING_SUPPORT_B_SQUAD),
        unit(Squad.LOADING_SUPPORT_C_SQUAD, Slot.LOADING_SUPPORT_C_SQUAD),
        unit(Squad.LOADING_SUPPORT_D_SQUAD, Slot.LOADING_SUPPORT_D_SQUAD),
    },
}

local wall = {
    id = "wall",
    trigger = Slot.BUILDING_WALL_ENTRY_PLAYER_TRIGGER,
    objective = Slot.VACANCY_BASE_BUILDING_WALL_OBJECTIVE,
    squads = {
        unit(Squad.BUILDING_WALL_ANCHOR_A_SQUAD, Slot.BUILDING_WALL_ANCHOR_A_SQUAD),
        unit(Squad.BUILDING_WALL_MELEE_A_SQUAD, Slot.BUILDING_WALL_MELEE_A_SQUAD),
        unit(Squad.BUILDING_WALL_MELEE_B_SQUAD, Slot.BUILDING_WALL_MELEE_B_SQUAD),
        unit(Squad.BUILDING_WALL_SUPPORT_A_SQUAD, Slot.BUILDING_WALL_SUPPORT_A_SQUAD),
        unit(Squad.BUILDING_WALL_SUPPORT_B_SQUAD, Slot.BUILDING_WALL_SUPPORT_B_SQUAD),
        unit(Squad.BUILDING_WALL_SUPPORT_C_SQUAD, Slot.BUILDING_WALL_SUPPORT_C_SQUAD),
        unit(Squad.BUILDING_WALL_SUPPORT_D_SQUAD, Slot.BUILDING_WALL_SUPPORT_D_SQUAD),
    },
}

-- "Clear the area so we can move in."
local center_assault = {
    id = "center_assault",
    after = "center",
    objective = Slot.VACANCY_BASE_BUILDING_CENTER_ASSAULT_OBJECTIVE,
    squads = {
        unit(Squad.BUILDING_CENTER_ASSAULT_ANCHOR_A_SQUAD,
             Slot.BUILDING_CENTER_ASSAULT_ANCHOR_A_SQUAD),
        unit(Squad.BUILDING_CENTER_ASSAULT_ANCHOR_B_SQUAD,
             Slot.BUILDING_CENTER_ASSAULT_ANCHOR_B_SQUAD),
        unit(Squad.BUILDING_CENTER_ASSAULT_MELEE_A_SQUAD,
             Slot.BUILDING_CENTER_ASSAULT_MELEE_A_SQUAD),
        unit(Squad.BUILDING_CENTER_ASSAULT_MELEE_B_SQUAD,
             Slot.BUILDING_CENTER_ASSAULT_MELEE_B_SQUAD),
        unit(Squad.BUILDING_CENTER_ASSAULT_MELEE_C_SQUAD,
             Slot.BUILDING_CENTER_ASSAULT_MELEE_C_SQUAD),
        unit(Squad.BUILDING_CENTER_ASSAULT_MELEE_D_SQUAD,
             Slot.BUILDING_CENTER_ASSAULT_MELEE_D_SQUAD),
        unit(Squad.BUILDING_CENTER_ASSAULT_SUPPORT_A_SQUAD,
             Slot.BUILDING_CENTER_ASSAULT_SUPPORT_A_SQUAD),
        unit(Squad.BUILDING_CENTER_ASSAULT_SUPPORT_B_SQUAD,
             Slot.BUILDING_CENTER_ASSAULT_SUPPORT_B_SQUAD),
        unit(Squad.BUILDING_CENTER_ASSAULT_SUPPORT_C_SQUAD,
             Slot.BUILDING_CENTER_ASSAULT_SUPPORT_C_SQUAD),
        unit(Squad.BUILDING_CENTER_ASSAULT_SUPPORT_D_SQUAD,
             Slot.BUILDING_CENTER_ASSAULT_SUPPORT_D_SQUAD),
    },
}

local interior = {
    id = "interior",
    trigger = Slot.BUILDING_CENTER_ENTRY_PLAYER_TRIGGER,
    after = "hatchery",
    objective = Slot.VACANCY_BASE_BUILDING_CENTER_INTERIOR_OBJECTIVE,
    squads = {
        unit(Squad.BUILDING_CENTER_INTERIOR_ANCHOR_A_SQUAD,
             Slot.BUILDING_CENTER_INTERIOR_ANCHOR_A_SQUAD),
        unit(Squad.BUILDING_CENTER_INTERIOR_ANCHOR_B_SQUAD,
             Slot.BUILDING_CENTER_INTERIOR_ANCHOR_B_SQUAD),
        unit(Squad.BUILDING_CENTER_INTERIOR_MELEE_A_SQUAD,
             Slot.BUILDING_CENTER_INTERIOR_MELEE_A_SQUAD),
        unit(Squad.BUILDING_CENTER_INTERIOR_MELEE_B_SQUAD,
             Slot.BUILDING_CENTER_INTERIOR_MELEE_B_SQUAD),
        unit(Squad.BUILDING_CENTER_INTERIOR_SUPPORT_A_SQUAD,
             Slot.BUILDING_CENTER_INTERIOR_SUPPORT_A_SQUAD),
        unit(Squad.BUILDING_CENTER_INTERIOR_SUPPORT_B_SQUAD,
             Slot.BUILDING_CENTER_INTERIOR_SUPPORT_B_SQUAD),
        unit(Squad.BUILDING_CENTER_INTERIOR_SUPPORT_C_SQUAD,
             Slot.BUILDING_CENTER_INTERIOR_SUPPORT_C_SQUAD),
        unit(Squad.BUILDING_CENTER_INTERIOR_SUPPORT_D_SQUAD,
             Slot.BUILDING_CENTER_INTERIOR_SUPPORT_D_SQUAD),
        unit(Squad.BUILDING_CENTER_INTERIOR_SUPPORT_E_SQUAD,
             Slot.BUILDING_CENTER_INTERIOR_SUPPORT_E_SQUAD),
        unit(Squad.BUILDING_CENTER_INTERIOR_SUPPORT_F_SQUAD,
             Slot.BUILDING_CENTER_INTERIOR_SUPPORT_F_SQUAD),
    },
}

local rooftops = {
    id = "rooftops",
    after = "rooftops",
    objective = Slot.VACANCY_BASE_BUILDING_CENTER_DEFEND_OBJECTIVE,
    squads = {
        unit(Squad.BUILDING_CENTER_ROOFTOPS_DEFEND_ANCHOR_A_SQUAD,
             Slot.BUILDING_CENTER_ROOFTOPS_DEFEND_ANCHOR_A_SQUAD),
        unit(Squad.BUILDING_CENTER_ROOFTOPS_DEFEND_ANCHOR_B_SQUAD,
             Slot.BUILDING_CENTER_ROOFTOPS_DEFEND_ANCHOR_B_SQUAD),
        unit(Squad.BUILDING_CENTER_ROOFTOPS_DEFEND_SUPPORT_A_SQUAD,
             Slot.BUILDING_CENTER_ROOFTOPS_DEFEND_SUPPORT_A_SQUAD),
        unit(Squad.BUILDING_CENTER_ROOFTOPS_DEFEND_SUPPORT_B_SQUAD,
             Slot.BUILDING_CENTER_ROOFTOPS_DEFEND_SUPPORT_B_SQUAD),
        unit(Squad.BUILDING_CENTER_ROOFTOPS_DEFEND_SUPPORT_C_SQUAD,
             Slot.BUILDING_CENTER_ROOFTOPS_DEFEND_SUPPORT_C_SQUAD),
        unit(Squad.BUILDING_CENTER_ROOFTOPS_DEFEND_SUPPORT_D_SQUAD,
             Slot.BUILDING_CENTER_ROOFTOPS_DEFEND_SUPPORT_D_SQUAD),
        unit(Squad.BUILDING_CENTER_ROOFTOPS_DEFEND_SUPPORT_E_SQUAD,
             Slot.BUILDING_CENTER_ROOFTOPS_DEFEND_SUPPORT_E_SQUAD),
    },
}

-- The overhang and small building groups carry no encounter objective.
local overhang = {
    id = "overhang",
    trigger = Slot.BUILDING_OVERHANG_DEFEND_MID_PLAYER_TRIGGER,
    after = "rooftops",
    squads = {
        unit(Squad.BUILDING_OVERHANG_DEFEND_ANCHOR_A_SQUAD,
             Slot.BUILDING_OVERHANG_DEFEND_ANCHOR_A_SQUAD),
        unit(Squad.BUILDING_OVERHANG_DEFEND_SUPPORT_A_SQUAD,
             Slot.BUILDING_OVERHANG_DEFEND_SUPPORT_A_SQUAD),
        unit(Squad.BUILDING_OVERHANG_DEFEND_SUPPORT_B_SQUAD,
             Slot.BUILDING_OVERHANG_DEFEND_SUPPORT_B_SQUAD),
        unit(Squad.BUILDING_SMALL_DEFEND_SUPPORT_A_SQUAD,
             Slot.BUILDING_SMALL_DEFEND_SUPPORT_A_SQUAD),
        unit(Squad.BUILDING_SMALL_DEFEND_SUPPORT_B_SQUAD,
             Slot.BUILDING_SMALL_DEFEND_SUPPORT_B_SQUAD),
        unit(Squad.BUILDING_SMALL_DEFEND_SUPPORT_C_SQUAD,
             Slot.BUILDING_SMALL_DEFEND_SUPPORT_C_SQUAD),
    },
}

local dropships = {
    id = "dropships",
    after = "helipad",
    squads = {
        unit(Squad.BUILDING_CENTER_VANGUARD_DROPSHIP_A_SQUAD,
             Slot.BUILDING_CENTER_VANGUARD_DROPSHIP_A_SQUAD),
        unit(Squad.BUILDING_CENTER_VANGUARD_DROPSHIP_B_SQUAD,
             Slot.BUILDING_CENTER_VANGUARD_DROPSHIP_B_SQUAD),
    },
}

return campaign.new{
    key = "vacancy",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80B980D8,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80B980D8,
    legs = {
        {id = "flotilla", state = mission.states.STATE_80B3FC6A_0005_0000_80B3FC55, arm = {
            Slot.FLOTILLA_DIRECTIVE_MANGO_GOTO_PLAYER_TRIGGER,
            Slot.FLOTILLA_DIRECTIVE_GRAPE_GOTO_PLAYER_TRIGGER,
            Slot.ROOM_CORRIDOR_ENTRY_PLAYER_TRIGGER,
            Slot.FLOTILLA_DIRECTIVE_APPLE_GOTO_PLAYER_TRIGGER, Slot.RING_ENTRY_PLAYER_TRIGGER,
            Slot.ACCESS_MID_PLAYER_TRIGGER,
            Slot.FLOTILLA_DIRECTIVE_CHERRY_EARLY_GOTO_PLAYER_TRIGGER,
            Slot.UNDERHANG_ENTRY_PLAYER_TRIGGER, Slot.UNDERHANG_MID_PLAYER_TRIGGER,
            Slot.LOADING_ENTRY_PLAYER_TRIGGER,
            Slot.FLOTILLA_DIRECTIVE_CHERRY_MID_GOTO_PLAYER_TRIGGER,
            Slot.FLOTILLA_DIRECTIVE_CHERRY_LATE_GOTO_PLAYER_TRIGGER,
            Slot.BASE_025_DIALOG_PLAYER_TRIGGER,
        }},
        {id = "base", state = mission.states.STATE_80B3FC6A_0002_0000_80B3FC43, arm = {
            Slot.BUILDING_WALL_ENTRY_PLAYER_TRIGGER,
            Slot.BASE_DIRECTIVE_BUILDING_WALL_ENTRY_PLAYER_TRIGGER,
            Slot.BASE_DIRECTIVE_BUILDING_WALL_EXIT_PLAYER_TRIGGER,
            Slot.BASE_DIRECTIVE_BUILDING_CENTER_ENTRY_PLAYER_TRIGGER_80BF0228,
            Slot.BUILDING_CENTER_ENTRY_PLAYER_TRIGGER,
            Slot.BASE_DIRECTIVE_BUILDING_CENTER_EXIT_PLAYER_TRIGGER,
            Slot.BUILDING_OVERHANG_DEFEND_MID_PLAYER_TRIGGER,
            Slot.BASE_DIRECTIVE_BUILDING_HQ_GOTO_PLAYER_TRIGGER,
        }},
    },
    steps = {
        {id = "mango", directive = Directive.SECURE_THE_CONTROL_CENTER_1860F14C,
            navpoint = Slot.FLOTILLA_DIRECTIVE_MANGO_GOTO_NAV_POINT,
            on_start = function(context)
                move(context, {Slot.MANGO_SLIDING_CONTAINER_A_DEVICE,
                    Slot.MANGO_SLIDING_CONTAINER_B_DEVICE}, "open")
            end,
            ends = {trigger = Slot.FLOTILLA_DIRECTIVE_MANGO_GOTO_PLAYER_TRIGGER}},
        -- "What was this place?" Then the Hive growth that blocks the way: "Go on, shoot it!"
        {id = "gunk", directive = Directive.SECURE_THE_CONTROL_CENTER_E9CB4E5C,
            navpoint = Slot.SLOT_0007_80BF0569,
            lines = {line(cue.CUE_10, Slot.SLOT_0013_80BF0569),
                line(cue.CUE_9, Slot.FLOTILLA_DIRECTIVE_GRAPE_HIVE_GUNK_TRIGGER_VOLUME)},
            ends = {destroyed = {Slot.GRAPE_HIVE_GUNK_B_OBJECT}}},
        {id = "grape", directive = Directive.SECURE_THE_CONTROL_CENTER_6905C8A5,
            navpoint = Slot.FLOTILLA_DIRECTIVE_GRAPE_GOTO_NAV_POINT,
            ends = {trigger = Slot.FLOTILLA_DIRECTIVE_GRAPE_GOTO_PLAYER_TRIGGER}},
        -- "I have a bad feeling about this."
        {id = "apple", directive = Directive.SECURE_THE_CONTROL_CENTER_FDF9021E,
            navpoint = Slot.FLOTILLA_DIRECTIVE_APPLE_GOTO_NAV_POINT,
            lines = {line(cue.CUE_11, Slot.SLOT_0011_80BF050D)},
            on_start = function(context)
                move(context, {Slot.APPLE_AMBIENT_DOOR_DEVICE}, "open")
            end,
            ends = {trigger = Slot.FLOTILLA_DIRECTIVE_APPLE_GOTO_PLAYER_TRIGGER}},
        -- "OK, Sloane. We can see the Control Center."
        {id = "cherry", directive = Directive.SECURE_THE_CONTROL_CENTER_6A7A5D61,
            navpoint = Slot.FLOTILLA_DIRECTIVE_CHERRY_EARLY_GOTO_NAV_POINT,
            lines = {line(cue.CUE_14, Slot.SLOT_000E_80BF0524)},
            ends = {trigger = Slot.FLOTILLA_DIRECTIVE_CHERRY_EARLY_GOTO_PLAYER_TRIGGER}},
        -- "Dead end. Unless... we do something about that fan." The way past runs under it.
        {id = "fan", directive = Directive.SECURE_THE_CONTROL_CENTER_DB4B5FBC,
            navpoint = Slot.SLOT_0016_80BF054F, lines = {line(cue.CUE_16)},
            ends = {trigger = Slot.UNDERHANG_MID_PLAYER_TRIGGER}},
        {id = "lab", directive = Directive.SECURE_THE_CONTROL_CENTER_85C91544,
            navpoint = Slot.SLOT_0017_80BF054F,
            ends = {trigger = Slot.FLOTILLA_DIRECTIVE_CHERRY_MID_GOTO_PLAYER_TRIGGER}},
        {id = "late", directive = Directive.SECURE_THE_CONTROL_CENTER_D633CE3C,
            navpoint = Slot.FLOTILLA_DIRECTIVE_CHERRY_LATE_GOTO_NAV_POINT,
            on_start = function(context)
                move(context, {Slot.CHERRY_MID_FAN_DEVICE}, "power_off")
            end,
            ends = {trigger = Slot.FLOTILLA_DIRECTIVE_CHERRY_LATE_GOTO_PLAYER_TRIGGER}},
        -- "I shudder to think what spell the Hive were casting back there."
        {id = "to_base", directive = Directive.SECURE_THE_CONTROL_CENTER_34669D1F,
            navpoint = Slot.BASE_DIRECTIVE_GOTO_BUBBLE_NAV_POINT,
            lines = {line(cue.CUE_21, Slot.BASE_025_DIALOG_TRIGGER_VOLUME)},
            ends = {region = "base"}},
        -- "We made it, Sloane." "Recon the perimeter before you move on the Control Center."
        {id = "wall", directive = Directive.SECURE_THE_CONTROL_CENTER,
            navpoint = Slot.SLOT_0008_80BF0261,
            lines = {line(cue.CUE_28, Slot.SLOT_0012_80BF0228)},
            on_start = function(context)
                move(context, {Slot.BUILDING_WALL_FROM_FLOTILLA_DOOR_DEVICE}, "open")
            end,
            ends = {trigger = Slot.BASE_DIRECTIVE_BUILDING_WALL_ENTRY_PLAYER_TRIGGER}},
        {id = "wall_exit", directive = Directive.SECURE_THE_CONTROL_CENTER_25CA0D01,
            navpoint = Slot.BASE_DIRECTIVE_BUILDING_WALL_EXIT_NAV_POINT,
            on_start = function(context)
                move(context, {Slot.BUILDING_WALL_ENTRY_ALLEY_DOOR_DEVICE}, "open")
            end,
            ends = {trigger = Slot.BASE_DIRECTIVE_BUILDING_WALL_EXIT_PLAYER_TRIGGER}},
        -- "There's the Control Center! Clear the area so we can move in."
        {id = "center", directive = Directive.SECURE_THE_CONTROL_CENTER_28722E25,
            navpoint = Slot.SLOT_0027_80BF0228, lines = {line(cue.CUE_26)},
            on_start = function(context)
                move(context, {Slot.BUILDING_CENTER_ENTRY_ROAD_DOOR_DEVICE}, "open")
            end,
            ends = {clear = "center_assault",
                trigger = Slot.BASE_DIRECTIVE_BUILDING_CENTER_ENTRY_PLAYER_TRIGGER_80BF0228}},
        -- "Some kind of Hive breeding ground. Take it out." "Shoot the yellow sacs."
        {id = "hatchery", directive = Directive.CLEAR_OUT_THE_HIVE_BREEDING_GROUND,
            navpoint = Slot.SLOT_002F_80BF0228,
            lines = {line(cue.CUE_29, Slot.SLOT_0015_80BF0228), line(cue.CUE_31)},
            ends = {destroyed = {
                Slot.BUILDING_CENTER_HIVE_GUNK_A_01_OBJECT,
                Slot.BUILDING_CENTER_HIVE_GUNK_A_02_OBJECT,
                Slot.BUILDING_CENTER_HIVE_GUNK_B_01_OBJECT,
                Slot.BUILDING_CENTER_HIVE_GUNK_B_02_OBJECT,
                Slot.BUILDING_CENTER_HIVE_GUNK_C_01_OBJECT,
                Slot.BUILDING_CENTER_HIVE_GUNK_C_02_OBJECT,
                Slot.BUILDING_CENTER_HIVE_GUNK_D_01_OBJECT,
                Slot.BUILDING_CENTER_HIVE_GUNK_D_02_OBJECT,
                Slot.BUILDING_CENTER_HIVE_GUNK_D_03_OBJECT,
                Slot.BUILDING_CENTER_HIVE_GUNK_E_01_OBJECT,
                Slot.BUILDING_CENTER_HIVE_GUNK_E_02_OBJECT,
                Slot.BUILDING_CENTER_HIVE_GUNK_E_03_OBJECT,
                Slot.BUILDING_CENTER_HIVE_GUNK_F_01_OBJECT,
                Slot.BUILDING_CENTER_HIVE_GUNK_F_02_OBJECT,
                Slot.BUILDING_CENTER_HIVE_GUNK_F_03_OBJECT,
                Slot.BUILDING_CENTER_HIVE_GUNK_G_01_OBJECT,
                Slot.BUILDING_CENTER_HIVE_GUNK_G_02_OBJECT,
            }}},
        -- "We cleared the nest. Heading to the Control Center now."
        {id = "rooftops", directive = Directive.SECURE_THE_CONTROL_CENTER_149260A8,
            navpoint = Slot.SLOT_0028_80BF0228, lines = {line(cue.CUE_33)},
            on_start = function(context)
                move(context, {Slot.BUILDING_CENTER_SKYBRIDGE_DOOR_DEVICE}, "open")
            end,
            ends = {trigger = Slot.BASE_DIRECTIVE_BUILDING_CENTER_EXIT_PLAYER_TRIGGER}},
        {id = "hold", directive = Directive.SECURE_THE_CONTROL_CENTER_E464A124,
            navpoint = Slot.SLOT_000B_80BF0228,
            on_start = function(context)
                move(context, {Slot.BUILDING_SMALL_ENTRY_ROAD_DOOR_DEVICE,
                    Slot.BUILDING_SMALL_ENTRY_SIDE_DOOR_DEVICE}, "open")
            end,
            ends = {clear = {"rooftops", "overhang"}}},
        -- "Sloane. Commander. It's done." The Ghost opens the HQ door.
        {id = "door", directive = Directive.RENDEZVOUS_WITH_ZAVALA_D071C5F4,
            navpoint = Slot.SLOT_000A_80BF023C, lines = {line(cue.CUE_35)},
            ends = {ghost_link = Slot.BUILDING_HQ_DOOR_GHOST_LINK}},
        -- "We're approaching the landing platform. Get up here, and take a bow."
        {id = "helipad", directive = Directive.RENDEZVOUS_WITH_ZAVALA,
            navpoint = Slot.BASE_DIRECTIVE_BUILDING_HELIPAD_GOTO_NAV_POINT,
            lines = {line(cue.CUE_36, Slot.SLOT_000C_80BF023C)},
            on_start = function(context)
                move(context, {Slot.BUILDING_HQ_ENTRY_ROAD_DOOR_DEVICE,
                    Slot.BUILDING_HQ_ENTRY_BACK_DOOR_DEVICE}, "open")
            end,
            ends = {trigger = Slot.BASE_DIRECTIVE_BUILDING_HQ_GOTO_PLAYER_TRIGGER}},
    },
    encounters = {
        nest, ring, access, underhang, lab, wall, center_assault, interior, rooftops, overhang,
        dropships,
    },
}
