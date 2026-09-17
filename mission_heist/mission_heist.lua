-- Fury. Red War campaign draft; not tested in game.
-- Leg order: oasis -> shield -> bunker -> shield -> mind_b. Steps follow the step objects and
-- their lines: the drill console fails, the override is in the bunker, and the drill comes on
-- only after the player returns ("Whoa. The drill's on.").
local missions = require("missions")
local mission = require(missions.MISSION_HEIST)
local campaign = require("lib.campaign")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive = mission.Slot, mission.Squad, mission.Directive
local cue = mission.DialogueCue.M_DIALOG_SENSOR_80BD26B5

local road = {
    id = "road",
    trigger = Slot.GOTO_SHIELD_FROM_OASIS_TRIGGER,
    objective = Slot.MISSION_HEIST_GOTO_BUNKER_OBJECTIVE,
    squads = {
        unit(Squad.GOTO_BUNKER_GOBLIN_SQUAD_1, Slot.GOTO_BUNKER_GOBLIN_SQUAD_1),
        unit(Squad.GOTO_BUNKER_GOBLIN_SQUAD_2, Slot.GOTO_BUNKER_GOBLIN_SQUAD_2),
        unit(Squad.GOTO_BUNKER_GOBLIN_SQUAD_3, Slot.GOTO_BUNKER_GOBLIN_SQUAD_3),
        unit(Squad.GOTO_BUNKER_MINOTAUR_SQUAD, Slot.GOTO_BUNKER_MINOTAUR_SQUAD),
        unit(Squad.GOTO_BUNKER_HOBGOBLIN_SQUAD, Slot.GOTO_BUNKER_HOBGOBLIN_SQUAD),
    },
}

local drill_site = {
    id = "drill_site",
    trigger = Slot.FRONTDOOR_SPAWN_TRIGGER,
    objective = Slot.MISSION_HEIST_SHIELD_DRILL_OBJECTIVE,
    squads = {
        unit(Squad.DRILL_DOOR_FRONT_PHALANX_SQUAD, Slot.DRILL_DOOR_FRONT_PHALANX_SQUAD),
        unit(Squad.DRILL_DOOR_FRONT_PSION_SQUAD, Slot.DRILL_DOOR_FRONT_PSION_SQUAD),
        unit(Squad.DRILL_DOOR_BACK_CENTURION_SQUAD, Slot.DRILL_DOOR_BACK_CENTURION_SQUAD),
        unit(Squad.DRILL_DOOR_BACK_PSION_SQUAD, Slot.DRILL_DOOR_BACK_PSION_SQUAD),
        unit(Squad.DRILL_FOOT_SQUAD01, Slot.DRILL_FOOT_SQUAD01),
        unit(Squad.DRILL_FOOT_SQUAD02, Slot.DRILL_FOOT_SQUAD02),
        unit(Squad.DRILL_FOOT_ANCHOR_SQUAD, Slot.DRILL_FOOT_ANCHOR_SQUAD),
        unit(Squad.DRILL_BRIDGE_SQUAD, Slot.DRILL_BRIDGE_SQUAD),
        unit(Squad.DRILL_MID_PHALANX_SQUAD, Slot.DRILL_MID_PHALANX_SQUAD),
        unit(Squad.DRILL_MID_PSION_SQUAD, Slot.DRILL_MID_PSION_SQUAD),
    },
}

-- The war base groups carry no encounter objective.
local warbase = {
    id = "warbase",
    trigger = Slot.BACKDOOR_SPAWN_TRIGGER,
    squads = {
        unit(Squad.DOOR_ANCHOR_SQUAD, Slot.DOOR_ANCHOR_SQUAD),
        unit(Squad.DOOR_FODDER_SQUAD01, Slot.DOOR_FODDER_SQUAD01),
        unit(Squad.DOOR_FODDER_SQUAD02, Slot.DOOR_FODDER_SQUAD02),
        unit(Squad.DOOR_SNIPER_SQUAD, Slot.DOOR_SNIPER_SQUAD),
        unit(Squad.BACKDOOR_ANCHOR_SQUAD, Slot.BACKDOOR_ANCHOR_SQUAD),
        unit(Squad.BACKDOOR_FODDER_SQUAD, Slot.BACKDOOR_FODDER_SQUAD),
        unit(Squad.CONSOLE_ANCHOR_SQUAD, Slot.CONSOLE_ANCHOR_SQUAD),
        unit(Squad.CONSOLE_LOWER_SQUAD, Slot.CONSOLE_LOWER_SQUAD),
        unit(Squad.CONSOLE_SNIPER_SQUAD, Slot.CONSOLE_SNIPER_SQUAD),
        unit(Squad.INTERIOR_ANCHOR_SQUAD, Slot.INTERIOR_ANCHOR_SQUAD),
        unit(Squad.INTERIOR_FODDER_SQUAD, Slot.INTERIOR_FODDER_SQUAD),
        unit(Squad.INTERIOR_REINFORCEMENT_MINOTAUR, Slot.INTERIOR_REINFORCEMENT_MINOTAUR),
        unit(Squad.INTERIOR_GOBLIN_SQUAD_1_SQ_VEX_0, Slot.INTERIOR_GOBLIN_SQUAD_1_SQ_VEX_0),
        unit(Squad.INTERIOR_GOBLIN_SQUAD_2_SQ_VEX_0, Slot.INTERIOR_GOBLIN_SQUAD_2_SQ_VEX_0),
        unit(Squad.INTERIOR_GOBLIN_SQUAD_2_SQ_VEX_1, Slot.INTERIOR_GOBLIN_SQUAD_2_SQ_VEX_1),
    },
}

-- The Taken wait at the bunker entrance for the way back out.
local taken_ambush = {
    id = "taken_ambush",
    trigger = Slot.PT_BUNKER_ENTRANCE,
    after = "return",
    objective = Slot.TAKEN_AMBUSH_OBJECTIVE,
    on_start = function(context)
        move(context, {Slot.DOOR_INTERIOR_TO_WARBASE_DEVICE, Slot.DOOR_GARAGE_TO_WARBASE_DEVICE,
            Slot.DOOR_INTERIOR_TO_OASIS_DEVICE}, "open")
    end,
    squads = {
        unit(Squad.DOOR_TAKEN_CENTURION_SQUAD, Slot.DOOR_TAKEN_CENTURION_SQUAD),
        unit(Squad.DOOR_TAKEN_PSION_SQUAD, Slot.DOOR_TAKEN_PSION_SQUAD),
        unit(Squad.BACKDOOR_TAKEN_SQUAD, Slot.BACKDOOR_TAKEN_SQUAD),
        unit(Squad.TAKEN_AMBUSH_WIZARD, Slot.TAKEN_AMBUSH_WIZARD),
        unit(Squad.TAKEN_AMBUSH_HOBGOBLIN, Slot.TAKEN_AMBUSH_HOBGOBLIN),
        unit(Squad.TAKEN_AMBUSH_PSION, Slot.TAKEN_AMBUSH_PSION),
        unit(Squad.TAKEN_AMBUSH_PSION_1, Slot.TAKEN_AMBUSH_PSION_1),
        unit(Squad.TAKEN_AMBUSH_PHALANX, Slot.TAKEN_AMBUSH_PHALANX),
    },
}

local bunker_entry = {
    id = "bunker_entry",
    trigger = Slot.PT_ENTER,
    on_start = function(context)
        move(context, {Slot.OUTER_ELEVATOR_DOOR_DEVICE, Slot.INNER_ELEVATOR_DOOR_DEVICE}, "open")
    end,
    squads = {
        unit(Squad.GOBLIN_SQUAD, Slot.GOBLIN_SQUAD),
        unit(Squad.SECONDARY_GOBLIN_SQUAD, Slot.SECONDARY_GOBLIN_SQUAD),
        unit(Squad.GOBLIN_REINFORCEMENT_SQUAD, Slot.GOBLIN_REINFORCEMENT_SQUAD),
    },
}

local room_1 = {
    id = "room_1",
    trigger = Slot.PT_ROOM_1_80BD2154,
    objective = Slot.ROOM_1_OBJECTIVE,
    on_start = function(context)
        move(context, {Slot.CABAL_DOOR_1_DEVICE_80BD2129, Slot.CABAL_DOOR_ROOM_1_EXIT_DEVICE},
            "open")
    end,
    squads = {
        unit(Squad.ROOM_1_PSION_SQUAD, Slot.ROOM_1_PSION_SQUAD),
        unit(Squad.ROOM_1_PSION_SQUAD_1, Slot.ROOM_1_PSION_SQUAD_1),
        unit(Squad.ROOM_1_GOBLIN_SQUAD, Slot.ROOM_1_GOBLIN_SQUAD),
        unit(Squad.ROOM_1_GOBLIN_SQUAD_1, Slot.ROOM_1_GOBLIN_SQUAD_1),
    },
}

local room_2 = {
    id = "room_2",
    trigger = Slot.PT_ROOM_2_80BD2154,
    objective = Slot.ROOM_2_OBJECTIVE,
    on_start = function(context)
        move(context, {Slot.CABAL_DOOR_2_DEVICE_80BD2129}, "open")
    end,
    squads = {
        unit(Squad.ROOM_2_PHALANX_SQUAD, Slot.ROOM_2_PHALANX_SQUAD),
        unit(Squad.ROOM_2_PSION_SQUAD, Slot.ROOM_2_PSION_SQUAD),
    },
}

local room_3 = {
    id = "room_3",
    trigger = Slot.PT_ROOM_3_ENTER,
    objective = Slot.ROOM_3_OBJECTIVE,
    on_start = function(context)
        move(context, {Slot.CABAL_DOOR_1_DEVICE_80BD2154, Slot.CABAL_DOOR_2_DEVICE_80BD2154},
            "open")
    end,
    squads = {
        unit(Squad.ROOM_3_GOBLIN_SQUAD, Slot.ROOM_3_GOBLIN_SQUAD),
        unit(Squad.ROOM_3_GOBLIN_FINAL_REINFORCEMENT, Slot.ROOM_3_GOBLIN_FINAL_REINFORCEMENT),
        unit(Squad.ROOM_3_PHALANX_SQUAD, Slot.ROOM_3_PHALANX_SQUAD),
        unit(Squad.ROOM_3_CENTURION_SQUAD, Slot.ROOM_3_CENTURION_SQUAD),
    },
}

-- The Taken break into the bunker once the override is on.
local bunker_taken = {
    id = "bunker_taken",
    after = "taken",
    objective = Slot.CLEAR_TAKEN_OBJECTIVE,
    on_start = function(context)
        move(context, {Slot.TAKEN_BARRIER_1_DEVICE_80BD2129, Slot.TAKEN_BARRIER_2_DEVICE_80BD2129,
            Slot.TAKEN_GATE_DEVICE}, "open")
    end,
    squads = {
        unit(Squad.TAKEN_MINOTAUR_1, Slot.TAKEN_MINOTAUR_1),
        unit(Squad.TAKEN_MINOTAUR_2, Slot.TAKEN_MINOTAUR_2),
        unit(Squad.TAKEN_GOBLIN_SQUAD_1, Slot.TAKEN_GOBLIN_SQUAD_1),
        unit(Squad.TAKEN_GOBLIN_SQUAD_2, Slot.TAKEN_GOBLIN_SQUAD_2),
        unit(Squad.TAKEN_GOBLIN_SQUAD_3, Slot.TAKEN_GOBLIN_SQUAD_3),
        unit(Squad.TAKEN_PHALANX_SQUAD_1, Slot.TAKEN_PHALANX_SQUAD_1),
        unit(Squad.TAKEN_PHALANX_SQUAD_2, Slot.TAKEN_PHALANX_SQUAD_2),
    },
}

local bunker_extras = {
    id = "bunker_extras",
    after = "taken",
    squads = {
        unit(Squad.TAKEN_WIZARD_SQUAD, Slot.TAKEN_WIZARD_SQUAD),
        unit(Squad.TAKEN_PSION_SQUAD, Slot.TAKEN_PSION_SQUAD),
        unit(Squad.TAKEN_PHALANX_SQUAD, Slot.TAKEN_PHALANX_SQUAD),
        unit(Squad.HYDRA_SQUAD, Slot.HYDRA_SQUAD),
        unit(Squad.HARPY_SQUAD_1, Slot.HARPY_SQUAD_1),
        unit(Squad.HARPY_SQUAD_2, Slot.HARPY_SQUAD_2),
    },
}

local ammo_room = {
    id = "ammo_room",
    after = "weapon",
    objective = Slot.AMMO_ROOM_OBJECTIVE,
    squads = {
        unit(Squad.AMMO_ROOM_WIZARD_SQUAD, Slot.AMMO_ROOM_WIZARD_SQUAD),
        unit(Squad.AMMO_ROOM_THRALL_SQUAD, Slot.AMMO_ROOM_THRALL_SQUAD),
    },
}

-- Ikora waits in the Vault with the Cabal already there.
local vault = {
    id = "vault",
    trigger = Slot.MIND_B_TRIGGER,
    on_start = function(context)
        move(context, {Slot.DOOR_COMMAND_LEFT_DEVICE, Slot.DOOR_COMMAND_RIGHT_DEVICE,
            Slot.WADI_DOOR_A_DEVICE, Slot.WADI_DOOR_B_DEVICE}, "open")
    end,
    squads = {
        unit(Squad.IKORA, Slot.IKORA),
        unit(Squad.FRONT_SQUAD, Slot.FRONT_SQUAD),
        unit(Squad.BACK_SQUAD, Slot.BACK_SQUAD),
        unit(Squad.FRONT_SNIPER_SQUAD, Slot.FRONT_SNIPER_SQUAD),
        unit(Squad.SNIPER_SQUAD, Slot.SNIPER_SQUAD),
        unit(Squad.ANCHOR_SQUAD, Slot.ANCHOR_SQUAD),
    },
}

local cores = {
    id = "cores",
    after = "defend",
    objective = Slot.MISSION_HEIST_MIND_B_CORE_OBJECTIVE,
    squads = {
        unit(Squad.CORE_A_ANCHOR_SQUAD, Slot.CORE_A_ANCHOR_SQUAD),
        unit(Squad.CORE_A_ANCHOR_SQUAD_2, Slot.CORE_A_ANCHOR_SQUAD_2),
        unit(Squad.CORE_A_ANCHOR_SQUAD_3, Slot.CORE_A_ANCHOR_SQUAD_3),
        unit(Squad.CORE_A_SNIPER_SQUAD, Slot.CORE_A_SNIPER_SQUAD),
        unit(Squad.CORE_A_SNIPER_SQUAD_2, Slot.CORE_A_SNIPER_SQUAD_2),
        unit(Squad.CORE_A_SNIPER_SQUAD_3, Slot.CORE_A_SNIPER_SQUAD_3),
        unit(Squad.CORE_A_ADDS_SQUAD01, Slot.CORE_A_ADDS_SQUAD01),
        unit(Squad.CORE_A_ADDS_SQUAD01_2, Slot.CORE_A_ADDS_SQUAD01_2),
        unit(Squad.CORE_A_ADDS_SQUAD01_3, Slot.CORE_A_ADDS_SQUAD01_3),
        unit(Squad.CORE_A_ADDS_SQUAD02, Slot.CORE_A_ADDS_SQUAD02),
        unit(Squad.CORE_A_ADDS_SQUAD02_2, Slot.CORE_A_ADDS_SQUAD02_2),
        unit(Squad.CORE_A_ADDS_SQUAD02_3, Slot.CORE_A_ADDS_SQUAD02_3),
        unit(Squad.CORE_A_PRESSURE_SQUAD01, Slot.CORE_A_PRESSURE_SQUAD01),
        unit(Squad.CORE_A_PRESSURE_SQUAD02, Slot.CORE_A_PRESSURE_SQUAD02),
        unit(Squad.CORE_A_PRESSURE_SQUAD03, Slot.CORE_A_PRESSURE_SQUAD03),
        unit(Squad.CORE_B_ANCHOR_SQUAD, Slot.CORE_B_ANCHOR_SQUAD),
        unit(Squad.CORE_B_ANCHOR_SQUAD_2, Slot.CORE_B_ANCHOR_SQUAD_2),
        unit(Squad.CORE_B_ANCHOR_SQUAD_3, Slot.CORE_B_ANCHOR_SQUAD_3),
        unit(Squad.CORE_B_SNIPER_SQUAD, Slot.CORE_B_SNIPER_SQUAD),
        unit(Squad.CORE_B_SNIPER_SQUAD_2, Slot.CORE_B_SNIPER_SQUAD_2),
        unit(Squad.CORE_B_SNIPER_SQUAD_3, Slot.CORE_B_SNIPER_SQUAD_3),
        unit(Squad.CORE_B_ADDS_SQUAD01, Slot.CORE_B_ADDS_SQUAD01),
        unit(Squad.CORE_B_ADDS_SQUAD01_2, Slot.CORE_B_ADDS_SQUAD01_2),
        unit(Squad.CORE_B_ADDS_SQUAD01_3, Slot.CORE_B_ADDS_SQUAD01_3),
        unit(Squad.CORE_B_ADDS_SQUAD02, Slot.CORE_B_ADDS_SQUAD02),
        unit(Squad.CORE_B_ADDS_SQUAD02_2, Slot.CORE_B_ADDS_SQUAD02_2),
        unit(Squad.CORE_B_ADDS_SQUAD02_3, Slot.CORE_B_ADDS_SQUAD02_3),
        unit(Squad.CORE_B_PRESSURE_SQUAD01, Slot.CORE_B_PRESSURE_SQUAD01),
        unit(Squad.CORE_B_PRESSURE_SQUAD02, Slot.CORE_B_PRESSURE_SQUAD02),
        unit(Squad.CORE_B_PRESSURE_SQUAD03, Slot.CORE_B_PRESSURE_SQUAD03),
    },
}

local boss = {
    id = "boss",
    trigger = Slot.PT_BOSS_80BD2048,
    after = "defend",
    objective = Slot.MISSION_HEIST_MIND_B_BOSS_OBJECTIVE,
    squads = {
        unit(Squad.BOSS_SQUAD, Slot.BOSS_SQUAD),
        unit(Squad.BOSS_ADDS_RIGHT_SQUAD, Slot.BOSS_ADDS_RIGHT_SQUAD),
        unit(Squad.BOSS_ADDS_RIGHT_SQUAD_1, Slot.BOSS_ADDS_RIGHT_SQUAD_1),
        unit(Squad.BOSS_SNIPER_SQUAD_1, Slot.BOSS_SNIPER_SQUAD_1),
        unit(Squad.BOSS_SNIPER_SQUAD_2, Slot.BOSS_SNIPER_SQUAD_2),
        unit(Squad.BOSS_PHALANX_SQUAD_1, Slot.BOSS_PHALANX_SQUAD_1),
        unit(Squad.BOSS_PHALANX_SQUAD_2, Slot.BOSS_PHALANX_SQUAD_2),
        unit(Squad.BOSS_CENTURION_SQUAD_1, Slot.BOSS_CENTURION_SQUAD_1),
        unit(Squad.BOSS_CENTURION_SQUAD_2, Slot.BOSS_CENTURION_SQUAD_2),
    },
}

local travel = Directive.LOCATE_THE_WARMIND_VAULT
local search = Directive.ENTER_THE_WARMIND_VAULT
local back = Directive.ENTER_THE_WARMIND_VAULT_F7BF5C44
local mainframe = Directive.USE_THE_WARMIND_NETWORK_TO_SCAN_THE_ALMIGHTY_B7C2DF05

return campaign.new{
    key = "heist",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80BD26B5,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80BD26B5,
    legs = {
        {id = "oasis", state = mission.states.STATE_80BD2094_0011_0000_80B57C39, arm = {
            Slot.PT_MISSION_DLG_80BD2084,
        }},
        {id = "shield", state = mission.states.STATE_80BD2094_0014_0000_80B57C3C, arm = {
            Slot.GOTO_SHIELD_FROM_OASIS_TRIGGER, Slot.FRONTDOOR_SPAWN_TRIGGER,
            Slot.BACKDOOR_SPAWN_TRIGGER, Slot.PT_BUNKER_ENTRANCE, Slot.PM_DRILL_HOLE,
            Slot.PT_MISSION_DLG_1_80BD21FB,
            Slot.PT_MISSION_DLG_2,
        }},
        {id = "bunker", state = mission.states.STATE_80BD2094_0000_0000_80BD201F, arm = {
            Slot.PT_ENTER, Slot.PT_ROOM_1_80BD2154, Slot.PT_ROOM_2_80BD2154, Slot.PT_ROOM_3_ENTER,
            Slot.PT_GOTO_VOLUME_80B5764F, Slot.PT_GOTO_VOLUME_80B5765A,
            Slot.PT_GOTO_VOLUME_80B5766B, Slot.PT_EXIT_DIALOG,
            Slot.PT_TV_DEFEAT_TAKEN,
        }},
        {id = "mind_b", state = mission.states.STATE_80BD2094_0010_0000_80B57C37, arm = {
            Slot.GOTO_MIND_B_TRIGGER, Slot.MIND_B_TRIGGER, Slot.PT_BOSS_80BD2048,
        }},
    },
    steps = {
        {id = "oasis", directive = travel, navpoint = Slot.GOTO_SHIELD_NAV_POINT_80BD2084,
            ends = {region = "shield"}},
        {id = "drill_site", directive = travel, navpoint = Slot.GOTO_SHIELD_NAV_POINT_80BD2212,
            ends = {trigger = Slot.GOTO_SHIELD_FROM_OASIS_TRIGGER}},
        {id = "clear", directive = travel, navpoint = Slot.NP_CLEAR_VEX,
            ends = {clear = "road"}},
        -- The drill console does not answer the Ghost.
        {id = "activate", directive = Directive.ENTER_THE_WARMIND_VAULT_4964F0B5,
            navpoint = Slot.SLOT_0006_80BD21FB,
            ends = {ghost_link = Slot.DRILL_CONSOLE_GHOST_LINK}},
        {id = "terminal", directive = Directive.ENTER_THE_WARMIND_VAULT_6A28A754,
            navpoint = Slot.NP_SIGNAL_SEARCH_SHIELD_80BD21DC,
            ends = {trigger = Slot.PT_BUNKER_ENTRANCE}},
        {id = "bunker", directive = search, navpoint = Slot.NP_SIGNAL_SEARCH_SHIELD_80B5764F,
            ends = {trigger = Slot.PT_GOTO_VOLUME_80B5764F}},
        {id = "console", directive = search, navpoint = Slot.NP_SIGNAL_GOTO_CONSOLE,
            ends = {trigger = Slot.PT_GOTO_VOLUME_80B5765A}},
        {id = "override", directive = Directive.ENTER_THE_WARMIND_VAULT_E47D0A7A,
            navpoint = Slot.NP_SIGNAL_GATHER_DATA,
            on_start = function(context)
                move(context, {Slot.OVERRIDE_CONSOLE_DEVICE}, "power_on")
            end,
            ends = {interact = Slot.OVERRIDE_INTERACTABLE}},
        -- Asher: "You have somehow failed to foul things up."
        {id = "taken", directive = back, navpoint = Slot.NP_SIGNAL_DEFEAT_TAKEN,
            lines = {line(cue.CUE_8)},
            ends = {clear = "bunker_taken"}},
        {id = "weapon", directive = back, navpoint = Slot.NP_SIGNAL_TAKE_WEAPON,
            on_start = function(context)
                move(context, {Slot.AMMO_ROOM_DOOR_DEVICE, Slot.AMMO_ROOM_OUTER_DOOR_DEVICE},
                    "open")
            end,
            ends = {trigger = Slot.PT_GOTO_VOLUME_80B5766B}},
        -- "So, uh... Are we going to see Rasputin?"
        {id = "escape", directive = back, navpoint = Slot.AP_ESCAPE_DUN,
            lines = {line(cue.CUE_9, Slot.SLOT_0009_80B5763D)},
            ends = {trigger = Slot.PT_EXIT_DIALOG}},
        -- "Whoa. The drill's on." "Lift it up, before it collapses the Warmind Vault!"
        {id = "return", directive = back, navpoint = Slot.RAISE_DRILL_NAV_POINT,
            lines = {line(cue.CUE_11, Slot.TV_MISSION_DLG_2)},
            on_start = function(context)
                move(context, {Slot.DRILL_DEVICE, Slot.EXTERIOR_OVERRIDE_DEVICE,
                    Slot.INTERIOR_OVERRIDE_DEVICE}, "power_on")
            end,
            ends = {interact = Slot.DRILL_INTERACT_OBJECT}},
        -- "Ha, finally! Let's find that Warmind." "Asher, Ikora, we're on our way into the Vault."
        {id = "vault", directive = mainframe, navpoint = Slot.GOTO_MIND_B_NAV_POINT_80BD21F0,
            lines = {line(cue.CUE_12), line(cue.CUE_13, Slot.TV_MISSION_DLG_1_80BD21F0),
                line(cue.CUE_14)},
            ends = {trigger = Slot.PM_DRILL_HOLE}},
        {id = "mind_b", directive = mainframe, navpoint = Slot.GOTO_MIND_B_NAV_POINT_80BD205F,
            ends = {trigger = Slot.GOTO_MIND_B_TRIGGER}},
        {id = "warmind", directive = mainframe, navpoint = Slot.WARMIND_NAV_POINT,
            ends = {interact = Slot.WARMIND_INTERACT_OBJECT}},
        -- "Reconnecting to the Warmind Network." "Hang on, we've got Taken."
        {id = "defend", directive = Directive.USE_THE_WARMIND_NETWORK_TO_SCAN_THE_ALMIGHTY,
            navpoint = Slot.GOTO_NAV_POINT_80BD2048,
            lines = {line(cue.CUE_15), line(cue.CUE_16)},
            on_start = function(context)
                move(context, {Slot.WARMIND_DEVICE, Slot.OUTER_CORE_DEVICE, Slot.INNER_CORE_DEVICE,
                    Slot.INNER_CORE_DEVICE_1, Slot.INNER_CORE_DEVICE_2, Slot.INNER_CORE_DEVICE_3,
                    Slot.POWER_CORE_A_DEVICE, Slot.POWER_CORE_B_DEVICE}, "power_on")
            end,
            ends = {clear = {"cores", "boss"}}},
        -- "If Zavala blows up the Almighty, it'll take the sun with it."
        {id = "scan", lines = {line(cue.CUE_17)}},
    },
    encounters = {
        road, drill_site, warbase, taken_ambush, bunker_entry, room_1, room_2, room_3,
        bunker_taken, bunker_extras, ammo_room, vault, cores, boss,
    },
}
