-- 1AU. Red War campaign draft; not tested in game.
-- Steps follow the step objects, their lines and the trigger volume positions: the catwalk to
-- the control bridge, the ore tunnels, the sun deck, the foundry, the energy stream, the reactor.
local missions = require("missions")
local mission = require(missions.MISSION_EMBER)
local campaign = require("lib.campaign")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive = mission.Slot, mission.Squad, mission.Directive
local cue = mission.DialogueCue.M_DIALOG_SENSOR_80B3C90A

-- The helipad squads stand where the player lands.
local helipad = {
    id = "helipad",
    objective = Slot.EMBER_POWERHOUSE_HELIPAD_SUN_OBJECTIVE,
    squads = {
        unit(Squad.HELIPAD_SUN_ANCHOR_A_SQUAD, Slot.HELIPAD_SUN_ANCHOR_A_SQUAD),
        unit(Squad.HELIPAD_SUN_SUPPORT_A_SQUAD, Slot.HELIPAD_SUN_SUPPORT_A_SQUAD),
        unit(Squad.HELIPAD_SUN_SUPPORT_B_SQUAD, Slot.HELIPAD_SUN_SUPPORT_B_SQUAD),
    },
}

local catwalk = {
    id = "catwalk",
    trigger = Slot.CATWALK_015_PERCENT_PLAYER_TRIGGER,
    objective = Slot.EMBER_POWERHOUSE_CATWALK_OBJECTIVE,
    squads = {
        unit(Squad.CATWALK_ENTRY_RANGED_A_SQUAD, Slot.CATWALK_ENTRY_RANGED_A_SQUAD),
        unit(Squad.CATWALK_ENTRY_RANGED_B_SQUAD, Slot.CATWALK_ENTRY_RANGED_B_SQUAD),
        unit(Squad.CATWALK_ENTRY_SUPPORT_A_SQUAD, Slot.CATWALK_ENTRY_SUPPORT_A_SQUAD),
        unit(Squad.CATWALK_ENTRY_SUPPORT_B_SQUAD, Slot.CATWALK_ENTRY_SUPPORT_B_SQUAD),
        unit(Squad.CATWALK_ENTRY_SUPPORT_C_SQUAD, Slot.CATWALK_ENTRY_SUPPORT_C_SQUAD),
        unit(Squad.CATWALK_MID_SUPPORT_A_SQUAD, Slot.CATWALK_MID_SUPPORT_A_SQUAD),
        unit(Squad.CATWALK_MID_SUPPORT_B_SQUAD, Slot.CATWALK_MID_SUPPORT_B_SQUAD),
        unit(Squad.CATWALK_MID_SUPPORT_C_SQUAD, Slot.CATWALK_MID_SUPPORT_C_SQUAD),
        unit(Squad.CATWALK_BONUS_SUPPORT_A_SQUAD, Slot.CATWALK_BONUS_SUPPORT_A_SQUAD),
    },
}

local pipes = {
    id = "pipes",
    trigger = Slot.PIPE_CROSSING_040_PERCENT_PLAYER_TRIGGER,
    objective = Slot.EMBER_POWERHOUSE_PIPE_CROSSING_OBJECTIVE,
    squads = {
        unit(Squad.PIPE_CROSSING_SUPPORT_A_SQUAD, Slot.PIPE_CROSSING_SUPPORT_A_SQUAD),
        unit(Squad.PIPE_CROSSING_SUPPORT_B_SQUAD, Slot.PIPE_CROSSING_SUPPORT_B_SQUAD),
    },
}

local landing_mercury = {
    id = "landing_mercury",
    trigger = Slot.LANDING_MERCURY_010_PERCENT_PLAYER_TRIGGER,
    objective = Slot.EMBER_POWERHOUSE_LANDING_MERCURY_OBJECTIVE,
    squads = {
        unit(Squad.LANDING_MERCURY_ANCHOR_SQUAD, Slot.LANDING_MERCURY_ANCHOR_SQUAD),
        unit(Squad.LANDING_MERCURY_SUPPORT_A_SQUAD, Slot.LANDING_MERCURY_SUPPORT_A_SQUAD),
        unit(Squad.LANDING_MERCURY_SUPPORT_B_SQUAD, Slot.LANDING_MERCURY_SUPPORT_B_SQUAD),
        unit(Squad.LANDING_MERCURY_SUPPORT_C_SQUAD, Slot.LANDING_MERCURY_SUPPORT_C_SQUAD),
        unit(Squad.LANDING_MERCURY_RANGED_A_SQUAD, Slot.LANDING_MERCURY_RANGED_A_SQUAD),
        unit(Squad.LANDING_MERCURY_RANGED_B_SQUAD, Slot.LANDING_MERCURY_RANGED_B_SQUAD),
        unit(Squad.LANDING_MERCURY_BONUS_ANCHOR_A_SQUAD, Slot.LANDING_MERCURY_BONUS_ANCHOR_A_SQUAD),
        unit(Squad.LANDING_MERCURY_BONUS_SUPPORT_A_SQUAD,
             Slot.LANDING_MERCURY_BONUS_SUPPORT_A_SQUAD),
        unit(Squad.LANDING_MERCURY_BONUS_SUPPORT_B_SQUAD,
             Slot.LANDING_MERCURY_BONUS_SUPPORT_B_SQUAD),
        unit(Squad.LANDING_MERCURY_BONUS_SUPPORT_C_SQUAD,
             Slot.LANDING_MERCURY_BONUS_SUPPORT_C_SQUAD),
        unit(Squad.LANDING_MERCURY_BONUS_SUPPORT_D_SQUAD,
             Slot.LANDING_MERCURY_BONUS_SUPPORT_D_SQUAD),
    },
}

-- The bridge squads wait for the bridge; the far side is the sun landing.
local bridge = {
    id = "bridge",
    trigger = Slot.BRIDGE_025_PERCENT_PLAYER_TRIGGER,
    after = "cross",
    objective = Slot.EMBER_POWERHOUSE_BRIDGE_OBJECTIVE,
    squads = {
        unit(Squad.BRIDGE_VIGNETTE_SUPPORT_A_SQUAD, Slot.BRIDGE_VIGNETTE_SUPPORT_A_SQUAD),
        unit(Squad.BRIDGE_VIGNETTE_SUPPORT_B_SQUAD, Slot.BRIDGE_VIGNETTE_SUPPORT_B_SQUAD),
    },
}

local landing_sun = {
    id = "landing_sun",
    trigger = Slot.BRIDGE_075_PERCENT_PLAYER_TRIGGER,
    after = "cross",
    objective = Slot.EMBER_POWERHOUSE_LANDING_SUN_OBJECTIVE,
    squads = {
        unit(Squad.LANDING_SUN_SUPPORT_A_SQUAD, Slot.LANDING_SUN_SUPPORT_A_SQUAD),
        unit(Squad.LANDING_SUN_SUPPORT_B_SQUAD, Slot.LANDING_SUN_SUPPORT_B_SQUAD),
    },
}

-- The dropships have no encounter objective.
local bridge_crossing = {
    id = "bridge_crossing",
    trigger = Slot.BRIDGE_100_PERCENT_PLAYER_TRIGGER,
    after = "cross",
    squads = {
        unit(Squad.BRIDGE_CROSSING_DROPSHIP_A_SQUAD, Slot.BRIDGE_CROSSING_DROPSHIP_A_SQUAD),
        unit(Squad.BRIDGE_CROSSING_DROPSHIP_A_SUPPORT_A_SQUAD,
             Slot.BRIDGE_CROSSING_DROPSHIP_A_SUPPORT_A_SQUAD),
        unit(Squad.BRIDGE_CROSSING_DROPSHIP_A_SUPPORT_B_SQUAD,
             Slot.BRIDGE_CROSSING_DROPSHIP_A_SUPPORT_B_SQUAD),
        unit(Squad.BRIDGE_CROSSING_DROPSHIP_A_MELEE_A_SQUAD,
             Slot.BRIDGE_CROSSING_DROPSHIP_A_MELEE_A_SQUAD),
        unit(Squad.BRIDGE_CROSSING_DROPSHIP_A_MELEE_B_SQUAD,
             Slot.BRIDGE_CROSSING_DROPSHIP_A_MELEE_B_SQUAD),
        unit(Squad.BRIDGE_CROSSING_DROPSHIP_B_SQUAD, Slot.BRIDGE_CROSSING_DROPSHIP_B_SQUAD),
        unit(Squad.BRIDGE_CROSSING_DROPSHIP_C_SQUAD, Slot.BRIDGE_CROSSING_DROPSHIP_C_SQUAD),
        unit(Squad.BRIDGE_CROSSING_DROPSHIP_D_SQUAD, Slot.BRIDGE_CROSSING_DROPSHIP_D_SQUAD),
        unit(Squad.BRIDGE_CROSSING_SUPPORT_A_SQUAD, Slot.BRIDGE_CROSSING_SUPPORT_A_SQUAD),
        unit(Squad.BRIDGE_CROSSING_SUPPORT_B_SQUAD, Slot.BRIDGE_CROSSING_SUPPORT_B_SQUAD),
        unit(Squad.BRIDGE_CROSSING_DEFENSE_A_SQUAD, Slot.BRIDGE_CROSSING_DEFENSE_A_SQUAD),
        unit(Squad.BRIDGE_CROSSING_DEFENSE_B_SQUAD, Slot.BRIDGE_CROSSING_DEFENSE_B_SQUAD),
        unit(Squad.BRIDGE_CROSSING_RANGED_A_SQUAD, Slot.BRIDGE_CROSSING_RANGED_A_SQUAD),
    },
}

local processing_entry = {
    id = "processing_entry",
    trigger = Slot.LINK_ENTRY_PLAYER_TRIGGER,
    objective = Slot.EMBER_LINK_PROCESSING_ENTRY_OBJECTIVE,
    on_start = function(context) move(context, {Slot.LINK_ENTRY_DOOR_DEVICE}, "open") end,
    squads = {
        unit(Squad.PROCESSING_ENTRY_SUPPORT_A_SQUAD, Slot.PROCESSING_ENTRY_SUPPORT_A_SQUAD),
        unit(Squad.PROCESSING_ENTRY_SUPPORT_B_SQUAD, Slot.PROCESSING_ENTRY_SUPPORT_B_SQUAD),
        unit(Squad.PROCESSING_ENTRY_SUPPORT_C_SQUAD, Slot.PROCESSING_ENTRY_SUPPORT_C_SQUAD),
        unit(Squad.PROCESSING_ENTRY_SUPPORT_D_SQUAD, Slot.PROCESSING_ENTRY_SUPPORT_D_SQUAD),
    },
}

-- The Cabal come in while the grinder runs.
local processing_defend = {
    id = "processing_defend",
    after = "defend",
    objective = Slot.EMBER_LINK_PROCESSING_DEFEND_OBJECTIVE,
    squads = {
        unit(Squad.PROCESSING_DEFEND_ANCHOR_SQUAD, Slot.PROCESSING_DEFEND_ANCHOR_SQUAD),
        unit(Squad.PROCESSING_DEFEND_DEFENSE_A_SQUAD, Slot.PROCESSING_DEFEND_DEFENSE_A_SQUAD),
        unit(Squad.PROCESSING_DEFEND_DEFENSE_B_SQUAD, Slot.PROCESSING_DEFEND_DEFENSE_B_SQUAD),
        unit(Squad.PROCESSING_DEFEND_DEFENSE_C_SQUAD, Slot.PROCESSING_DEFEND_DEFENSE_C_SQUAD),
        unit(Squad.PROCESSING_DEFEND_DEFENSE_D_SQUAD, Slot.PROCESSING_DEFEND_DEFENSE_D_SQUAD),
        unit(Squad.PROCESSING_DEFEND_MELEE_A_SQUAD, Slot.PROCESSING_DEFEND_MELEE_A_SQUAD),
        unit(Squad.PROCESSING_DEFEND_MELEE_B_SQUAD, Slot.PROCESSING_DEFEND_MELEE_B_SQUAD),
        unit(Squad.PROCESSING_DEFEND_MELEE_C_SQUAD, Slot.PROCESSING_DEFEND_MELEE_C_SQUAD),
        unit(Squad.PROCESSING_DEFEND_MELEE_D_SQUAD, Slot.PROCESSING_DEFEND_MELEE_D_SQUAD),
        unit(Squad.PROCESSING_DEFEND_SUPPORT_A_SQUAD, Slot.PROCESSING_DEFEND_SUPPORT_A_SQUAD),
        unit(Squad.PROCESSING_DEFEND_SUPPORT_B_SQUAD, Slot.PROCESSING_DEFEND_SUPPORT_B_SQUAD),
    },
}

-- The cinder tumbler sits past the link tumbler exit, before the first ready room.
local tumbler = {
    id = "tumbler",
    trigger = Slot.TUMBLER_ENTRY_PLAYER_TRIGGER,
    objective = Slot.EMBER_CINDER_TUMBLER_OBJECTIVE,
    on_start = function(context) move(context, {Slot.TUMBLER_HATCH_DOOR_DEVICE}, "open") end,
    squads = {
        unit(Squad.TUMBLER_SUPPORT_A_SQUAD, Slot.TUMBLER_SUPPORT_A_SQUAD),
        unit(Squad.TUMBLER_SUPPORT_B_SQUAD, Slot.TUMBLER_SUPPORT_B_SQUAD),
    },
}

local ready_room_one = {
    id = "ready_room_one",
    trigger = Slot.READY_ROOM_01_SPAWN_SET_02_PLAYER_TRIGGER_80B3C618,
    objective = Slot.EMBER_CINDER_READY_ROOM_01_OBJECTIVE,
    squads = {
        unit(Squad.READY_ROOM_01_SUPPORT_A_SQUAD, Slot.READY_ROOM_01_SUPPORT_A_SQUAD),
        unit(Squad.READY_ROOM_01_SUPPORT_B_SQUAD, Slot.READY_ROOM_01_SUPPORT_B_SQUAD),
        unit(Squad.READY_ROOM_01_SUPPORT_C_SQUAD, Slot.READY_ROOM_01_SUPPORT_C_SQUAD),
        unit(Squad.READY_ROOM_01_MELEE_A_SQUAD, Slot.READY_ROOM_01_MELEE_A_SQUAD),
    },
}

-- Each sun deck retreat prefab owns its objective. The deck runs from the east entry to the
-- west exit.
local sunburn_a = {
    id = "sunburn_a",
    trigger = Slot.DECK_EAST_ENTRY_PLAYER_TRIGGER_80B3C6E8,
    objective = Slot.SUNBURN_SQUAD_RETREAT_INSTANCE_A_PREFAB_RETREAT_OBJECTIVE,
    squads = {
        unit(Squad.SUNBURN_SQUAD_RETREAT_INSTANCE_A_PREFAB_RETREAT_01_SQUAD,
             Slot.SUNBURN_SQUAD_RETREAT_INSTANCE_A_PREFAB_RETREAT_01_SQUAD),
        unit(Squad.SUNBURN_BRIDGE_SUPPORT_A_SQUAD, Slot.SUNBURN_BRIDGE_SUPPORT_A_SQUAD),
        unit(Squad.SUNBURN_DECK_EAST_SUPPORT_A_SQUAD, Slot.SUNBURN_DECK_EAST_SUPPORT_A_SQUAD),
        unit(Squad.SUNBURN_DECK_WEST_SUPPORT_A_SQUAD, Slot.SUNBURN_DECK_WEST_SUPPORT_A_SQUAD),
        unit(Squad.SUNBURN_SECRET_SUPPORT_A_SQUAD, Slot.SUNBURN_SECRET_SUPPORT_A_SQUAD),
    },
}

local sunburn_b = {
    id = "sunburn_b",
    trigger = Slot.DECK_BRIDGE_025_PERCENT_PLAYER_TRIGGER_80B3C6E8,
    objective = Slot.SUNBURN_SQUAD_RETREAT_INSTANCE_B_PREFAB_RETREAT_OBJECTIVE,
    squads = {
        unit(Squad.SUNBURN_SQUAD_RETREAT_INSTANCE_B_PREFAB_RETREAT_01_SQUAD,
             Slot.SUNBURN_SQUAD_RETREAT_INSTANCE_B_PREFAB_RETREAT_01_SQUAD),
        unit(Squad.SUNBURN_BRIDGE_SUPPORT_B_SQUAD, Slot.SUNBURN_BRIDGE_SUPPORT_B_SQUAD),
        unit(Squad.SUNBURN_DECK_EAST_SUPPORT_B_SQUAD, Slot.SUNBURN_DECK_EAST_SUPPORT_B_SQUAD),
        unit(Squad.SUNBURN_DECK_WEST_SUPPORT_B_SQUAD, Slot.SUNBURN_DECK_WEST_SUPPORT_B_SQUAD),
    },
}

local sunburn_c = {
    id = "sunburn_c",
    trigger = Slot.DECK_BRIDGE_100_PERCENT_PLAYER_TRIGGER,
    objective = Slot.SUNBURN_SQUAD_RETREAT_INSTANCE_C_PREFAB_RETREAT_OBJECTIVE,
    squads = {
        unit(Squad.SUNBURN_SQUAD_RETREAT_INSTANCE_C_PREFAB_RETREAT_01_SQUAD,
             Slot.SUNBURN_SQUAD_RETREAT_INSTANCE_C_PREFAB_RETREAT_01_SQUAD),
        unit(Squad.SUNBURN_DECK_WEST_SUPPORT_C_SQUAD, Slot.SUNBURN_DECK_WEST_SUPPORT_C_SQUAD),
    },
}

local sunburn_exit = {
    id = "sunburn_exit",
    trigger = Slot.DECK_WEST_EXIT_PLAYER_TRIGGER_80B3C6E8,
    squads = {
        unit(Squad.SUNBURN_DECK_WEST_SUPPORT_D_SQUAD, Slot.SUNBURN_DECK_WEST_SUPPORT_D_SQUAD),
    },
}

local ready_room_two = {
    id = "ready_room_two",
    trigger = Slot.READY_ROOM_02_SPAWN_SET_01_PLAYER_TRIGGER,
    objective = Slot.EMBER_CINDER_READY_ROOM_02_OBJECTIVE,
    squads = {
        unit(Squad.READY_ROOM_02_ANCHOR_SQUAD, Slot.READY_ROOM_02_ANCHOR_SQUAD),
        unit(Squad.READY_ROOM_02_MELEE_A_SQUAD, Slot.READY_ROOM_02_MELEE_A_SQUAD),
        unit(Squad.READY_ROOM_02_MELEE_B_SQUAD, Slot.READY_ROOM_02_MELEE_B_SQUAD),
        unit(Squad.READY_ROOM_02_MELEE_C_SQUAD, Slot.READY_ROOM_02_MELEE_C_SQUAD),
        unit(Squad.READY_ROOM_02_RANGED_A_SQUAD, Slot.READY_ROOM_02_RANGED_A_SQUAD),
        unit(Squad.READY_ROOM_02_RANGED_B_SQUAD, Slot.READY_ROOM_02_RANGED_B_SQUAD),
    },
}

local chamber = {
    id = "chamber",
    trigger = Slot.CHAMBER_SPAWN_SET_01_PLAYER_TRIGGER,
    squads = {
        unit(Squad.CHAMBER_DEFENSE_A_SQUAD, Slot.CHAMBER_DEFENSE_A_SQUAD),
        unit(Squad.CHAMBER_SUPPORT_A_SQUAD, Slot.CHAMBER_SUPPORT_A_SQUAD),
    },
}

local meat_grinder = {
    id = "meat_grinder",
    trigger = Slot.MEAT_GRINDER_SPAWN_SET_01_PLAYER_TRIGGER,
    objective = Slot.EMBER_CINDER_MEAT_GRINDER_OBJECTIVE,
    squads = {
        unit(Squad.MEAT_GRINDER_DEFENSE_A_SQUAD, Slot.MEAT_GRINDER_DEFENSE_A_SQUAD),
        unit(Squad.MEAT_GRINDER_DEFENSE_B_SQUAD, Slot.MEAT_GRINDER_DEFENSE_B_SQUAD),
        unit(Squad.MEAT_GRINDER_SUPPORT_A_SQUAD, Slot.MEAT_GRINDER_SUPPORT_A_SQUAD),
        unit(Squad.MEAT_GRINDER_SUPPORT_B_SQUAD, Slot.MEAT_GRINDER_SUPPORT_B_SQUAD),
        unit(Squad.MEAT_GRINDER_MELEE_A_SQUAD, Slot.MEAT_GRINDER_MELEE_A_SQUAD),
        unit(Squad.MEAT_GRINDER_MELEE_B_SQUAD, Slot.MEAT_GRINDER_MELEE_B_SQUAD),
    },
}

-- The ascent runs west from the meat grinder to the foundry overlook.
local ascent_a = {
    id = "ascent_a",
    trigger = Slot.ASCENT_SPAWN_SET_01_PLAYER_TRIGGER,
    objective = Slot.ASCENT_SQUAD_RETREAT_INSTANCE_A_PREFAB_RETREAT_OBJECTIVE,
    squads = {
        unit(Squad.ASCENT_SQUAD_RETREAT_INSTANCE_A_PREFAB_RETREAT_01_SQUAD,
             Slot.ASCENT_SQUAD_RETREAT_INSTANCE_A_PREFAB_RETREAT_01_SQUAD),
        unit(Squad.ASCENT_SUPPORT_A_SQUAD, Slot.ASCENT_SUPPORT_A_SQUAD),
    },
}

local ascent_b = {
    id = "ascent_b",
    trigger = Slot.ASCENT_SPAWN_SET_02_PLAYER_TRIGGER,
    objective = Slot.ASCENT_SQUAD_RETREAT_INSTANCE_B_PREFAB_RETREAT_OBJECTIVE,
    squads = {
        unit(Squad.ASCENT_SQUAD_RETREAT_INSTANCE_B_PREFAB_RETREAT_01_SQUAD,
             Slot.ASCENT_SQUAD_RETREAT_INSTANCE_B_PREFAB_RETREAT_01_SQUAD),
        unit(Squad.ASCENT_SUPPORT_B_SQUAD, Slot.ASCENT_SUPPORT_B_SQUAD),
    },
}

local ascent_c = {
    id = "ascent_c",
    trigger = Slot.ASCENT_SPAWN_SET_03_PLAYER_TRIGGER,
    objective = Slot.ASCENT_SQUAD_RETREAT_INSTANCE_C_PREFAB_RETREAT_OBJECTIVE,
    squads = {
        unit(Squad.ASCENT_SQUAD_RETREAT_INSTANCE_C_PREFAB_RETREAT_01_SQUAD,
             Slot.ASCENT_SQUAD_RETREAT_INSTANCE_C_PREFAB_RETREAT_01_SQUAD),
    },
}

local foundry = {
    id = "foundry",
    trigger = Slot.OVERLOOK_TO_FOUNDRY_PLAYER_TRIGGER,
    squads = {
        unit(Squad.FOUNDRY_ANCHOR_A_SQUAD, Slot.FOUNDRY_ANCHOR_A_SQUAD),
        unit(Squad.FOUNDRY_RANGED_A_SQUAD, Slot.FOUNDRY_RANGED_A_SQUAD),
        unit(Squad.FOUNDRY_RANGED_B_SQUAD, Slot.FOUNDRY_RANGED_B_SQUAD),
        unit(Squad.FOUNDRY_SUPPORT_A_SQUAD, Slot.FOUNDRY_SUPPORT_A_SQUAD),
        unit(Squad.FOUNDRY_SUPPORT_B_SQUAD, Slot.FOUNDRY_SUPPORT_B_SQUAD),
        unit(Squad.FOUNDRY_SUPPORT_C_SQUAD, Slot.FOUNDRY_SUPPORT_C_SQUAD),
        unit(Squad.FOUNDRY_SUPPORT_D_SQUAD, Slot.FOUNDRY_SUPPORT_D_SQUAD),
        unit(Squad.FOUNDRY_SUPPORT_E_SQUAD, Slot.FOUNDRY_SUPPORT_E_SQUAD),
        unit(Squad.FOUNDRY_SUPPORT_F_SQUAD, Slot.FOUNDRY_SUPPORT_F_SQUAD),
        unit(Squad.FOUNDRY_SUPPORT_G_SQUAD, Slot.FOUNDRY_SUPPORT_G_SQUAD),
        unit(Squad.FOUNDRY_SUPPORT_H_SQUAD, Slot.FOUNDRY_SUPPORT_H_SQUAD),
        unit(Squad.FOUNDRY_SUPPORT_I_SQUAD, Slot.FOUNDRY_SUPPORT_I_SQUAD),
    },
}

local security = {
    id = "security",
    trigger = Slot.SECURITY_DOOR_PLAYER_TRIGGER,
    objective = Slot.EMBER_APEX_SECURITY_OBJECTIVE,
    squads = {
        unit(Squad.SECURITY_LEDGE_SUPPORT_A_SQUAD, Slot.SECURITY_LEDGE_SUPPORT_A_SQUAD),
        unit(Squad.SECURITY_LEDGE_SUPPORT_B_SQUAD, Slot.SECURITY_LEDGE_SUPPORT_B_SQUAD),
    },
}

local access_one = {
    id = "access_one",
    trigger = Slot.ACCESS_JUMP_ONE_PLAYER_TRIGGER,
    objective = Slot.EMBER_APEX_ACCESS_OBJECTIVE,
    squads = {
        unit(Squad.ACCESS_JUMP_ONE_SUPPORT_A_SQUAD, Slot.ACCESS_JUMP_ONE_SUPPORT_A_SQUAD),
        unit(Squad.ACCESS_JUMP_ONE_SUPPORT_B_SQUAD, Slot.ACCESS_JUMP_ONE_SUPPORT_B_SQUAD),
        unit(Squad.ACCESS_JUMP_ONE_SUPPORT_C_SQUAD, Slot.ACCESS_JUMP_ONE_SUPPORT_C_SQUAD),
    },
}

local access_two = {
    id = "access_two",
    trigger = Slot.ACCESS_JUMP_TWO_PLAYER_TRIGGER,
    objective = Slot.EMBER_APEX_ACCESS_OBJECTIVE,
    squads = {
        unit(Squad.ACCESS_JUMP_TWO_SUPPORT_A_SQUAD, Slot.ACCESS_JUMP_TWO_SUPPORT_A_SQUAD),
        unit(Squad.ACCESS_JUMP_TWO_SUPPORT_B_SQUAD, Slot.ACCESS_JUMP_TWO_SUPPORT_B_SQUAD),
        unit(Squad.ACCESS_JUMP_TWO_SUPPORT_C_SQUAD, Slot.ACCESS_JUMP_TWO_SUPPORT_C_SQUAD),
    },
}

local clamshell_east = {
    id = "clamshell_east",
    trigger = Slot.REACTOR_ARM_EAST_ENTRANCE_PLAYER_TRIGGER,
    after = "vents",
    objective = Slot.EMBER_APEX_REACTOR_CLAMSHELL_EAST_OBJECTIVE,
    squads = {
        unit(Squad.REACTOR_CLAMSHELL_EAST_ANCHOR_A_SQUAD,
             Slot.REACTOR_CLAMSHELL_EAST_ANCHOR_A_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_EAST_SUPPORT_A_SQUAD,
             Slot.REACTOR_CLAMSHELL_EAST_SUPPORT_A_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_EAST_SUPPORT_B_SQUAD,
             Slot.REACTOR_CLAMSHELL_EAST_SUPPORT_B_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_EAST_SUPPORT_C_SQUAD,
             Slot.REACTOR_CLAMSHELL_EAST_SUPPORT_C_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_EAST_SUPPORT_D_SQUAD,
             Slot.REACTOR_CLAMSHELL_EAST_SUPPORT_D_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_EAST_SUPPORT_E_SQUAD,
             Slot.REACTOR_CLAMSHELL_EAST_SUPPORT_E_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_EAST_SUPPORT_F_SQUAD,
             Slot.REACTOR_CLAMSHELL_EAST_SUPPORT_F_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_EAST_MELEE_A_SQUAD, Slot.REACTOR_CLAMSHELL_EAST_MELEE_A_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_EAST_MELEE_B_SQUAD, Slot.REACTOR_CLAMSHELL_EAST_MELEE_B_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_EAST_MELEE_C_SQUAD, Slot.REACTOR_CLAMSHELL_EAST_MELEE_C_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_EAST_MELEE_D_SQUAD, Slot.REACTOR_CLAMSHELL_EAST_MELEE_D_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_EAST_MELEE_E_SQUAD, Slot.REACTOR_CLAMSHELL_EAST_MELEE_E_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_EAST_MELEE_F_SQUAD, Slot.REACTOR_CLAMSHELL_EAST_MELEE_F_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_EAST_DEFENSE_A_SQUAD,
             Slot.REACTOR_CLAMSHELL_EAST_DEFENSE_A_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_EAST_DEFENSE_B_SQUAD,
             Slot.REACTOR_CLAMSHELL_EAST_DEFENSE_B_SQUAD),
    },
}

local clamshell_west = {
    id = "clamshell_west",
    after = "vents",
    objective = Slot.EMBER_APEX_REACTOR_CLAMSHELL_WEST_OBJECTIVE,
    squads = {
        unit(Squad.REACTOR_CLAMSHELL_WEST_ANCHOR_A_SQUAD,
             Slot.REACTOR_CLAMSHELL_WEST_ANCHOR_A_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_WEST_SUPPORT_A_SQUAD,
             Slot.REACTOR_CLAMSHELL_WEST_SUPPORT_A_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_WEST_SUPPORT_B_SQUAD,
             Slot.REACTOR_CLAMSHELL_WEST_SUPPORT_B_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_WEST_SUPPORT_C_SQUAD,
             Slot.REACTOR_CLAMSHELL_WEST_SUPPORT_C_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_WEST_SUPPORT_D_SQUAD,
             Slot.REACTOR_CLAMSHELL_WEST_SUPPORT_D_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_WEST_SUPPORT_E_SQUAD,
             Slot.REACTOR_CLAMSHELL_WEST_SUPPORT_E_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_WEST_SUPPORT_F_SQUAD,
             Slot.REACTOR_CLAMSHELL_WEST_SUPPORT_F_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_WEST_MELEE_A_SQUAD, Slot.REACTOR_CLAMSHELL_WEST_MELEE_A_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_WEST_MELEE_B_SQUAD, Slot.REACTOR_CLAMSHELL_WEST_MELEE_B_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_WEST_MELEE_C_SQUAD, Slot.REACTOR_CLAMSHELL_WEST_MELEE_C_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_WEST_MELEE_D_SQUAD, Slot.REACTOR_CLAMSHELL_WEST_MELEE_D_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_WEST_MELEE_E_SQUAD, Slot.REACTOR_CLAMSHELL_WEST_MELEE_E_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_WEST_MELEE_F_SQUAD, Slot.REACTOR_CLAMSHELL_WEST_MELEE_F_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_WEST_DEFENSE_A_SQUAD,
             Slot.REACTOR_CLAMSHELL_WEST_DEFENSE_A_SQUAD),
        unit(Squad.REACTOR_CLAMSHELL_WEST_DEFENSE_B_SQUAD,
             Slot.REACTOR_CLAMSHELL_WEST_DEFENSE_B_SQUAD),
    },
}

local coffin_interior = {
    id = "coffin_interior",
    after = "core_vent",
    objective = Slot.EMBER_APEX_REACTOR_COFFIN_OBJECTIVE,
    squads = {
        unit(Squad.REACTOR_COFFIN_INTERIOR_SUPPORT_SQUAD,
             Slot.REACTOR_COFFIN_INTERIOR_SUPPORT_SQUAD),
    },
}

-- The coffin guards and the dispenser have no encounter objective.
local coffin_guard = {
    id = "coffin_guard",
    after = "search",
    squads = {
        unit(Squad.REACTOR_COFFIN_EAST_ANCHOR_A_SQUAD, Slot.REACTOR_COFFIN_EAST_ANCHOR_A_SQUAD),
        unit(Squad.REACTOR_COFFIN_EAST_DEFENSE_A_SQUAD, Slot.REACTOR_COFFIN_EAST_DEFENSE_A_SQUAD),
        unit(Squad.REACTOR_COFFIN_EAST_DEFENSE_B_SQUAD, Slot.REACTOR_COFFIN_EAST_DEFENSE_B_SQUAD),
        unit(Squad.REACTOR_COFFIN_EAST_SUPPORT_A_SQUAD, Slot.REACTOR_COFFIN_EAST_SUPPORT_A_SQUAD),
        unit(Squad.REACTOR_COFFIN_EAST_SUPPORT_B_SQUAD, Slot.REACTOR_COFFIN_EAST_SUPPORT_B_SQUAD),
        unit(Squad.REACTOR_COFFIN_EAST_SUPPORT_C_SQUAD, Slot.REACTOR_COFFIN_EAST_SUPPORT_C_SQUAD),
        unit(Squad.REACTOR_COFFIN_EAST_SUPPORT_D_SQUAD, Slot.REACTOR_COFFIN_EAST_SUPPORT_D_SQUAD),
        unit(Squad.REACTOR_COFFIN_WEST_ANCHOR_A_SQUAD, Slot.REACTOR_COFFIN_WEST_ANCHOR_A_SQUAD),
        unit(Squad.REACTOR_COFFIN_WEST_DEFENSE_A_SQUAD, Slot.REACTOR_COFFIN_WEST_DEFENSE_A_SQUAD),
        unit(Squad.REACTOR_COFFIN_WEST_DEFENSE_B_SQUAD, Slot.REACTOR_COFFIN_WEST_DEFENSE_B_SQUAD),
        unit(Squad.REACTOR_COFFIN_WEST_SUPPORT_A_SQUAD, Slot.REACTOR_COFFIN_WEST_SUPPORT_A_SQUAD),
        unit(Squad.REACTOR_COFFIN_WEST_SUPPORT_B_SQUAD, Slot.REACTOR_COFFIN_WEST_SUPPORT_B_SQUAD),
        unit(Squad.REACTOR_COFFIN_WEST_SUPPORT_C_SQUAD, Slot.REACTOR_COFFIN_WEST_SUPPORT_C_SQUAD),
        unit(Squad.REACTOR_COFFIN_WEST_SUPPORT_D_SQUAD, Slot.REACTOR_COFFIN_WEST_SUPPORT_D_SQUAD),
    },
}

local dispenser = {
    id = "dispenser",
    after = "deliver",
    squads = {
        unit(Squad.DISPENSER_SUPPORT_A_SQUAD, Slot.DISPENSER_SUPPORT_A_SQUAD),
        unit(Squad.DISPENSER_SUPPORT_B_SQUAD, Slot.DISPENSER_SUPPORT_B_SQUAD),
        unit(Squad.DISPENSER_SUPPORT_C_SQUAD, Slot.DISPENSER_SUPPORT_C_SQUAD),
    },
}

return campaign.new{
    key = "ember",
    -- The launch points are named `default`. The SDK names no spawn sets.
    spawn_set = 0x2EA8FB98,
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80B3C90A,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80B3C90A,
    legs = {
        {id = "powerhouse", state = mission.states.STATE_80B3C09E_0008_0000_80B3C09C, arm = {
            Slot.CATWALK_015_PERCENT_PLAYER_TRIGGER, Slot.PIPE_CROSSING_040_PERCENT_PLAYER_TRIGGER,
            Slot.LANDING_MERCURY_010_PERCENT_PLAYER_TRIGGER,
            Slot.POWERHOUSE_DIRECTIVE_LANDING_MERCURY_PLAYER_TRIGGER,
            Slot.BRIDGE_025_PERCENT_PLAYER_TRIGGER, Slot.BRIDGE_075_PERCENT_PLAYER_TRIGGER,
            Slot.BRIDGE_100_PERCENT_PLAYER_TRIGGER, Slot.POWERHOUSE_DIRECTIVE_BYWAY_PLAYER_TRIGGER,
        }},
        {id = "link", state = mission.states.STATE_80B3C09E_0007_0000_80B3C09B, arm = {
            Slot.LINK_ENTRY_PLAYER_TRIGGER, Slot.LINK_DIRECTIVE_TUMBLER_ENTRY_PLAYER_TRIGGER,
            Slot.LINK_DIRECTIVE_TUMBLER_OBSTRUCTION_PLAYER_TRIGGER,
            Slot.LINK_DIRECTIVE_CONTROL_PLAYER_TRIGGER, Slot.LINK_CARRY_OBJECT_PLAYER_TRIGGER,
            Slot.LINK_DIRECTIVE_TUMBLER_EXIT_PLAYER_TRIGGER,
        }},
        {id = "cinder", state = mission.states.STATE_80B3C09E_0005_0000_80B3C094, arm = {
            Slot.TUMBLER_ENTRY_PLAYER_TRIGGER,
            Slot.READY_ROOM_01_SPAWN_SET_02_PLAYER_TRIGGER_80B3C618,
            Slot.CINDER_DIRECTIVE_READY_ROOM_01_GOTO_PLAYER_TRIGGER,
            Slot.DECK_EAST_ENTRY_PLAYER_TRIGGER_80B3C6E8,
            Slot.DECK_BRIDGE_025_PERCENT_PLAYER_TRIGGER_80B3C6E8,
            Slot.DECK_BRIDGE_100_PERCENT_PLAYER_TRIGGER,
            Slot.DECK_WEST_EXIT_PLAYER_TRIGGER_80B3C6E8,
            Slot.CINDER_DIRECTIVE_SUNBURN_GOTO_PLAYER_TRIGGER,
            Slot.READY_ROOM_02_SPAWN_SET_01_PLAYER_TRIGGER,
            Slot.CINDER_DIRECTIVE_READY_ROOM_02_GOTO_PLAYER_TRIGGER,
            Slot.CHAMBER_SPAWN_SET_01_PLAYER_TRIGGER, Slot.MEAT_GRINDER_SPAWN_SET_01_PLAYER_TRIGGER,
            Slot.ASCENT_SPAWN_SET_01_PLAYER_TRIGGER, Slot.ASCENT_SPAWN_SET_02_PLAYER_TRIGGER,
            Slot.ASCENT_SPAWN_SET_03_PLAYER_TRIGGER,
            Slot.CINDER_DIRECTIVE_MEAT_GRINDER_GOTO_PLAYER_TRIGGER,
            Slot.OVERLOOK_TO_FOUNDRY_PLAYER_TRIGGER,
            Slot.CINDER_DIRECTIVE_FOUNDRY_GOTO_PLAYER_TRIGGER,
            Slot.CINDER_DIRECTIVE_CHUTE_GOTO_PLAYER_TRIGGER,
        }},
        {id = "apex", state = mission.states.STATE_80B3C09E_0000_0000_80B3C07E, arm = {
            Slot.SECURITY_DOOR_PLAYER_TRIGGER, Slot.APEX_DIRECTIVE_SECURITY_GOTO_PLAYER_TRIGGER,
            Slot.ACCESS_JUMP_ONE_PLAYER_TRIGGER, Slot.ACCESS_JUMP_TWO_PLAYER_TRIGGER,
            Slot.ACCESS_DOOR_INNER_PLAYER_TRIGGER, Slot.APEX_DIRECTIVE_REACTOR_GOTO_PLAYER_TRIGGER,
            Slot.REACTOR_ARM_EAST_ENTRANCE_PLAYER_TRIGGER,
            Slot.REACTOR_MOTHER_BRAIN_ENTRY_PLAYER_TRIGGGER,
            Slot.APEX_REACTOR_CLAMSHELL_001_DIALOG_START_PLAYER_TRIGGER,
            Slot.APEX_DIRECTIVE_REACTOR_RAILS_ESCAPE_PLAYER_TRIGGER,
        }},
    },
    steps = {
        -- "We made it. We're on the Almighty." Then the weapon comes into view on the catwalk.
        {id = "fuel", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_6D8E0897,
            navpoint = Slot.SLOT_0011_80B3DBD9,
            lines = {line(cue.CUE_0), line(cue.CUE_2, Slot.SLOT_0016_80B3DBD9)},
            ends = {trigger = Slot.POWERHOUSE_DIRECTIVE_LANDING_MERCURY_PLAYER_TRIGGER}},
        {id = "landing", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_A70DA4A6,
            navpoint = Slot.POWERHOUSE_DIRECTIVE_LANDING_MERCURY_CLEAR_NAV_POINT,
            ends = {clear = "landing_mercury"}},
        -- "Let me at that console, and I'll get the bridge back." No bridge until the scan ends.
        {id = "console", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_2700C0C5,
            navpoint = Slot.POWERHOUSE_DIRECTIVE_LANDING_MERCURY_INTERACT_NAV_POINT,
            lines = {line(cue.CUE_3)}, barrier = true,
            on_start = function(context)
                move(context, {Slot.POWERHOUSE_LANDING_MERCURY_DOOR_DEVICE}, "open")
            end,
            ends = {ghost_link = Slot.LANDING_MERCURY_CONSOLE_BUTTON_GHOST_LINK}},
        -- Zavala: "Our forces are moving into position outside the city walls."
        {id = "cross", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_AFBF882A,
            navpoint = Slot.SLOT_000D_80B3DBB9, lines = {line(cue.CUE_8)},
            on_start = function(context)
                move(context, {Slot.POWERHOUSE_BRIDGE_ARM_MERCURY_DEVICE,
                    Slot.POWERHOUSE_BRIDGE_ARM_SUN_DEVICE}, "open")
            end,
            ends = {trigger = Slot.POWERHOUSE_DIRECTIVE_BYWAY_PLAYER_TRIGGER}},
        {id = "link", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_4EA80049,
            navpoint = Slot.LINK_DIRECTIVE_LINK_GOTO_BUBBLE_NAV_POINT,
            ends = {region = "link"}},
        -- "That tunnel over there should lead us straight to the central core."
        {id = "tunnels", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_883C188D,
            navpoint = Slot.SLOT_001B_80B3DA6D, lines = {line(cue.CUE_9)},
            ends = {trigger = Slot.LINK_DIRECTIVE_TUMBLER_ENTRY_PLAYER_TRIGGER}},
        -- "Blocked. I bet we can get the grinders working and clear this."
        {id = "debris", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_591B1D88,
            navpoint = Slot.SLOT_001C_80B3DA6D, lines = {line(cue.CUE_10)},
            ends = {trigger = Slot.LINK_DIRECTIVE_TUMBLER_OBSTRUCTION_PLAYER_TRIGGER}},
        {id = "controls", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_591B1D88,
            navpoint = Slot.SLOT_0019_80B3DA6D,
            lines = {line(cue.CUE_11, Slot.SLOT_000D_80B3DA6D)},
            ends = {trigger = Slot.LINK_DIRECTIVE_CONTROL_PLAYER_TRIGGER}},
        -- "Looks like the Red Legion use fusion cells to power their machinery."
        {id = "cell", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_591B1D88,
            navpoint = Slot.LINK_CARRY_OBJECT_NAV_POINT, lines = {line(cue.CUE_14)},
            ends = {trigger = Slot.LINK_CARRY_OBJECT_PLAYER_TRIGGER}},
        {id = "grinder", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_57050F62,
            navpoint = Slot.LINK_DIRECTIVE_CONTROL_INTERACT_NAV_POINT,
            lines = {line(cue.CUE_13)},
            ends = {interact = Slot.CARRY_RECEPTACLE_INTERACT_OBJECT}},
        {id = "defend", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS,
            navpoint = Slot.SLOT_0012_80B3DA3A, lines = {line(cue.CUE_18)},
            on_start = function(context)
                move(context, {Slot.TUMBLER_CHAMBER_LEFT_DEVICE,
                    Slot.TUMBLER_CHAMBER_RIGHT_DEVICE}, "power_on")
            end,
            ends = {clear = "processing_defend"}},
        -- "Ore tunnels are clear. We can follow the fuel to the weapon's core."
        {id = "proceed", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_65D5979D,
            navpoint = Slot.SLOT_0016_80B3DA3A, lines = {line(cue.CUE_17)},
            on_start = function(context) move(context, {Slot.TUMBLER_DOOR_DEVICE}, "open") end,
            ends = {trigger = Slot.LINK_DIRECTIVE_TUMBLER_EXIT_PLAYER_TRIGGER}},
        -- Ikora sends Zavala's group to the City perimeter; Zavala says goodbye.
        {id = "chamber", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_62E3AEFB,
            navpoint = Slot.CINDER_DIRECTIVE_CINDER_GOTO_BUBBLE_NAV_POINT,
            lines = {line(cue.CUE_19), line(cue.CUE_20)},
            ends = {region = "cinder"}},
        -- "The only way to get where we're going is ...out there."
        {id = "ready_room", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_127B96D6,
            navpoint = Slot.CINDER_DIRECTIVE_READY_ROOM_01_GOTO_NAV_POINT,
            lines = {line(cue.CUE_23, Slot.SLOT_0016_80B3D6BC)},
            ends = {trigger = Slot.CINDER_DIRECTIVE_READY_ROOM_01_GOTO_PLAYER_TRIGGER}},
        -- The sun deck: "Hope you put your sunscreen on." "Stay in the shadows!"
        {id = "deck", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_D496059B,
            navpoint = Slot.CINDER_DIRECTIVE_SUNBURN_GOTO_NAV_POINT,
            lines = {line(cue.CUE_26, Slot.SLOT_0025_80B3D70B),
                line(cue.CUE_27, Slot.SLOT_0027_80B3D70B)},
            ends = {trigger = Slot.CINDER_DIRECTIVE_SUNBURN_GOTO_PLAYER_TRIGGER}},
        -- Ikora's goodbye, then "To go forward, we must go upward."
        {id = "exit", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_DF93A91C,
            navpoint = Slot.CINDER_DIRECTIVE_READY_ROOM_02_GOTO_NAV_POINT,
            lines = {line(cue.CUE_30, Slot.SLOT_0006_80B3D6D6),
                line(cue.CUE_31, Slot.SLOT_000F_80B3D6D6)},
            ends = {trigger = Slot.CINDER_DIRECTIVE_READY_ROOM_02_GOTO_PLAYER_TRIGGER}},
        -- Cayde's goodbye.
        {id = "tunnel", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_BAD7D583,
            navpoint = Slot.CINDER_DIRECTIVE_MEAT_GRINDER_GOTO_NAV_POINT,
            lines = {line(cue.CUE_32, Slot.DIALOG_CINDER_MEAT_GRINDER_001_TRIGGER_VOLUME)},
            ends = {trigger = Slot.CINDER_DIRECTIVE_MEAT_GRINDER_GOTO_PLAYER_TRIGGER}},
        -- "See those tubes? That's how we get to the weapon core."
        {id = "foundry", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_7FF69D75,
            navpoint = Slot.CINDER_DIRECTIVE_FOUNDRY_GOTO_NAV_POINT,
            lines = {line(cue.CUE_33, Slot.SLOT_0010_80B3D691)},
            on_start = function(context)
                move(context, {Slot.FOUNDRY_HATCH_DOOR_LEFT_DEVICE,
                    Slot.FOUNDRY_HATCH_DOOR_RIGHT_DEVICE}, "open")
            end,
            ends = {trigger = Slot.CINDER_DIRECTIVE_FOUNDRY_GOTO_PLAYER_TRIGGER}},
        -- The energy stream carries the player up to the apex; its goto volume is at the top.
        {id = "stream", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_FF7AB219,
            navpoint = Slot.CINDER_DIRECTIVE_CHUTE_GOTO_NAV_POINT,
            lines = {line(cue.CUE_35, Slot.SLOT_0014_80B3D67A),
                line(cue.CUE_34, Slot.SLOT_0005_80B3D67A)},
            ends = {trigger = Slot.CINDER_DIRECTIVE_CHUTE_GOTO_PLAYER_TRIGGER}},
        {id = "path", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_ECECF63D,
            navpoint = Slot.APEX_DIRECTIVE_APEX_GOTO_BUBBLE_NAV_POINT,
            ends = {region = "apex"}},
        {id = "security_door",
            directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_4E4862BB,
            navpoint = Slot.SLOT_0013_80B3D319,
            on_start = function(context) move(context, {Slot.SECURITY_DOOR_DEVICE}, "open") end,
            ends = {trigger = Slot.SECURITY_DOOR_PLAYER_TRIGGER}},
        {id = "security", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_4E4862BB,
            navpoint = Slot.SLOT_0014_80B3D319,
            ends = {trigger = Slot.APEX_DIRECTIVE_SECURITY_GOTO_PLAYER_TRIGGER}},
        -- "Interceptors. It's like they're begging us to blow this place up."
        {id = "interceptor", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_3CBFC90B,
            navpoint = Slot.SECURITY_INTERCEPTOR_NAV_POINT, lines = {line(cue.CUE_38)},
            ends = {trigger = Slot.ACCESS_JUMP_ONE_PLAYER_TRIGGER}},
        {id = "outer_door", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_3CBFC90B,
            navpoint = Slot.SLOT_0011_80B3D319,
            on_start = function(context) move(context, {Slot.ACCESS_DOOR_OUTER_DEVICE}, "open") end,
            ends = {trigger = Slot.ACCESS_JUMP_TWO_PLAYER_TRIGGER}},
        {id = "inner_door", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_3CBFC90B,
            navpoint = Slot.SLOT_000E_80B3D319,
            on_start = function(context) move(context, {Slot.ACCESS_DOOR_INNER_DEVICE}, "open") end,
            ends = {trigger = Slot.ACCESS_DOOR_INNER_PLAYER_TRIGGER}},
        {id = "reactor", directive = Directive.FIND_AND_DISABLE_THE_ALMIGHTY_S_WEAPONS_4E4862BB,
            navpoint = Slot.SLOT_0012_80B3D319,
            ends = {trigger = Slot.APEX_DIRECTIVE_REACTOR_GOTO_PLAYER_TRIGGER}},
        -- "The thermal exchangers. Take them out, and the weapon will overheat!"
        {id = "vents", directive = Directive.SABOTAGE_THE_ALMIGHTY_S_WEAPON_SYSTEMS_9DD48A8A,
            navpoint = Slot.APEX_DIRECTIVE_REACTOR_CLAMSHELL_GOTO_NAV_POINT,
            lines = {line(cue.CUE_40, Slot.SLOT_0008_80B3D2BB),
                line(cue.CUE_41, Slot.SLOT_000A_80B3D2BB)},
            on_start = function(context)
                move(context, {Slot.REACTOR_CLAMSHELL_EAST_DOOR_A_DEVICE,
                    Slot.REACTOR_CLAMSHELL_EAST_DOOR_B_DEVICE,
                    Slot.REACTOR_CLAMSHELL_WEST_DOOR_A_DEVICE,
                    Slot.REACTOR_CLAMSHELL_WEST_DOOR_B_DEVICE,
                    Slot.REACTOR_CLAMSHELL_EAST_TARGET_DEVICE,
                    Slot.REACTOR_CLAMSHELL_WEST_TARGET_DEVICE}, "open")
            end,
            ends = {destroyed = {Slot.REACTOR_CLAMSHELL_EAST_TARGET_OBJECT,
                Slot.REACTOR_CLAMSHELL_WEST_TARGET_OBJECT}}},
        -- "That's two. Last one should be ventilating the core."
        {id = "core_vent", directive = Directive.SABOTAGE_THE_ALMIGHTY_S_WEAPON_SYSTEMS_6C7F39DC,
            navpoint = Slot.APEX_DIRECTIVE_REACTOR_COFFIN_TARGET_NAV_POINT,
            lines = {line(cue.CUE_44)},
            on_start = function(context)
                move(context, {Slot.CLAMSHELL_TO_COFFIN_EAST_BRIDGE_DEVICE,
                    Slot.CLAMSHELL_TO_COFFIN_WEST_BRIDGE_DEVICE,
                    Slot.REACTOR_COFFIN_DOOR_EAST_DEVICE, Slot.REACTOR_COFFIN_DOOR_WEST_DEVICE},
                    "open")
            end,
            ends = {destroyed = {Slot.REACTOR_COFFIN_TARGET_OBJECT}}},
        -- "Temperature levels are rising, but it's not enough. We need to disrupt the core."
        {id = "search", directive = Directive.SABOTAGE_THE_ALMIGHTY_S_WEAPON_SYSTEMS_61D2B286,
            navpoint = Slot.SLOT_0012_80B3D2FF, lines = {line(cue.CUE_48)},
            on_start = function(context)
                move(context, {Slot.COFFIN_BUNKER_DOOR_SOUTH_DEVICE}, "open")
            end,
            ends = {trigger = Slot.REACTOR_MOTHER_BRAIN_ENTRY_PLAYER_TRIGGGER}},
        -- "A fusion cell. We'll use that to overload the electron reservoir."
        {id = "deliver",
            directive = Directive.DELIVER_THE_FINAL_BLOW_TO_THE_ALMIGHTY_S_WEAPON_SYSTEMS,
            navpoint = Slot.EMBER_DIRECTIVE_REACTOR_MOTHER_BRAIN_DELIVERY_NAV_POINT,
            lines = {line(cue.CUE_50)},
            on_start = function(context)
                move(context, {Slot.MOTHER_BRAIN_DOOR_DEVICE, Slot.REACTOR_SHIELD_DEVICE}, "open")
            end,
            ends = {interact = Slot.MOTHER_BRAIN_INTERACT_OBJECT}},
        -- "I'm bringing the ship around! Run!" The last lines wait on the rail as it runs east.
        {id = "escape", directive = Directive.ESCAPE_THE_ALMIGHTY,
            navpoint = Slot.APEX_DIRECTIVE_REACTOR_RAILS_ESCAPE_NAV_POINT,
            lines = {line(cue.CUE_51),
                line(cue.CUE_53, Slot.APEX_MOTHER_BRAIN_007_DIALOG_TRIGGER_VOLUME),
                line(cue.CUE_54, Slot.SLOT_0008_80B3D2DC)},
            on_start = function(context)
                move(context, {Slot.REACTOR_GETAWAY_SHIP_DEVICE}, "open")
            end,
            ends = {trigger = Slot.APEX_DIRECTIVE_REACTOR_RAILS_ESCAPE_PLAYER_TRIGGER}},
    },
    encounters = {
        helipad, catwalk, pipes, landing_mercury, bridge, landing_sun, bridge_crossing,
        processing_entry, processing_defend,
        tumbler, ready_room_one, sunburn_a, sunburn_b, sunburn_c, sunburn_exit, ready_room_two,
        chamber, meat_grinder, ascent_a, ascent_b, ascent_c, foundry,
        security, access_one, access_two, clamshell_east, clamshell_west, coffin_interior,
        coffin_guard, dispenser,
    },
}
