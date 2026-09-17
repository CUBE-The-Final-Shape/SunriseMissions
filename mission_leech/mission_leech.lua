-- Sacrilege. Red War campaign draft; not tested in game.
-- Leg order: oasis -> wadi -> burrow -> wadi. Steps follow the step objects, their lines and the
-- trigger volume positions. The mine exit sits on its entry and the portal fight is on the way
-- in, so those steps count their volumes only once they start.
local missions = require("missions")
local mission = require(missions.MISSION_LEECH)
local campaign = require("lib.campaign")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive = mission.Slot, mission.Squad, mission.Directive
local cue = mission.DialogueCue.M_DIALOG_SENSOR_80BD28C1

local dropships = {
    id = "dropships",
    trigger = Slot.PT_DROPSHIP_FLYBY_1,
    squads = {
        unit(Squad.DROPSHIP_1, Slot.DROPSHIP_1),
        unit(Squad.DROPSHIP_2, Slot.DROPSHIP_2),
        unit(Squad.DROPSHIP_3, Slot.DROPSHIP_3),
        unit(Squad.DROPSHIP_4, Slot.DROPSHIP_4),
        unit(Squad.DROPSHIP_5, Slot.DROPSHIP_5),
        unit(Squad.DROPSHIP_6, Slot.DROPSHIP_6),
        unit(Squad.DROPSHIP_7, Slot.DROPSHIP_7),
        unit(Squad.DROPSHIP_8, Slot.DROPSHIP_8),
        unit(Squad.DROPSHIP_9, Slot.DROPSHIP_9),
        unit(Squad.DROPSHIP_10, Slot.DROPSHIP_10),
    },
}

-- The geyser between the oasis and the wadi.
local geyser = {
    id = "geyser",
    trigger = Slot.PT_GEYSER,
    on_start = function(context) move(context, {Slot.D_GEYSER}, "power_on") end,
}

-- The Cabal hold the wadi in front of the base. These groups carry no encounter objective.
local cabal = {
    id = "cabal",
    trigger = Slot.PT_DIALOG_WADI_10,
    squads = {
        unit(Squad.SQ_CABAL_START_IDLE_1, Slot.SQ_CABAL_START_IDLE_1),
        unit(Squad.SQ_CABAL_START_IDLE_2, Slot.SQ_CABAL_START_IDLE_2),
        unit(Squad.SQ_CABAL_FRONT_PSION, Slot.SQ_CABAL_FRONT_PSION),
        unit(Squad.SQ_CABAL_FRONT_PHALANX, Slot.SQ_CABAL_FRONT_PHALANX),
        unit(Squad.SQ_CABAL_BACK_PYRO, Slot.SQ_CABAL_BACK_PYRO),
        unit(Squad.SQ_CABAL_BACK_LEGIONARY, Slot.SQ_CABAL_BACK_LEGIONARY),
        unit(Squad.SQ_CABAL_FLEE_1, Slot.SQ_CABAL_FLEE_1),
        unit(Squad.SQ_DROPSHIP, Slot.SQ_DROPSHIP),
        unit(Squad.SQ_DROPSHIP_2, Slot.SQ_DROPSHIP_2),
        unit(Squad.SQ_DROPSHIP_3, Slot.SQ_DROPSHIP_3),
        unit(Squad.SQ_DROPSHIP_4, Slot.SQ_DROPSHIP_4),
    },
}

local patrol = {
    id = "patrol",
    trigger = Slot.PT_DIALOG_WADI_10,
    objective = Slot.PF_SC_PATROL_BOTTOM_OBJ_GENERIC_PATROL,
    squads = {
        unit(Squad.PF_SC_PATROL_BOTTOM_SQ_GENERIC_PATROL,
             Slot.PF_SC_PATROL_BOTTOM_SQ_GENERIC_PATROL),
        unit(Squad.SQ_DOGS_BOTTOM_LEFT, Slot.SQ_DOGS_BOTTOM_LEFT),
    },
}

-- The mine is crossed twice. Its Taken groups wait for the steps that follow the reveal.
local ambush = {
    id = "ambush",
    trigger = Slot.PT_THRALL_TRIGGER,
    after = "drill",
    objective = Slot.OBJ_AMBUSH,
    on_start = function(context) move(context, {Slot.D_TAKEN_GATE_1}, "open") end,
    squads = {
        unit(Squad.SQ_THRALL_AMBUSH, Slot.SQ_THRALL_AMBUSH),
        unit(Squad.SQ_THRALL_AMBUSH_1, Slot.SQ_THRALL_AMBUSH_1),
    },
}

local mine_extras = {
    id = "mine_extras",
    after = "taken",
    squads = {
        unit(Squad.SQ_TAKEN_PSION_1, Slot.SQ_TAKEN_PSION_1),
        unit(Squad.SQ_TAKEN_PSION_2, Slot.SQ_TAKEN_PSION_2),
        unit(Squad.SQ_TAKEN_PSION_3, Slot.SQ_TAKEN_PSION_3),
        unit(Squad.SQ_TAKEN_AREA_1_PSION_2, Slot.SQ_TAKEN_AREA_1_PSION_2),
        unit(Squad.SQ_TAKEN_AREA_1_PHALANX_2, Slot.SQ_TAKEN_AREA_1_PHALANX_2),
        unit(Squad.SQ_TAKEN_AREA_3_PSION_1, Slot.SQ_TAKEN_AREA_3_PSION_1),
        unit(Squad.SQ_TAKEN_AREA_3_PSION_2, Slot.SQ_TAKEN_AREA_3_PSION_2),
        unit(Squad.SQ_TAKEN_AREA_3_HOBGOBLIN_1, Slot.SQ_TAKEN_AREA_3_HOBGOBLIN_1),
        unit(Squad.SQ_TAKEN_AREA_3_HOBGOBLIN_2, Slot.SQ_TAKEN_AREA_3_HOBGOBLIN_2),
        unit(Squad.SQ_TAKEN_AREA_3_PHALANX_1, Slot.SQ_TAKEN_AREA_3_PHALANX_1),
        unit(Squad.SQ_TAKEN_AREA_3_PHALANX_2, Slot.SQ_TAKEN_AREA_3_PHALANX_2),
        unit(Squad.SQ_TAKEN_AREA_4_PSION_1, Slot.SQ_TAKEN_AREA_4_PSION_1),
        unit(Squad.SQ_TAKEN_AREA_4_PSION_2, Slot.SQ_TAKEN_AREA_4_PSION_2),
    },
}

local area_1 = {
    id = "area_1",
    trigger = Slot.PT_ESCAPE_AREA_1_START,
    after = "search_1",
    objective = Slot.OBJ_AREA_1,
    on_start = function(context)
        move(context, {Slot.D_TAKEN_GATE_1A, Slot.D_TAKEN_GATE_1B}, "open")
    end,
    squads = {
        unit(Squad.SQ_TAKEN_AREA_1_PSION_1, Slot.SQ_TAKEN_AREA_1_PSION_1),
        unit(Squad.SQ_TAKEN_AREA_1_THRALL, Slot.SQ_TAKEN_AREA_1_THRALL),
        unit(Squad.SQ_TAKEN_AREA_1_CENTURION, Slot.SQ_TAKEN_AREA_1_CENTURION),
        unit(Squad.SQ_TAKEN_AREA_1_PHALANX_1, Slot.SQ_TAKEN_AREA_1_PHALANX_1),
    },
}

local area_2 = {
    id = "area_2",
    trigger = Slot.PT_ESCAPE_AREA_2_START,
    after = "search_1",
    objective = Slot.OBJ_AREA_2,
    squads = {
        unit(Squad.SQ_TAKEN_AREA_2_PHALANX, Slot.SQ_TAKEN_AREA_2_PHALANX),
        unit(Squad.SQ_TAKEN_AREA_2_THRALL, Slot.SQ_TAKEN_AREA_2_THRALL),
    },
}

local area_3 = {
    id = "area_3",
    trigger = Slot.PT_ENTER_AREA_3,
    after = "search_1",
    objective = Slot.OBJ_AREA_3,
    squads = {
        unit(Squad.SQ_TAKEN_AREA_3_CENTURION, Slot.SQ_TAKEN_AREA_3_CENTURION),
        unit(Squad.SQ_TAKEN_AREA_3_PHALANX_3, Slot.SQ_TAKEN_AREA_3_PHALANX_3),
    },
}

local area_4 = {
    id = "area_4",
    trigger = Slot.PT_ENTER_AREA_5,
    after = "search_3",
    objective = Slot.OBJ_AREA_4,
    on_start = function(context)
        move(context, {Slot.D_TAKEN_GATE_4A, Slot.D_TAKEN_GATE_4B, Slot.D_TAKEN_GATE_4C}, "open")
    end,
    squads = {
        unit(Squad.SQ_TAKEN_AREA_4_THRALL, Slot.SQ_TAKEN_AREA_4_THRALL),
        unit(Squad.SQ_TAKEN_AREA_4_WIZARD, Slot.SQ_TAKEN_AREA_4_WIZARD),
        unit(Squad.SQ_TAKEN_AREA_4_HOBGOBLIN, Slot.SQ_TAKEN_AREA_4_HOBGOBLIN),
        unit(Squad.SQ_WIZARD_THRALL_AREA_4, Slot.SQ_WIZARD_THRALL_AREA_4),
    },
}

local escape = {
    id = "escape",
    after = "out",
    objective = Slot.OBJ_ESCAPE,
    squads = {
        unit(Squad.SQ_ESCAPE_VEX_HOBGOBLIN, Slot.SQ_ESCAPE_VEX_HOBGOBLIN),
        unit(Squad.SQ_ESCAPE_VEX_GOBLIN, Slot.SQ_ESCAPE_VEX_GOBLIN),
        unit(Squad.SQ_ESCAPE_TAKEN_PSION_1, Slot.SQ_ESCAPE_TAKEN_PSION_1),
        unit(Squad.SQ_ESCAPE_TAKEN_PSION_2, Slot.SQ_ESCAPE_TAKEN_PSION_2),
    },
}

local polyps = {
    id = "polyps",
    trigger = Slot.PT_BLIGHT_SLOW,
    after = "portal",
    objective = Slot.OBJ_POLYP,
    squads = {
        unit(Squad.SQ_POLYP_TAKEN_THRALL, Slot.SQ_POLYP_TAKEN_THRALL),
        unit(Squad.SQ_POLYP_TAKEN_THRALL_FAR, Slot.SQ_POLYP_TAKEN_THRALL_FAR),
        unit(Squad.SQ_POLYP_TAKEN_THRALL_WEST, Slot.SQ_POLYP_TAKEN_THRALL_WEST),
    },
}

-- The Wizards at the three portal points carry no encounter objective.
local portal_wizards = {
    id = "portal_wizards",
    after = "portal",
    squads = {
        unit(Squad.SQ_EAST_TAKEN_WIZARD_A, Slot.SQ_EAST_TAKEN_WIZARD_A),
        unit(Squad.SQ_EAST_TAKEN_WIZARD_2, Slot.SQ_EAST_TAKEN_WIZARD_2),
        unit(Squad.SQ_EAST_TAKEN_PSION_1, Slot.SQ_EAST_TAKEN_PSION_1),
        unit(Squad.SQ_EAST_TAKEN_PSION_2, Slot.SQ_EAST_TAKEN_PSION_2),
        unit(Squad.SQ_EAST_TAKEN_GOBLIN_1, Slot.SQ_EAST_TAKEN_GOBLIN_1),
        unit(Squad.SQ_EAST_TAKEN_GOBLIN_2, Slot.SQ_EAST_TAKEN_GOBLIN_2),
        unit(Squad.SQ_EAST_TAKEN_PHALANX_1, Slot.SQ_EAST_TAKEN_PHALANX_1),
        unit(Squad.SQ_EAST_TAKEN_PHALANX_2, Slot.SQ_EAST_TAKEN_PHALANX_2),
        unit(Squad.SQ_EAST_TAKEN_HOBGOBLIN_1, Slot.SQ_EAST_TAKEN_HOBGOBLIN_1),
        unit(Squad.SQ_EAST_TAKEN_HOBGOBLIN_2, Slot.SQ_EAST_TAKEN_HOBGOBLIN_2),
        unit(Squad.SQ_FAR_TAKEN_WIZARD, Slot.SQ_FAR_TAKEN_WIZARD),
        unit(Squad.SQ_FAR_TAKEN_HOBGOBLIN_1, Slot.SQ_FAR_TAKEN_HOBGOBLIN_1),
        unit(Squad.SQ_FAR_TAKEN_HOBGOBLIN_2, Slot.SQ_FAR_TAKEN_HOBGOBLIN_2),
        unit(Squad.SQ_FAR_TAKEN_GOBLIN_1, Slot.SQ_FAR_TAKEN_GOBLIN_1),
        unit(Squad.SQ_FAR_TAKEN_GOBLIN_2, Slot.SQ_FAR_TAKEN_GOBLIN_2),
        unit(Squad.SQ_FAR_TAKEN_PSION_1, Slot.SQ_FAR_TAKEN_PSION_1),
        unit(Squad.SQ_FAR_TAKEN_PSION_2, Slot.SQ_FAR_TAKEN_PSION_2),
        unit(Squad.SQ_WEST_TAKEN_WIZARD_1, Slot.SQ_WEST_TAKEN_WIZARD_1),
        unit(Squad.SQ_WEST_TAKEN_WIZARD_2, Slot.SQ_WEST_TAKEN_WIZARD_2),
        unit(Squad.SQ_WEST_TAKEN_PSION_1, Slot.SQ_WEST_TAKEN_PSION_1),
        unit(Squad.SQ_WEST_TAKEN_PSION_2, Slot.SQ_WEST_TAKEN_PSION_2),
        unit(Squad.SQ_WEST_TAKEN_GOBLIN_1, Slot.SQ_WEST_TAKEN_GOBLIN_1),
        unit(Squad.SQ_WEST_TAKEN_GOBLIN_2, Slot.SQ_WEST_TAKEN_GOBLIN_2),
        unit(Squad.SQ_WEST_TAKEN_PHALANX_1, Slot.SQ_WEST_TAKEN_PHALANX_1),
        unit(Squad.SQ_WEST_TAKEN_PHALANX_2, Slot.SQ_WEST_TAKEN_PHALANX_2),
        unit(Squad.SQ_WEST_TAKEN_HOBGOBLIN_1, Slot.SQ_WEST_TAKEN_HOBGOBLIN_1),
        unit(Squad.SQ_WEST_TAKEN_HOBGOBLIN_2, Slot.SQ_WEST_TAKEN_HOBGOBLIN_2),
    },
}

local irausk = {
    id = "irausk",
    after = "boss",
    objective = Slot.OBJ_BOSS_80BD29CB,
    squads = {
        unit(Squad.SQ_BOSS_TAKEN_ULTRA, Slot.SQ_BOSS_TAKEN_ULTRA),
        unit(Squad.SQ_BOSS_TAKEN_INTRO_1, Slot.SQ_BOSS_TAKEN_INTRO_1),
        unit(Squad.SQ_BOSS_TAKEN_INTRO_2, Slot.SQ_BOSS_TAKEN_INTRO_2),
        unit(Squad.SQ_BOSS_TAKEN_THRALL_1, Slot.SQ_BOSS_TAKEN_THRALL_1),
        unit(Squad.SQ_BOSS_TAKEN_THRALL_2, Slot.SQ_BOSS_TAKEN_THRALL_2),
        unit(Squad.SQ_BOSS_TAKEN_GOBLIN_3, Slot.SQ_BOSS_TAKEN_GOBLIN_3),
        unit(Squad.SQ_BOSS_TAKEN_GOBLIN_4, Slot.SQ_BOSS_TAKEN_GOBLIN_4),
        unit(Squad.SQ_BOSS_TAKEN_PHALANX_1, Slot.SQ_BOSS_TAKEN_PHALANX_1),
        unit(Squad.SQ_BOSS_TAKEN_PHALANX_2, Slot.SQ_BOSS_TAKEN_PHALANX_2),
        unit(Squad.SQ_BOSS_TAKEN_PHALANX_3, Slot.SQ_BOSS_TAKEN_PHALANX_3),
        unit(Squad.SQ_BOSS_TAKEN_PHALANX_4, Slot.SQ_BOSS_TAKEN_PHALANX_4),
        unit(Squad.SQ_BOSS_TAKEN_PHALANX_UPPER, Slot.SQ_BOSS_TAKEN_PHALANX_UPPER),
    },
}

local find_base = Directive.DETERMINE_WHAT_THE_RED_LEGION_IS_DOING_ON_IO
local into_base = Directive.DETERMINE_WHAT_THE_RED_LEGION_IS_DOING_ON_IO_D8BC4D22
local explore = Directive.DETERMINE_WHAT_THE_RED_LEGION_IS_DOING_ON_IO_4CD680FD
local repel = Directive.DEFEND_YOURSELF_AGAINST_THE_TAKEN

return campaign.new{
    key = "leech",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80BD28C1,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80BD28C1,
    legs = {
        {id = "oasis", state = mission.states.STATE_80BD275F_0011_0000_80C36F90, arm = {
            Slot.MEET_IKORA_TRIGGER, Slot.PT_DROPSHIP_FLYBY_1, Slot.PT_GEYSER,
            Slot.PT_GOTO_WADI_PHASE,
        }},
        {id = "wadi", state = mission.states.STATE_80BD275F_0015_0000_80C36F96, arm = {
            Slot.PT_DIALOG_WADI_10, Slot.PT_MINE_NAVPOINT, Slot.GOTO_MINE_TRIGGER,
            Slot.PT_BLIGHT_SLOW, Slot.DESTROY_WIZARDS_PLAYER_TRIGGER,
            Slot.PT_MISSION_DLG_1_80BD291E,
            Slot.DESTROY_BOSS_PLAYER_TRIGGER,
        }},
        {id = "burrow", state = mission.states.STATE_80BD275F_0001_0000_80BD2746, arm = {
            Slot.PT_CABAL_FLEE_80BD248C, Slot.PT_TAKEN_REVEAL, Slot.PT_THRALL_TRIGGER,
            Slot.SEARCH_MINE_PLAYER_TRIGGER_1, Slot.SEARCH_MINE_PLAYER_TRIGGER_2,
            Slot.SEARCH_MINE_PLAYER_TRIGGER_3, Slot.PT_ESCAPE_AREA_1_START,
            Slot.PT_ESCAPE_AREA_2_START, Slot.PT_ENTER_AREA_3, Slot.PT_ENTER_AREA_5,
            Slot.ESCAPE_MINE_PLAYER_TRIGGER,
        }},
    },
    steps = {
        -- The first goal in the Ikora step object has no SDK directive, so the base goal stands in.
        {id = "ikora", directive = find_base, navpoint = Slot.MEET_IKORA_NAV_POINT,
            ends = {trigger = Slot.MEET_IKORA_TRIGGER}},
        {id = "oasis", directive = find_base, navpoint = Slot.NP_WADI,
            ends = {trigger = Slot.PT_GOTO_WADI_PHASE}},
        {id = "wadi", directive = find_base, navpoint = Slot.GOTO_WADI_NAV_POINT,
            ends = {trigger = Slot.PT_DIALOG_WADI_10}},
        {id = "base", directive = into_base, navpoint = Slot.SLOT_000A_80BD293C,
            ends = {trigger = Slot.PT_MINE_NAVPOINT}},
        {id = "gate", directive = into_base, navpoint = Slot.GOTO_MINE_NAV_POINT,
            ends = {trigger = Slot.GOTO_MINE_TRIGGER}},
        {id = "explore", directive = explore, navpoint = Slot.ENTER_MINE_NAV_POINT_80BD2493,
            ends = {region = "burrow"}},
        {id = "enter", directive = explore, navpoint = Slot.ENTER_MINE_NAV_POINT_80BD248C,
            ends = {trigger = Slot.PT_CABAL_FLEE_80BD248C}},
        {id = "drill", directive = explore, navpoint = Slot.SLOT_000E_80BD248C,
            ends = {trigger = Slot.PT_TAKEN_REVEAL}},
        -- "Why are the Taken here? They have no leader; Oryx is dead."
        {id = "taken", directive = Directive.DEFEND_YOURSELF_AGAINST_THE_TAKEN_C1108DA8,
            navpoint = Slot.AP_DEFEAT_TAKEN, lines = {line(cue.CUE_9)},
            ends = {clear = "ambush"}},
        {id = "search_1", directive = repel, navpoint = Slot.SLOT_0015_80BD248C,
            revisit = true, ends = {trigger = Slot.SEARCH_MINE_PLAYER_TRIGGER_1}},
        {id = "search_2", directive = repel, navpoint = Slot.SLOT_0016_80BD248C,
            revisit = true, ends = {trigger = Slot.SEARCH_MINE_PLAYER_TRIGGER_2}},
        {id = "search_3", directive = repel, navpoint = Slot.SLOT_0017_80BD248C,
            revisit = true, ends = {trigger = Slot.SEARCH_MINE_PLAYER_TRIGGER_3}},
        -- "Ghaul must be mining the Traveler's remnant energy." "Meet me outside."
        {id = "wizard", directive = Directive.DEFEND_YOURSELF_AGAINST_THE_TAKEN_B0794A52,
            navpoint = Slot.WIZARD_NAV_POINT, lines = {line(cue.CUE_10)},
            ends = {clear = "area_4"}},
        -- Asher: "All channels! This is a skyshock alert!"
        {id = "escape", directive = Directive.REJOIN_IKORA, navpoint = Slot.SLOT_000C_80BD2469,
            lines = {line(cue.CUE_11, Slot.TV_MISSION_DLG_3)},
            revisit = true, ends = {trigger = Slot.ESCAPE_MINE_PLAYER_TRIGGER}},
        {id = "out", directive = Directive.REJOIN_IKORA, navpoint = Slot.EXIT_MINE_NAV_POINT,
            revisit = true, ends = {trigger = Slot.DESTROY_WIZARDS_PLAYER_TRIGGER}},
        -- "Looks like the Taken are conjuring some kind of portal."
        {id = "portal", directive = Directive.RESPOND_TO_ASHER_S_DISTRESS_CRY,
            navpoint = Slot.SLOT_0009_80BD291E, lines = {line(cue.CUE_13)},
            revisit = true, ends = {trigger = Slot.PT_MISSION_DLG_1_80BD291E}},
        {id = "wizards", directive = Directive.SEAL_THE_TAKEN_PORTAL,
            navpoint = Slot.WIZARD_EAST_NAV_POINT,
            ends = {clear = "portal_wizards"}},
        -- "Looks like we closed the portal." "We definitely didn't close it."
        {id = "boss", directive = Directive.SEAL_THE_TAKEN_PORTAL,
            navpoint = Slot.DESTROY_BOSS_NAV_POINT,
            lines = {line(cue.CUE_14), line(cue.CUE_15)},
            ends = {clear = "irausk"}},
        -- "Portal's closed. We're clear."
        {id = "closed", lines = {line(cue.CUE_16)}},
    },
    encounters = {
        dropships, geyser, cabal, patrol, ambush, mine_extras, area_1, area_2, area_3, area_4,
        escape, polyps, portal_wizards, irausk,
    },
}
