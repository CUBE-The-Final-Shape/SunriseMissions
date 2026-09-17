-- Six. Red War campaign draft; not tested in game.
-- Leg order: lava_flows -> lava_cave -> scorched_plateau -> colony, from the transition spawn
-- sets and the step objects. The player walks back through lava_flows after the Vex gate.
local missions = require("missions")
local mission = require(missions.MISSION_CALCULON)
local campaign = require("lib.campaign")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive = mission.Slot, mission.Squad, mission.Directive
local cue = mission.DialogueCue.M_DIALOG_SENSOR_80B43319

-- The lava cave groups carry no encounter objective.
local stairs = {
    id = "stairs",
    trigger = Slot.STAIR_ENTRY_TRIGGER,
    squads = {
        unit(Squad.BELOW_GOBLIN_SQUAD_0, Slot.BELOW_GOBLIN_SQUAD_0),
        unit(Squad.BELOW_GOBLIN_SQUAD_1, Slot.BELOW_GOBLIN_SQUAD_1),
        unit(Squad.UPPER_HARPY_SQUAD_0, Slot.UPPER_HARPY_SQUAD_0),
        unit(Squad.UPPER_HARPY_SQUAD_1, Slot.UPPER_HARPY_SQUAD_1),
        unit(Squad.UPPER_MINOTAUR_SQUAD_0, Slot.UPPER_MINOTAUR_SQUAD_0),
        unit(Squad.LEDGE_HOBGOBLIN_SQUAD, Slot.LEDGE_HOBGOBLIN_SQUAD),
        unit(Squad.REAR_HOBGOBLIN_SQUAD_0, Slot.REAR_HOBGOBLIN_SQUAD_0),
        unit(Squad.REAR_HOBGOBLIN_SQUAD_1, Slot.REAR_HOBGOBLIN_SQUAD_1),
        unit(Squad.REAR_GOBLIN_SQUAD_0, Slot.REAR_GOBLIN_SQUAD_0),
        unit(Squad.REAR_GOBLIN_SQUAD_1, Slot.REAR_GOBLIN_SQUAD_1),
        unit(Squad.REAR_GOBLIN_SQUAD_2, Slot.REAR_GOBLIN_SQUAD_2),
    },
}

local cavern = {
    id = "cavern",
    trigger = Slot.CAVERN_ENTRY_TRIGGER,
    squads = {
        unit(Squad.LANDING_GOBLIN_SQUADS_0, Slot.LANDING_GOBLIN_SQUADS_0),
        unit(Squad.LANDING_GOBLIN_SQUADS_1, Slot.LANDING_GOBLIN_SQUADS_1),
        unit(Squad.LANDING_GOBLIN_SQUADS_2, Slot.LANDING_GOBLIN_SQUADS_2),
        unit(Squad.LANDING_GOBLIN_SQUADS_3, Slot.LANDING_GOBLIN_SQUADS_3),
        unit(Squad.CENTER_HYDRA_SQUAD, Slot.CENTER_HYDRA_SQUAD),
        unit(Squad.STEPPE_HARPY_SQUAD_0, Slot.STEPPE_HARPY_SQUAD_0),
        unit(Squad.STEPPE_HARPY_SQUAD_1, Slot.STEPPE_HARPY_SQUAD_1),
        unit(Squad.STEPPE_HARPY_SQUAD_2, Slot.STEPPE_HARPY_SQUAD_2),
        unit(Squad.STEPPE_MINOTAUR_SQUAD_0, Slot.STEPPE_MINOTAUR_SQUAD_0),
        unit(Squad.STEPPE_MINOTAUR_SQUAD_1, Slot.STEPPE_MINOTAUR_SQUAD_1),
        unit(Squad.BALCONY_HOBGOBLIN_SQUAD, Slot.BALCONY_HOBGOBLIN_SQUAD),
        unit(Squad.BEHIND_GOBLIN_SQUAD_0, Slot.BEHIND_GOBLIN_SQUAD_0),
        unit(Squad.BEHIND_GOBLIN_SQUAD_1, Slot.BEHIND_GOBLIN_SQUAD_1),
        unit(Squad.BEHIND_GOBLIN_SQUAD_2, Slot.BEHIND_GOBLIN_SQUAD_2),
    },
}

-- The reveal prefabs drop their Vex out of the cloud effects around the cavern.
local reveals = {
    id = "reveals",
    trigger = Slot.CAVERN_MID_TRIGGER,
    squads = {
        unit(Squad.FANATIC_LEFT_REVEAL_PREFAB_SQ_VEX_0, Slot.FANATIC_LEFT_REVEAL_PREFAB_SQ_VEX_0),
        unit(Squad.FANATIC_RIGHT_REVEAL_PREFAB_SQ_VEX_0,
             Slot.FANATIC_RIGHT_REVEAL_PREFAB_SQ_VEX_0),
        unit(Squad.LANDING_GOBLINS_PREFAB_SQ_VEX_0, Slot.LANDING_GOBLINS_PREFAB_SQ_VEX_0),
        unit(Squad.LANDING_GOBLINS_PREFAB_1_SQ_VEX_0, Slot.LANDING_GOBLINS_PREFAB_1_SQ_VEX_0),
        unit(Squad.LANDING_GOBLINS_PREFAB_2_SQ_VEX_0, Slot.LANDING_GOBLINS_PREFAB_2_SQ_VEX_0),
        unit(Squad.LANDING_GOBLINS_PREFAB_3_SQ_VEX_0, Slot.LANDING_GOBLINS_PREFAB_3_SQ_VEX_0),
        unit(Squad.LANDING_GOBLINS_PREFAB_4_SQ_VEX_0, Slot.LANDING_GOBLINS_PREFAB_4_SQ_VEX_0),
        unit(Squad.LANDING_GOBLINS_PREFAB_5_SQ_VEX_0, Slot.LANDING_GOBLINS_PREFAB_5_SQ_VEX_0),
        unit(Squad.LANDING_GOBLINS_PREFAB_6_SQ_VEX_0, Slot.LANDING_GOBLINS_PREFAB_6_SQ_VEX_0),
        unit(Squad.STEPPE_MINOTAURS_PREFAB_SQ_VEX_0, Slot.STEPPE_MINOTAURS_PREFAB_SQ_VEX_0),
        unit(Squad.STEPPE_MINOTAURS_PREFAB_1_SQ_VEX_0, Slot.STEPPE_MINOTAURS_PREFAB_1_SQ_VEX_0),
        unit(Squad.STEPPE_MINOTAURS_PREFAB_2_SQ_VEX_0, Slot.STEPPE_MINOTAURS_PREFAB_2_SQ_VEX_0),
        unit(Squad.STEPPE_MINOTAURS_PREFAB_3_SQ_VEX_0, Slot.STEPPE_MINOTAURS_PREFAB_3_SQ_VEX_0),
        unit(Squad.STEPPE_MINOTAURS_PREFAB_4_SQ_VEX_0, Slot.STEPPE_MINOTAURS_PREFAB_4_SQ_VEX_0),
        unit(Squad.STEPPE_MINOTAURS_PREFAB_5_SQ_VEX_0, Slot.STEPPE_MINOTAURS_PREFAB_5_SQ_VEX_0),
        unit(Squad.STEPPE_HARPIES_PREFAB_SQ_VEX_0, Slot.STEPPE_HARPIES_PREFAB_SQ_VEX_0),
        unit(Squad.STEPPE_HARPIES_PREFAB_SQ_VEX_1, Slot.STEPPE_HARPIES_PREFAB_SQ_VEX_1),
        unit(Squad.FLANK_HARPIES_PREFAB_SQ_VEX_0, Slot.FLANK_HARPIES_PREFAB_SQ_VEX_0),
        unit(Squad.FLANK_HARPIES_PREFAB_1_SQ_VEX_0, Slot.FLANK_HARPIES_PREFAB_1_SQ_VEX_0),
        unit(Squad.LEFT_MINOTAUR_PREFAB_SQ_VEX_0, Slot.LEFT_MINOTAUR_PREFAB_SQ_VEX_0),
        unit(Squad.RIGHT_MINOTAUR_PREFAB_SQ_VEX_0, Slot.RIGHT_MINOTAUR_PREFAB_SQ_VEX_0),
    },
}

-- The plateau fight: Fallen and Vex already at war, and the Gate Lord at the barrier.
local plateau_fallen = {
    id = "plateau_fallen",
    trigger = Slot.PT_INTRO_EXPLOSION,
    squads = {
        unit(Squad.SQ_FALLEN_SCORCHED_FRONT_LEFT, Slot.SQ_FALLEN_SCORCHED_FRONT_LEFT),
        unit(Squad.SQ_FALLEN_FRONT_RIGHT, Slot.SQ_FALLEN_FRONT_RIGHT),
        unit(Squad.BOMBER_1, Slot.BOMBER_1),
    },
}

local plateau_tank = {
    id = "plateau_tank",
    trigger = Slot.PT_TANK_KILL,
    squads = {
        unit(Squad.SQ_FALLEN_TANK_FRONT, Slot.SQ_FALLEN_TANK_FRONT),
        unit(Squad.SQ_FALLEN_FODDER_FRONT_FIGHT, Slot.SQ_FALLEN_FODDER_FRONT_FIGHT),
    },
}

local vex_front = {
    id = "vex_front",
    trigger = Slot.PT_DIALOG_GATELORDS,
    objective = Slot.OBJ_VEX_FODDER_FRONT,
    squads = {
        unit(Squad.SQ_VEX_FODDER_FRONT, Slot.SQ_VEX_FODDER_FRONT),
        unit(Squad.SQ_VEX_FODDER_FRONT_FIGHT, Slot.SQ_VEX_FODDER_FRONT_FIGHT),
    },
}

local vex_left = {
    id = "vex_left",
    after = "gate_lord",
    objective = Slot.OBJ_VEX_FODDER_LEFT,
    squads = {unit(Squad.SQ_VEX_FODDER_LEFT, Slot.SQ_VEX_FODDER_LEFT)},
}

local vex_right = {
    id = "vex_right",
    after = "gate_lord",
    objective = Slot.OBJ_VEX_FODDER_RIGHT,
    squads = {
        unit(Squad.SQ_VEX_FODDER_RIGHT, Slot.SQ_VEX_FODDER_RIGHT),
        unit(Squad.SQ_VEX_FODDER_RIGHT_TOP, Slot.SQ_VEX_FODDER_RIGHT_TOP),
    },
}

local cabal_front = {
    id = "cabal_front",
    after = "gate_lord",
    objective = Slot.OBJ_CABAL_FODDER_FRONT,
    squads = {unit(Squad.SQ_CABAL_FODDER_FRONT, Slot.SQ_CABAL_FODDER_FRONT)},
}

local cabal_left = {
    id = "cabal_left",
    after = "gate_lord",
    objective = Slot.OBJ_CABAL_FODDER_LEFT,
    squads = {unit(Squad.SQ_CABAL_FODDER_LEFT, Slot.SQ_CABAL_FODDER_LEFT)},
}

local cabal_mid = {
    id = "cabal_mid",
    after = "gate_lord",
    objective = Slot.OBJ_CABAL_FODDER_MID,
    squads = {unit(Squad.SQ_CABAL_FODDER_MID, Slot.SQ_CABAL_FODDER_MID)},
}

local cabal_right = {
    id = "cabal_right",
    after = "gate_lord",
    objective = Slot.OBJ_CABAL_FODDER_RIGHT,
    squads = {unit(Squad.SQ_CABAL_FODDER_RIGHT, Slot.SQ_CABAL_FODDER_RIGHT)},
}

-- The front boss stands at the barrier; it is taken as Acanthos.
local gate_lord = {
    id = "gate_lord",
    trigger = Slot.PT_DIALOG_BOSS,
    after = "gate_lord",
    objective = Slot.OBJ_VEX_BOSS_FRONT,
    squads = {unit(Squad.SQ_VEX_BOSS_FRONT, Slot.SQ_VEX_BOSS_FRONT)},
}

local boss_left = {
    id = "boss_left",
    after = "gate_lord",
    objective = Slot.OBJ_VEX_BOSS_LEFT,
    squads = {unit(Squad.SQ_VEX_BOSS_LEFT, Slot.SQ_VEX_BOSS_LEFT)},
}

local boss_right = {
    id = "boss_right",
    after = "gate_lord",
    objective = Slot.OBJ_VEX_BOSS_RIGHT,
    squads = {unit(Squad.SQ_VEX_BOSS_RIGHT, Slot.SQ_VEX_BOSS_RIGHT)},
}

-- Cayde waits behind Failsafe's shield in the Exodus Black.
local cayde = {
    id = "cayde",
    after = "platforms",
    squads = {
        unit(Squad.SQ_CAYDE, Slot.SQ_CAYDE),
        unit(Squad.SQ_VENDOR, Slot.SQ_VENDOR),
    },
}

local fodder_start = {
    id = "fodder_start",
    trigger = Slot.PT_BOUNCER_FRONT_LEFT,
    objective = Slot.OBJ_FODDER_START,
    squads = {
        unit(Squad.SQ_FODDER_START_LEFT, Slot.SQ_FODDER_START_LEFT),
        unit(Squad.SQ_FODDER_START_RIGHT, Slot.SQ_FODDER_START_RIGHT),
    },
}

local colony_front = {
    id = "colony_front",
    trigger = Slot.PT_BOUNCER_FRONT_LEFT,
    squads = {
        unit(Squad.SQ_FODDER_INTRO, Slot.SQ_FODDER_INTRO),
        unit(Squad.SQ_FODDER_START_MID, Slot.SQ_FODDER_START_MID),
        unit(Squad.SQ_BOUNCER_FRONT_RIGHT, Slot.SQ_BOUNCER_FRONT_RIGHT),
    },
}

local fodder_mid = {
    id = "fodder_mid",
    trigger = Slot.PT_BOUNCER_FRONT_MID,
    objective = Slot.OBJ_FODDER_MID,
    squads = {
        unit(Squad.SQ_FODDER_MID_FRONT, Slot.SQ_FODDER_MID_FRONT),
        unit(Squad.SQ_FODDER_MID_CENTER, Slot.SQ_FODDER_MID_CENTER),
        unit(Squad.SQ_FODDER_MID_RIGHT, Slot.SQ_FODDER_MID_RIGHT),
        unit(Squad.SQ_FODDER_MID_PREBOSS, Slot.SQ_FODDER_MID_PREBOSS),
    },
}

local colony_mid = {
    id = "colony_mid",
    trigger = Slot.PT_BOUNCER_FRONT_MID,
    squads = {
        unit(Squad.SQ_FODDER_MID_BACK, Slot.SQ_FODDER_MID_BACK),
        unit(Squad.SQ_FODDER_DOOR_1, Slot.SQ_FODDER_DOOR_1),
        unit(Squad.SQ_FODDER_DOOR_2, Slot.SQ_FODDER_DOOR_2),
        unit(Squad.SQ_FODDER_LEFT_PREBOSS, Slot.SQ_FODDER_LEFT_PREBOSS),
        unit(Squad.SQ_FODDER_RIGHT_PREBOSS, Slot.SQ_FODDER_RIGHT_PREBOSS),
    },
}

local fallen_boss = {
    id = "fallen_boss",
    after = "boss",
    objective = Slot.OBJ_FALLEN_BOSS,
    squads = {
        unit(Squad.SQ_FALLEN_BOSS, Slot.SQ_FALLEN_BOSS),
        unit(Squad.SQ_FALLEN_BOSS_1, Slot.SQ_FALLEN_BOSS_1),
    },
}

local sturm = {
    id = "sturm",
    after = "boss",
    objective = Slot.OJ_STURM,
    squads = {unit(Squad.SQ_STURM_ANCHOR, Slot.SQ_STURM_ANCHOR)},
}

local fodder_back = {
    id = "fodder_back",
    after = "boss",
    objective = Slot.OBJ_FODDER_BACK,
    squads = {
        unit(Squad.SQ_FODDER_BACK_TOP_LEFT, Slot.SQ_FODDER_BACK_TOP_LEFT),
        unit(Squad.SQ_FODDER_BACK_TOP_RIGHT, Slot.SQ_FODDER_BACK_TOP_RIGHT),
        unit(Squad.SQ_FODDER_BACK_BOTTOM_LEFT, Slot.SQ_FODDER_BACK_BOTTOM_LEFT),
        unit(Squad.SQ_FODDER_BACK_BOTTOM_RIGHT, Slot.SQ_FODDER_BACK_BOTTOM_RIGHT),
        unit(Squad.SQ_SNIPER_BACK_LEFT, Slot.SQ_SNIPER_BACK_LEFT),
        unit(Squad.SQ_SNIPER_BACK_RIGHT, Slot.SQ_SNIPER_BACK_RIGHT),
    },
}

local last = {
    id = "last",
    after = "remaining",
    squads = {
        unit(Squad.SQ_LAST_FODDER_LEFT, Slot.SQ_LAST_FODDER_LEFT),
        unit(Squad.SQ_LAST_FODDER_RIGHT, Slot.SQ_LAST_FODDER_RIGHT),
    },
}

local rescue = Directive.RESCUE_CAYDE_6_AND_FAILSAFE

return campaign.new{
    key = "calculon",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80B43319,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80B43319,
    legs = {
        {id = "lava_flows", state = mission.states.STATE_80B42BAA_000B_0000_80B4356B, arm = {
            Slot.PT_DIALOG_START, Slot.PT_DIALOG_SCORCHED,
        }},
        {id = "lava_cave", state = mission.states.STATE_80B42BAA_000A_0000_80B4356A, arm = {
            Slot.STAIR_ENTRY_TRIGGER, Slot.PT_DIALOG_ENTER, Slot.CAVERN_ENTRY_TRIGGER,
            Slot.PT_DIALOG_ENTRY,
            Slot.CAVERN_MID_TRIGGER, Slot.PT_DIALOG_CAYDE, Slot.PT_GATEWAY,
        }},
        {id = "scorched_plateau", state = mission.states.STATE_80B42BAA_001E_0000_80B43570, arm = {
            Slot.PT_INTRO_EXPLOSION, Slot.PT_TANK_KILL, Slot.PT_DIALOG_BOSS,
            Slot.PT_DIALOG_HURRY,
            Slot.PT_DIALOG_GATELORDS,
        }},
        {id = "colony", state = mission.states.STATE_80B42BAA_0003_0000_80B42B7A, arm = {
            Slot.PT_BOUNCER_FRONT_LEFT, Slot.PT_BOUNCER_FRONT_MID,
            Slot.PT_KILL_REMAINING,
        }},
    },
    steps = {
        {id = "teleporter", directive = Directive.FREE_CAYDE_6_FROM_THE_VEX_TELEPORTER_LOOP,
            navpoint = Slot.AP_LAVA_CAVE,
            ends = {region = "lava_cave"}},
        {id = "search", directive = Directive.FREE_CAYDE_6_FROM_THE_VEX_TELEPORTER_LOOP_BCB38B27,
            navpoint = Slot.AP_SEARCH_80B437F1,
            ends = {trigger = Slot.STAIR_ENTRY_TRIGGER}},
        {id = "cave", directive = Directive.FREE_CAYDE_6_FROM_THE_VEX_TELEPORTER_LOOP_BCB38B27,
            navpoint = Slot.AP_SEARCH_80B437DD,
            ends = {trigger = Slot.PT_DIALOG_ENTER}},
        {id = "fight", directive = Directive.FREE_CAYDE_6_FROM_THE_VEX_TELEPORTER_LOOP_59A59FAC,
            ends = {trigger = Slot.PT_DIALOG_CAYDE}},
        -- "This is the Vex teleporter?" "The Cayde-6 will want it. You should pick it up!"
        {id = "chest", directive = Directive.FREE_CAYDE_6_FROM_THE_VEX_TELEPORTER_LOOP_A00CB36B,
            navpoint = Slot.AP_CHEST, lines = {line(cue.CUE_11), line(cue.CUE_12)},
            ends = {interact = Slot.ARTIFACT_CHEST_INTERACTABLE_OBJECT}},
        -- Cayde is out. "Please proceed through the nearby Vex gate."
        {id = "gate", directive = Directive.RENDEZVOUS_WITH_CAYDE_6_1B36E8A1,
            navpoint = Slot.AP_GATEWAY,
            lines = {line(cue.CUE_15), line(cue.CUE_16, Slot.SLOT_0008_80B437DD)},
            on_start = function(context)
                move(context, {Slot.D_VEX_BARRIER}, "power_off")
                move(context, {Slot.D_TELEPORTER}, "power_on")
            end,
            ends = {trigger = Slot.PT_GATEWAY}},
        -- Cayde meets Failsafe, then hides in the Exodus Black as the Fallen find him.
        {id = "exodus", directive = Directive.RENDEZVOUS_WITH_CAYDE_6,
            navpoint = Slot.AP_SCORCHED,
            lines = {line(cue.CUE_18), line(cue.CUE_22, Slot.TV_DIALOG_SCORCHED),
                line(cue.CUE_23, Slot.SLOT_0008_80B43809)},
            ends = {region = "scorched_plateau"}},
        -- "That is a really big Vex." "Guys, we're blocked! The big Vex. Smash it."
        {id = "gate_lord", directive = Directive.RENDEZVOUS_WITH_CAYDE_6_A905F815,
            lines = {line(cue.CUE_27), line(cue.CUE_28, Slot.SLOT_0004_80B43953),
                line(cue.CUE_29, Slot.TV_DIALOG_GATELORDS)},
            ends = {clear = "gate_lord"}},
        -- "The Gate Lord's down." Failsafe raises her shield. "You probably wanna hustle."
        {id = "hurry", directive = Directive.RENDEZVOUS_WITH_CAYDE_6_EF306829,
            navpoint = Slot.AP_COLONY,
            lines = {line(cue.CUE_30), line(cue.CUE_31, Slot.TV_DIALOG_HURRY)},
            on_start = function(context) move(context, {Slot.D_VEX_WALL_1}, "open") end,
            ends = {region = "colony"}},
        -- "Intruder alert!" "Ugh. IT'S US!"
        {id = "platforms", directive = Directive.RESCUE_CAYDE_6_AND_FAILSAFE_F73F7996,
            navpoint = Slot.AP_PLATFORMS, lines = {line(cue.CUE_32)},
            ends = {trigger = Slot.PT_BOUNCER_FRONT_MID}},
        {id = "boss", directive = rescue, navpoint = Slot.AP_BOSS,
            ends = {clear = "fallen_boss"}},
        -- "Hey! That Fallen dropped something!"
        {id = "remaining", directive = rescue, navpoint = Slot.AP_KILL_REMAINING,
            lines = {line(cue.CUE_35)},
            ends = {clear = "last"}},
        -- "You have saved us!" "New captain registered." "Let's go find Cayde."
        {id = "find", directive = Directive.RENDEZVOUS_WITH_CAYDE_6_15908838,
            navpoint = Slot.SLOT_0009_80B43572,
            lines = {line(cue.CUE_36), line(cue.CUE_38), line(cue.CUE_39)},
            on_start = function(context) move(context, {Slot.D_ENERGY_BARRIER}, "power_off") end},
    },
    encounters = {
        stairs, cavern, reveals, plateau_fallen, plateau_tank, vex_front, vex_left, vex_right,
        cabal_front, cabal_left, cabal_mid, cabal_right, gate_lord, boss_left, boss_right, cayde,
        fodder_start, colony_front, fodder_mid, colony_mid, fallen_boss, sturm, fodder_back, last,
    },
}
