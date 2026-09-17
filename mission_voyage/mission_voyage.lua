-- Larceny. Red War campaign draft; not tested in game.
-- Leg order: islands -> cargo, from the transition spawn sets. Steps follow the step objects and
-- the trigger volume positions: transit, elbow, overlook, control, then the launch platform
-- where the Ghost unlocks Thumos's ship and four waves come in turn.
local missions = require("missions")
local mission = require(missions.MISSION_VOYAGE)
local campaign = require("lib.campaign")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive = mission.Slot, mission.Squad, mission.Directive
local cue = mission.DialogueCue.M_DIALOG_SENSOR_80BDA6CA

local transit = {
    id = "transit",
    after = "transit",
    objective = Slot.VOYAGE_CARGO_TRANSIT_OBJECTIVE,
    squads = {
        unit(Squad.CORRIDOR_EXIT_FALLEN_SUPPORT_SQUAD, Slot.CORRIDOR_EXIT_FALLEN_SUPPORT_SQUAD),
        unit(Squad.CORRIDOR_MID_FALLEN_SUPPORT_A_SQUAD, Slot.CORRIDOR_MID_FALLEN_SUPPORT_A_SQUAD),
        unit(Squad.TRANSIT_BALCONY_CABAL_SUPPORT_A_SQUAD,
             Slot.TRANSIT_BALCONY_CABAL_SUPPORT_A_SQUAD),
        unit(Squad.TRANSIT_BALCONY_CABAL_SUPPORT_B_SQUAD,
             Slot.TRANSIT_BALCONY_CABAL_SUPPORT_B_SQUAD),
        unit(Squad.TRANSIT_BRIDGE_CABAL_SUPPORT_A_SQUAD, Slot.TRANSIT_BRIDGE_CABAL_SUPPORT_A_SQUAD),
        unit(Squad.TRANSIT_BRIDGE_CABAL_SUPPORT_B_SQUAD, Slot.TRANSIT_BRIDGE_CABAL_SUPPORT_B_SQUAD),
        unit(Squad.TRANSIT_BRIDGE_FALLEN_SUPPORT_A_SQUAD,
             Slot.TRANSIT_BRIDGE_FALLEN_SUPPORT_A_SQUAD),
        unit(Squad.TRANSIT_BRIDGE_FALLEN_SUPPORT_B_SQUAD,
             Slot.TRANSIT_BRIDGE_FALLEN_SUPPORT_B_SQUAD),
        unit(Squad.TRANSIT_ENTRY_FALLEN_SUPPORT_SQUAD, Slot.TRANSIT_ENTRY_FALLEN_SUPPORT_SQUAD),
        unit(Squad.TRANSIT_LANE_CABAL_SUPPORT_A_SQUAD, Slot.TRANSIT_LANE_CABAL_SUPPORT_A_SQUAD),
        unit(Squad.TRANSIT_LANE_CABAL_SUPPORT_B_SQUAD, Slot.TRANSIT_LANE_CABAL_SUPPORT_B_SQUAD),
        unit(Squad.TRANSIT_LEDGE_CABAL_SUPPORT_SQUAD, Slot.TRANSIT_LEDGE_CABAL_SUPPORT_SQUAD),
        unit(Squad.CABAL_CRAWL_TO_DEATH_SCRIPT_PREFAB_CRAWL_SQUAD,
             Slot.CABAL_CRAWL_TO_DEATH_SCRIPT_PREFAB_CRAWL_SQUAD),
    },
}

local bay = {
    id = "bay",
    trigger = Slot.VOYAGE_CARGO_INTERIOR_ELBOW_DOOR_PLAYER_TRIGGER,
    objective = Slot.VOYAGE_CARGO_BAY_NORTH_OBJECTIVE,
    squads = {
        unit(Squad.BAY_NORTH_CABAL_SUPPORT_A_SQUAD, Slot.BAY_NORTH_CABAL_SUPPORT_A_SQUAD),
        unit(Squad.BAY_NORTH_CABAL_SUPPORT_B_SQUAD, Slot.BAY_NORTH_CABAL_SUPPORT_B_SQUAD),
        unit(Squad.BAY_NORTH_CABAL_SUPPORT_C_SQUAD, Slot.BAY_NORTH_CABAL_SUPPORT_C_SQUAD),
        unit(Squad.BAY_NORTH_CABAL_SUPPORT_D_SQUAD, Slot.BAY_NORTH_CABAL_SUPPORT_D_SQUAD),
        unit(Squad.BAY_NORTH_FALLEN_SUPPORT_A_SQUAD, Slot.BAY_NORTH_FALLEN_SUPPORT_A_SQUAD),
        unit(Squad.BAY_NORTH_FALLEN_SUPPORT_B_SQUAD, Slot.BAY_NORTH_FALLEN_SUPPORT_B_SQUAD),
    },
}

local elbow = {
    id = "elbow",
    trigger = Slot.ELBOW_CORNER_TURRET_WAKE_PLAYER_TRIGGER,
    objective = Slot.VOYAGE_CARGO_ELBOW_OBJECTIVE,
    squads = {
        unit(Squad.ELBOW_EXIT_CABAL_SUPPORT_A_SQUAD, Slot.ELBOW_EXIT_CABAL_SUPPORT_A_SQUAD),
        unit(Squad.ELBOW_EXIT_CABAL_SUPPORT_B_SQUAD, Slot.ELBOW_EXIT_CABAL_SUPPORT_B_SQUAD),
    },
}

local overlook = {
    id = "overlook",
    trigger = Slot.OVERLOOK_ENTRANCE_SPAWN_SQUADS_SET_01_PLAYER_TRIGGER,
    objective = Slot.VOYAGE_CARGO_OVERLOOK_OBJECTIVE,
    squads = {
        unit(Squad.OVERLOOK_ENTRANCE_CABAL_SUPPORT_A_SQUAD,
             Slot.OVERLOOK_ENTRANCE_CABAL_SUPPORT_A_SQUAD),
        unit(Squad.OVERLOOK_ENTRANCE_FALLEN_MELEE_A_SQUAD,
             Slot.OVERLOOK_ENTRANCE_FALLEN_MELEE_A_SQUAD),
        unit(Squad.OVERLOOK_ENTRANCE_FALLEN_MELEE_B_SQUAD,
             Slot.OVERLOOK_ENTRANCE_FALLEN_MELEE_B_SQUAD),
        unit(Squad.OVERLOOK_ENTRANCE_FALLEN_MELEE_C_SQUAD,
             Slot.OVERLOOK_ENTRANCE_FALLEN_MELEE_C_SQUAD),
        unit(Squad.OVERLOOK_ENTRANCE_FALLEN_SUPPORT_A_SQUAD,
             Slot.OVERLOOK_ENTRANCE_FALLEN_SUPPORT_A_SQUAD),
        unit(Squad.OVERLOOK_ENTRANCE_FALLEN_SUPPORT_B_SQUAD,
             Slot.OVERLOOK_ENTRANCE_FALLEN_SUPPORT_B_SQUAD),
        unit(Squad.OVERLOOK_ENTRANCE_FALLEN_SUPPORT_C_SQUAD,
             Slot.OVERLOOK_ENTRANCE_FALLEN_SUPPORT_C_SQUAD),
        unit(Squad.OVERLOOK_ENTRANCE_FALLEN_SUPPORT_D_SQUAD,
             Slot.OVERLOOK_ENTRANCE_FALLEN_SUPPORT_D_SQUAD),
        unit(Squad.OVERLOOK_MID_FALLEN_RANGED_A_SQUAD, Slot.OVERLOOK_MID_FALLEN_RANGED_A_SQUAD),
        unit(Squad.OVERLOOK_MID_FALLEN_RANGED_B_SQUAD, Slot.OVERLOOK_MID_FALLEN_RANGED_B_SQUAD),
        unit(Squad.OVERLOOK_MID_FALLEN_SUPPORT_A_SQUAD, Slot.OVERLOOK_MID_FALLEN_SUPPORT_A_SQUAD),
        unit(Squad.OVERLOOK_MID_FALLEN_SUPPORT_B_SQUAD, Slot.OVERLOOK_MID_FALLEN_SUPPORT_B_SQUAD),
        unit(Squad.OVERLOOK_MID_FALLEN_SUPPORT_C_SQUAD, Slot.OVERLOOK_MID_FALLEN_SUPPORT_C_SQUAD),
    },
}

local junction = {
    id = "junction",
    trigger = Slot.JUNCTION_MID_SPAWN_SQUADS_SET_02_PLAYER_TRIGGER,
    objective = Slot.VOYAGE_CARGO_JUNCTION_OBJECTIVE,
    squads = {
        unit(Squad.JUNCTION_MID_FALLEN_ANCHOR_A_SQUAD, Slot.JUNCTION_MID_FALLEN_ANCHOR_A_SQUAD),
        unit(Squad.JUNCTION_MID_FALLEN_SUPPORT_A_SQUAD, Slot.JUNCTION_MID_FALLEN_SUPPORT_A_SQUAD),
        unit(Squad.JUNCTION_MID_FALLEN_SUPPORT_B_SQUAD, Slot.JUNCTION_MID_FALLEN_SUPPORT_B_SQUAD),
        unit(Squad.JUNCTION_MID_FALLEN_SUPPORT_C_SQUAD, Slot.JUNCTION_MID_FALLEN_SUPPORT_C_SQUAD),
        unit(Squad.JUNCTION_MID_FALLEN_SUPPORT_D_SQUAD, Slot.JUNCTION_MID_FALLEN_SUPPORT_D_SQUAD),
        unit(Squad.JUNCTION_MID_FALLEN_SUPPORT_E_SQUAD, Slot.JUNCTION_MID_FALLEN_SUPPORT_E_SQUAD),
    },
}

local control = {
    id = "control",
    trigger = Slot.CONTROL_MID_SPAWN_SQUADS_SET_02_PLAYER_TRIGGER,
    objective = Slot.VOYAGE_CARGO_CONTROL_OBJECTIVE,
    squads = {
        unit(Squad.CONTROL_ENTRY_CABAL_ANCHOR_A_SQUAD, Slot.CONTROL_ENTRY_CABAL_ANCHOR_A_SQUAD),
        unit(Squad.CONTROL_ENTRY_CABAL_SUPPORT_A_SQUAD, Slot.CONTROL_ENTRY_CABAL_SUPPORT_A_SQUAD),
        unit(Squad.CONTROL_ENTRY_CABAL_SUPPORT_B_SQUAD, Slot.CONTROL_ENTRY_CABAL_SUPPORT_B_SQUAD),
        unit(Squad.CONTROL_MID_CABAL_SUPPORT_A_SQUAD, Slot.CONTROL_MID_CABAL_SUPPORT_A_SQUAD),
        unit(Squad.CONTROL_MID_CABAL_SUPPORT_B_SQUAD, Slot.CONTROL_MID_CABAL_SUPPORT_B_SQUAD),
        unit(Squad.CONTROL_MID_CABAL_SUPPORT_C_SQUAD, Slot.CONTROL_MID_CABAL_SUPPORT_C_SQUAD),
        unit(Squad.CONTROL_MID_CABAL_SUPPORT_D_SQUAD, Slot.CONTROL_MID_CABAL_SUPPORT_D_SQUAD),
        unit(Squad.CONTROL_MID_CABAL_SUPPORT_E_SQUAD, Slot.CONTROL_MID_CABAL_SUPPORT_E_SQUAD),
        unit(Squad.CONTROL_MID_CABAL_SUPPORT_F_SQUAD, Slot.CONTROL_MID_CABAL_SUPPORT_F_SQUAD),
        unit(Squad.CONTROL_MID_CABAL_SUPPORT_G_SQUAD, Slot.CONTROL_MID_CABAL_SUPPORT_G_SQUAD),
        unit(Squad.CONTROL_MID_CABAL_SUPPORT_H_SQUAD, Slot.CONTROL_MID_CABAL_SUPPORT_H_SQUAD),
        unit(Squad.CONTROL_MID_CABAL_SUPPORT_I_SQUAD, Slot.CONTROL_MID_CABAL_SUPPORT_I_SQUAD),
        unit(Squad.CONTROL_MID_CABAL_SUPPORT_J_SQUAD, Slot.CONTROL_MID_CABAL_SUPPORT_J_SQUAD),
        unit(Squad.CONTROL_MID_CABAL_MELEE_A_SQUAD, Slot.CONTROL_MID_CABAL_MELEE_A_SQUAD),
        unit(Squad.CONTROL_MID_CABAL_MELEE_B_SQUAD, Slot.CONTROL_MID_CABAL_MELEE_B_SQUAD),
    },
}

-- The launch platform assault and the ships overhead carry no encounter objective.
local launch_assault = {
    id = "launch_assault",
    trigger = Slot.LAUNCH_ENTRY_EDGE_PLAYER_TRIGGER,
    squads = {
        unit(Squad.LAUNCH_ASSAULT_CABAL_DROPSHIP_A_SQUAD,
             Slot.LAUNCH_ASSAULT_CABAL_DROPSHIP_A_SQUAD),
        unit(Squad.LAUNCH_ASSAULT_CABAL_SUPPORT_A_SQUAD, Slot.LAUNCH_ASSAULT_CABAL_SUPPORT_A_SQUAD),
        unit(Squad.LAUNCH_ASSAULT_CABAL_SUPPORT_B_SQUAD, Slot.LAUNCH_ASSAULT_CABAL_SUPPORT_B_SQUAD),
        unit(Squad.LAUNCH_ASSAULT_CABAL_SUPPORT_C_SQUAD, Slot.LAUNCH_ASSAULT_CABAL_SUPPORT_C_SQUAD),
        unit(Squad.LAUNCH_ASSAULT_CABAL_SUPPORT_D_SQUAD, Slot.LAUNCH_ASSAULT_CABAL_SUPPORT_D_SQUAD),
        unit(Squad.LAUNCH_ASSAULT_CABAL_SUPPORT_E_SQUAD, Slot.LAUNCH_ASSAULT_CABAL_SUPPORT_E_SQUAD),
        unit(Squad.LAUNCH_ASSAULT_CABAL_SUPPORT_F_SQUAD, Slot.LAUNCH_ASSAULT_CABAL_SUPPORT_F_SQUAD),
        unit(Squad.LAUNCH_VIGNETTE_FALLEN_DROPSHIP_A_SQUAD,
             Slot.LAUNCH_VIGNETTE_FALLEN_DROPSHIP_A_SQUAD),
        unit(Squad.LAUNCH_VIGNETTE_FALLEN_DROPSHIP_B_SQUAD,
             Slot.LAUNCH_VIGNETTE_FALLEN_DROPSHIP_B_SQUAD),
        unit(Squad.LAUNCH_VIGNETTE_FALLEN_DROPSHIP_C_SQUAD,
             Slot.LAUNCH_VIGNETTE_FALLEN_DROPSHIP_C_SQUAD),
        unit(Squad.LAUNCH_VIGNETTE_CABAL_DROPSHIP_A_SQUAD,
             Slot.LAUNCH_VIGNETTE_CABAL_DROPSHIP_A_SQUAD),
        unit(Squad.LAUNCH_VIGNETTE_CABAL_DROPSHIP_B_SQUAD,
             Slot.LAUNCH_VIGNETTE_CABAL_DROPSHIP_B_SQUAD),
        unit(Squad.LAUNCH_VIGNETTE_CABAL_SUPPORT_A_SQUAD,
             Slot.LAUNCH_VIGNETTE_CABAL_SUPPORT_A_SQUAD),
        unit(Squad.LAUNCH_VIGNETTE_CABAL_SUPPORT_B_SQUAD,
             Slot.LAUNCH_VIGNETTE_CABAL_SUPPORT_B_SQUAD),
        unit(Squad.LAUNCH_VIGNETTE_CABAL_SUPPORT_C_SQUAD,
             Slot.LAUNCH_VIGNETTE_CABAL_SUPPORT_C_SQUAD),
    },
}

local wave_0 = {
    id = "wave_0",
    after = "wave_0",
    objective = Slot.VOYAGE_CARGO_LAUNCH_DEFEND_W0_CABAL_OBJECTIVE,
    squads = {
        unit(Squad.LAUNCH_DEFEND_W0_CABAL_SUPPORT_A_SQUAD,
             Slot.LAUNCH_DEFEND_W0_CABAL_SUPPORT_A_SQUAD),
        unit(Squad.LAUNCH_DEFEND_W0_CABAL_SUPPORT_B_SQUAD,
             Slot.LAUNCH_DEFEND_W0_CABAL_SUPPORT_B_SQUAD),
    },
}

-- A dropship may never report its members gone, so no step waits on it.
local wave_0_ships = {
    id = "wave_0_ships",
    after = "wave_0",
    objective = Slot.VOYAGE_CARGO_LAUNCH_DEFEND_W0_CABAL_OBJECTIVE,
    squads = {
        unit(Squad.LAUNCH_DEFEND_W0_CABAL_DROPSHIP_A_SQUAD,
             Slot.LAUNCH_DEFEND_W0_CABAL_DROPSHIP_A_SQUAD),
    },
}

local wave_1 = {
    id = "wave_1",
    after = "wave_1",
    objective = Slot.VOYAGE_CARGO_LAUNCH_DEFEND_W1_CABAL_OBJECTIVE,
    squads = {
        unit(Squad.LAUNCH_DEFEND_W1_CABAL_MELEE_A_SQUAD, Slot.LAUNCH_DEFEND_W1_CABAL_MELEE_A_SQUAD),
        unit(Squad.LAUNCH_DEFEND_W1_CABAL_MELEE_B_SQUAD, Slot.LAUNCH_DEFEND_W1_CABAL_MELEE_B_SQUAD),
        unit(Squad.LAUNCH_DEFEND_W1_CABAL_RANGED_A_SQUAD,
             Slot.LAUNCH_DEFEND_W1_CABAL_RANGED_A_SQUAD),
        unit(Squad.LAUNCH_DEFEND_W1_CABAL_RANGED_B_SQUAD,
             Slot.LAUNCH_DEFEND_W1_CABAL_RANGED_B_SQUAD),
        unit(Squad.LAUNCH_DEFEND_W1_CABAL_SUPPORT_A_SQUAD,
             Slot.LAUNCH_DEFEND_W1_CABAL_SUPPORT_A_SQUAD),
        unit(Squad.LAUNCH_DEFEND_W1_CABAL_SUPPORT_B_SQUAD,
             Slot.LAUNCH_DEFEND_W1_CABAL_SUPPORT_B_SQUAD),
        unit(Squad.LAUNCH_DEFEND_W1_CABAL_SUPPORT_C_SQUAD,
             Slot.LAUNCH_DEFEND_W1_CABAL_SUPPORT_C_SQUAD),
    },
}

local wave_2 = {
    id = "wave_2",
    after = "wave_2",
    objective = Slot.VOYAGE_CARGO_LAUNCH_DEFEND_W2_FALLEN_OBJECTIVE,
    squads = {
        unit(Squad.LAUNCH_DEFEND_W2_FALLEN_ANCHOR_A_SQUAD,
             Slot.LAUNCH_DEFEND_W2_FALLEN_ANCHOR_A_SQUAD),
        unit(Squad.LAUNCH_DEFEND_W2_FALLEN_SUPPORT_A_SQUAD,
             Slot.LAUNCH_DEFEND_W2_FALLEN_SUPPORT_A_SQUAD),
        unit(Squad.LAUNCH_DEFEND_W2_FALLEN_SUPPORT_B_SQUAD,
             Slot.LAUNCH_DEFEND_W2_FALLEN_SUPPORT_B_SQUAD),
        unit(Squad.LAUNCH_DEFEND_W2_FALLEN_SUPPORT_C_SQUAD,
             Slot.LAUNCH_DEFEND_W2_FALLEN_SUPPORT_C_SQUAD),
        unit(Squad.LAUNCH_DEFEND_W2_FALLEN_SUPPORT_D_SQUAD,
             Slot.LAUNCH_DEFEND_W2_FALLEN_SUPPORT_D_SQUAD),
        unit(Squad.LAUNCH_DEFEND_W2_FALLEN_TANK_A_SQUAD, Slot.LAUNCH_DEFEND_W2_FALLEN_TANK_A_SQUAD),
    },
}

-- A dropship may never report its members gone, so no step waits on it.
local wave_2_ships = {
    id = "wave_2_ships",
    after = "wave_2",
    objective = Slot.VOYAGE_CARGO_LAUNCH_DEFEND_W2_FALLEN_OBJECTIVE,
    squads = {
        unit(Squad.LAUNCH_DEFEND_W2_FALLEN_DROPSHIP_A_SQUAD,
             Slot.LAUNCH_DEFEND_W2_FALLEN_DROPSHIP_A_SQUAD),
        unit(Squad.LAUNCH_DEFEND_W2_FALLEN_DROPSHIP_B_SQUAD,
             Slot.LAUNCH_DEFEND_W2_FALLEN_DROPSHIP_B_SQUAD),
    },
}

-- The Cabal dropships of the Fallen wave carry no encounter objective.
local wave_2_cabal_ships = {
    id = "wave_2_cabal_ships",
    after = "wave_2",
    squads = {
        unit(Squad.LAUNCH_DEFEND_W2_CABAL_DROPSHIP_A_SQUAD,
             Slot.LAUNCH_DEFEND_W2_CABAL_DROPSHIP_A_SQUAD),
        unit(Squad.LAUNCH_DEFEND_W2_CABAL_DROPSHIP_B_SQUAD,
             Slot.LAUNCH_DEFEND_W2_CABAL_DROPSHIP_B_SQUAD),
        unit(Squad.LAUNCH_DEFEND_W2_CABAL_DROPSHIP_C_SQUAD,
             Slot.LAUNCH_DEFEND_W2_CABAL_DROPSHIP_C_SQUAD),
    },
}

local wave_3 = {
    id = "wave_3",
    after = "wave_3",
    objective = Slot.VOYAGE_CARGO_LAUNCH_DEFEND_W3_CABAL_OBJECTIVE,
    squads = {
        unit(Squad.LAUNCH_DEFEND_W3_CABAL_ANCHOR_A_SQUAD,
             Slot.LAUNCH_DEFEND_W3_CABAL_ANCHOR_A_SQUAD),
        unit(Squad.LAUNCH_DEFEND_W3_CABAL_SUPPORT_A_SQUAD,
             Slot.LAUNCH_DEFEND_W3_CABAL_SUPPORT_A_SQUAD),
        unit(Squad.LAUNCH_DEFEND_W3_CABAL_SUPPORT_B_SQUAD,
             Slot.LAUNCH_DEFEND_W3_CABAL_SUPPORT_B_SQUAD),
        unit(Squad.LAUNCH_DEFEND_W3_CABAL_SUPPORT_C_SQUAD,
             Slot.LAUNCH_DEFEND_W3_CABAL_SUPPORT_C_SQUAD),
    },
}

-- A dropship may never report its members gone, so no step waits on it.
local wave_3_ships = {
    id = "wave_3_ships",
    after = "wave_3",
    objective = Slot.VOYAGE_CARGO_LAUNCH_DEFEND_W3_CABAL_OBJECTIVE,
    squads = {
        unit(Squad.LAUNCH_DEFEND_W3_CABAL_DROPSHIP_A_SQUAD,
             Slot.LAUNCH_DEFEND_W3_CABAL_DROPSHIP_A_SQUAD),
        unit(Squad.LAUNCH_DEFEND_W3_CABAL_DROPSHIP_B_SQUAD,
             Slot.LAUNCH_DEFEND_W3_CABAL_DROPSHIP_B_SQUAD),
        unit(Squad.LAUNCH_DEFEND_W3_CABAL_DROPSHIP_C_SQUAD,
             Slot.LAUNCH_DEFEND_W3_CABAL_DROPSHIP_C_SQUAD),
    },
}

local fight = Directive.STEAL_THUMOS_S_SHIP
local protect = Directive.PROTECT_THE_SHIP_AT_ALL_COSTS

return campaign.new{
    key = "voyage",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80BDA6CA,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80BDA6CA,
    legs = {
        {id = "islands", state = mission.states.STATE_80BDA2F4_0027_0000_80BDA753, arm = {
            Slot.VOYAGE_ISLANDS_TRAVEL_PLAYER_TRIGGER,
        }},
        {id = "cargo", state = mission.states.STATE_80BDA2F4_0008_0000_80BDA745, arm = {
            Slot.VOYAGE_CARGO_INTERIOR_TRANSIT_PLAYER_TRIGGER,
            Slot.VOYAGE_CARGO_INTERIOR_ELBOW_DOOR_PLAYER_TRIGGER,
            Slot.ELBOW_CORNER_TURRET_WAKE_PLAYER_TRIGGER,
            Slot.OVERLOOK_ENTRANCE_SPAWN_SQUADS_SET_01_PLAYER_TRIGGER,
            Slot.JUNCTION_MID_SPAWN_SQUADS_SET_02_PLAYER_TRIGGER,
            Slot.VOYAGE_CARGO_INTERIOR_OVERLOOK_DOOR_PLAYER_TRIGGER_80BDBDC6,
            Slot.CONTROL_MID_SPAWN_SQUADS_SET_02_PLAYER_TRIGGER,
            Slot.VOYAGE_CARGO_INTERIOR_CONTROL_DOOR_PLAYER_TRIGGER,
            Slot.LAUNCH_ENTRY_EDGE_PLAYER_TRIGGER, Slot.LAUNCH_PLATFORM_NORTH_PLAYER_TRIGGER,
        }},
    },
    steps = {
        {id = "lz", directive = Directive.STEAL_THUMOS_S_SHIP_7E10828E,
            navpoint = Slot.VOYAGE_ISLANDS_TRAVEL_NAV_POINT,
            ends = {trigger = Slot.VOYAGE_ISLANDS_TRAVEL_PLAYER_TRIGGER}},
        {id = "breach", directive = Directive.STEAL_THUMOS_S_SHIP_2F95E695,
            navpoint = Slot.VOYAGE_CARGO_GOTO_BUBBLE_NAV_POINT,
            ends = {region = "cargo"}},
        {id = "transit", directive = Directive.STEAL_THUMOS_S_SHIP_73A04800,
            navpoint = Slot.VOYAGE_CARGO_INTERIOR_TRANSIT_NAV_POINT,
            ends = {trigger = Slot.VOYAGE_CARGO_INTERIOR_TRANSIT_PLAYER_TRIGGER}},
        {id = "elbow", directive = Directive.STEAL_THUMOS_S_SHIP_53D3A2E7,
            navpoint = Slot.VOYAGE_CARGO_INTERIOR_ELBOW_DOOR_NAV_POINT,
            on_start = function(context)
                move(context, {Slot.DOOR_ELBOW_TO_ISLANDS_DEVICE, Slot.DOOR_ELBOW_TO_DISH_DEVICE},
                    "open")
            end,
            ends = {trigger = Slot.VOYAGE_CARGO_INTERIOR_ELBOW_DOOR_PLAYER_TRIGGER}},
        {id = "overlook", directive = fight,
            navpoint = Slot.VOYAGE_CARGO_INTERIOR_OVERLOOK_DOOR_NAV_POINT,
            ends = {trigger = Slot.VOYAGE_CARGO_INTERIOR_OVERLOOK_DOOR_PLAYER_TRIGGER_80BDBDC6}},
        {id = "control", directive = Directive.STEAL_THUMOS_S_SHIP_38955766,
            navpoint = Slot.VOYAGE_CARGO_INTERIOR_CONTROL_DOOR_NAV_POINT,
            on_start = function(context)
                move(context, {Slot.DOOR_VOYAGE_CONTROL_ENTRY_DEVICE}, "open")
            end,
            ends = {trigger = Slot.VOYAGE_CARGO_INTERIOR_CONTROL_DOOR_PLAYER_TRIGGER}},
        {id = "launch", directive = Directive.STEAL_THUMOS_S_SHIP_786F3078,
            navpoint = Slot.SLOT_0009_80BDBD61,
            on_start = function(context)
                move(context, {Slot.DOOR_VOYAGE_CONTROL_EXIT_DEVICE, Slot.DOOR_GARAGE_ENTRY_DEVICE,
                    Slot.DOOR_REFINERY_ENTRY_DEVICE}, "open")
            end,
            ends = {trigger = Slot.LAUNCH_PLATFORM_NORTH_PLAYER_TRIGGER}},
        {id = "unlock", directive = Directive.USE_THE_STOLEN_KEY_CODES,
            navpoint = Slot.VOYAGE_CARGO_EXTERIOR_LAUNCH_INTERACT_NAV_POINT,
            ends = {ghost_link = Slot.VOYAGE_EXTERIOR_LAUNCH_SHIP_GHOST_LINK}},
        -- "Cover me. I need to figure out how this works."
        {id = "wave_0", directive = protect, navpoint = Slot.SLOT_000E_80BDBD6C,
            lines = {line(cue.CUE_12)}, barrier = true,
            ends = {clear = "wave_0"}},
        {id = "wave_1", directive = protect, navpoint = Slot.SLOT_000E_80BDBD6C,
            barrier = true, ends = {clear = "wave_1"}},
        -- "I don't hear dying! Still in one piece?"
        {id = "wave_2", directive = protect, navpoint = Slot.SLOT_000E_80BDBD6C,
            lines = {line(cue.CUE_15)}, barrier = true,
            ends = {clear = "wave_2"}},
        {id = "wave_3", directive = protect, navpoint = Slot.SLOT_000E_80BDBD6C,
            barrier = true, ends = {clear = "wave_3"}},
        -- "The key codes work! Finish them off and get on board!"
        {id = "board", directive = Directive.STEAL_THUMOS_S_SHIP_DEFC3E4D,
            navpoint = Slot.VOYAGE_CARGO_EXTERIOR_LAUNCH_SHIP_NAV_POINT,
            lines = {line(cue.CUE_17)}},
    },
    encounters = {
        transit, bay, elbow, overlook, junction, control, launch_assault, wave_0, wave_0_ships,
        wave_1, wave_2, wave_2_ships, wave_2_cabal_ships, wave_3, wave_3_ships,
    },
}
