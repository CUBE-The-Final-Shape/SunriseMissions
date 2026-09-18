-- New Light. Ported from the Dawn fork's native mission definition; not tested in game.
-- Four legs: the exterior wall (24), the Breach (0), the Divide (8) and Dock 13 (16).
-- Dawn keeps only two client hooks here and neither is gameplay, so the whole flow is server
-- behaviour. Not ported: the Ghost's type-42 performance at the lights, the Skiff flight, the
-- three bookend movies and the Tower handoff. Each is its own native piece, not a mission step.
local missions = require("missions")
local mission = require(missions.MISSION_LAUNCHPAD)
local campaign = require("lib.campaign")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive = mission.Slot, mission.Squad, mission.Directive
local cue = mission.DialogueCue.M_DIALOG_SENSOR_8153C294

-- The Fallen on the wall above the Breach entrance.
local nests = {
    id = "nests",
    trigger = Slot.PT_FALLEN_ABOVE,
    objective = Slot.OBJ_BREACH_FALLEN01,
    squads = {
        unit(Squad.SQ_FALLEN_NEST1, Slot.SQ_FALLEN_NEST1),
        unit(Squad.SQ_FALLEN_NEST2, Slot.SQ_FALLEN_NEST2),
    },
}

-- The first Vandal, then the room behind it.
local first_vandal = {
    id = "first_vandal",
    after = "breach",
    objective = Slot.OBJ_BREACH_FALLEN01,
    squads = {
        unit(Squad.SQ_FALLEN_FIRST_VANDAL, Slot.SQ_FALLEN_FIRST_VANDAL),
    },
}

local first_fight = {
    id = "first_fight",
    trigger = Slot.PT_DIAG_CORNER,
    after = "breach",
    objective = Slot.OBJ_BREACH_FALLEN01,
    squads = {
        unit(Squad.SQ_FALLEN_BOUNCEDOWN_C, Slot.SQ_FALLEN_BOUNCEDOWN_C),
        unit(Squad.SQ_FALLEN_WALL_L_C, Slot.SQ_FALLEN_WALL_L_C),
        unit(Squad.SQ_FALLEN_1C, Slot.SQ_FALLEN_1C),
        unit(Squad.SQ_FALLEN_2, Slot.SQ_FALLEN_2),
        unit(Squad.SQ_FALLEN_DROPDOWN_E, Slot.SQ_FALLEN_DROPDOWN_E),
    },
}

local cache = {
    id = "cache",
    trigger = Slot.PT_LOOTCACHE,
    after = "breach",
    objective = Slot.OBJ_BREACH_FALLEN01,
    squads = {
        unit(Squad.SQ_FALLEN_CHEST, Slot.SQ_FALLEN_CHEST),
    },
}

local corridor = {
    id = "corridor",
    trigger = Slot.PT_MUSIC_ALLEY,
    after = "breach",
    objective = Slot.OBJ_BREACH_FALLEN01,
    squads = {
        unit(Squad.SQ_FALLEN_DROPDOWN_F, Slot.SQ_FALLEN_DROPDOWN_F),
        unit(Squad.SQ_FALLEN_WALL_R_F, Slot.SQ_FALLEN_WALL_R_F),
        unit(Squad.SQ_FALLEN_FLOOR_F, Slot.SQ_FALLEN_FLOOR_F),
        unit(Squad.SQ_FALLEN_DROPDOWN_G, Slot.SQ_FALLEN_DROPDOWN_G),
        unit(Squad.SQ_FALLEN_WALL_L_G, Slot.SQ_FALLEN_WALL_L_G),
        unit(Squad.SQ_FALLEN_H, Slot.SQ_FALLEN_H),
    },
}

local garage = {
    id = "garage",
    trigger = Slot.PT_TRANS_GRAVEYARD,
    after = "breach",
    objective = Slot.OBJ_BREACH_FALLEN01,
    squads = {
        unit(Squad.SQ_FALLEN_GARAGE_MELEE, Slot.SQ_FALLEN_GARAGE_MELEE),
        unit(Squad.SQ_FALLEN_GARAGE_VANDALS_2, Slot.SQ_FALLEN_GARAGE_VANDALS_2),
        unit(Squad.SQ_FALLEN_GARAGE_VANDALS_3, Slot.SQ_FALLEN_GARAGE_VANDALS_3),
        unit(Squad.SQ_FALLEN_GARAGE_BOSS, Slot.SQ_FALLEN_GARAGE_BOSS),
        unit(Squad.SQ_FALLEN_GARAGE_EXIT, Slot.SQ_FALLEN_GARAGE_EXIT),
    },
}

-- The raiding party the Ketch drops on the Divide. The Walker counts toward the same total.
local raiders = {
    id = "raiders",
    after = "assault",
    objective = Slot.OBJ_TANK,
    squads = {
        unit(Squad.SQ_TANK_FODDER_CACHE_1, Slot.SQ_TANK_FODDER_CACHE_1),
        unit(Squad.SQ_TANK_FODDER_CACHE_2, Slot.SQ_TANK_FODDER_CACHE_2),
        unit(Squad.SQ_TANK_FODDER_CACHE_3, Slot.SQ_TANK_FODDER_CACHE_3),
        unit(Squad.SQ_FODDER_EXIT, Slot.SQ_FODDER_EXIT),
    },
}

local walker = {
    id = "walker",
    after = "assault",
    objective = Slot.OBJ_TANK,
    squads = {
        unit(Squad.SQ_TANK, Slot.SQ_TANK),
    },
}

local hangar = {
    id = "hangar",
    trigger = Slot.PT_ENTER_HANGAR,
    objective = Slot.OBJ_M0_HANGAR_FALLEN,
    squads = {
        unit(Squad.SQ_CH1_FALLEN_ON_PLAYERSHIP_1, Slot.SQ_CH1_FALLEN_ON_PLAYERSHIP_1),
        unit(Squad.SQ_CH1_FALLEN_ON_PLAYERSHIP_2, Slot.SQ_CH1_FALLEN_ON_PLAYERSHIP_2),
        unit(Squad.SQ_CH1_FALLEN_ON_PLAYERSHIP_3, Slot.SQ_CH1_FALLEN_ON_PLAYERSHIP_3),
    },
}

local backup = {
    id = "backup",
    trigger = Slot.PT_FALLEN_BACKUP,
    objective = Slot.OBJ_M0_HANGAR_FALLEN,
    squads = {
        unit(Squad.SQ_M0_FALLEN_1, Slot.SQ_M0_FALLEN_1),
        unit(Squad.SQ_M0_FALLEN_2, Slot.SQ_M0_FALLEN_2),
    },
}

return campaign.new{
    key = "launchpad",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_8153C294,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_8153C294,
    legs = {
        {id = "exterior", state = mission.states.STATE_8153C01B_0003_0000_8153C019,
            arm = {Slot.PT_NUX_SPRINT, Slot.PT_NUX_MMODE, Slot.PT_DIALOG_HELP}},
        {id = "breach", state = mission.states.STATE_8153C01B_0000_0000_8153C014, arm = {
            Slot.PT_FALLEN_ABOVE, Slot.PT_FIRST_WEAPON_GIVE, Slot.PT_NUX_GHOST_LIGHT_UP_START,
            Slot.PT_DIAG_CORNER, Slot.PT_LOOTCACHE, Slot.PT_MUSIC_ALLEY,
            Slot.PT_TRANS_GRAVEYARD, Slot.PT_EXIT_8153C1E2,
        }},
        {id = "divide", state = mission.states.STATE_8153C01B_0001_0000_8153C015, arm = {
            Slot.PT_KETCH, Slot.PT_GRAVEYARD_REVEAL, Slot.PT_ENTER_HANGAR,
        }},
        {id = "hangar", state = mission.states.STATE_8153C01B_0002_0000_8153C016, arm = {
            Slot.PT_FALLEN_SHIP, Slot.PT_MAIN_ROOM, Slot.PT_FALLEN_BACKUP,
            Slot.PT_HANGAR_CHEST, Slot.PT_HANGAR_POST_CHEST, Slot.PT_END_MISSION,
        }},
    },
    steps = {
        -- Resurrected outside the wall.
        {id = "resurrected", directive = Directive.ENTER_THE_COSMODROME,
            navpoint = Slot.NP_WALL,
            lines = {line(cue.CUE_0)},
            ends = {region = "breach"}},
        -- The Breach. The placed gate owns the lift, so the doors overlay stays out.
        {id = "preparation", directive = Directive.KEEP_MOVING,
            navpoint = Slot.NP_GHOST_LIGHT,
            lines = {line(cue.CUE_6)},
            on_start = function(context)
                context:activate_objects{slots = {Slot.O_BREACH_GATING_LIGHTS_8153C1AD,
                    Slot.O_BREACH_CONTROL_8153C1AD, Slot.O_BREACH_CABLES,
                    Slot.O_FLOOR_GRATE_2B, Slot.O_FLOOR_GRATE_2A}, active = true}
                context:activate_objects{slots = {Slot.O_BREACH_DOORS_LIGHTS}, active = false}
                move(context, {Slot.D_BREACH_GATE_LIGHTS_8153C1AD}, "close")
            end,
            ends = {trigger = Slot.PT_FALLEN_ABOVE}},
        -- "Fallen. Above you."
        {id = "above", lines = {line(cue.CUE_7)},
            on_start = function(context)
                context:slot(Slot.SEQ_FALLEN_ABOVE):play_sequence{}
            end,
            ends = {trigger = Slot.PT_NUX_GHOST_LIGHT_UP_START}},
        -- The dark room. The Ghost goes for the lights.
        {id = "dark_room", lines = {line(cue.CUE_8), line(cue.CUE_9)},
            navpoint = Slot.NP_GHOST_LIGHT,
            on_start = function(context)
                context:activate_objects{slots = {Slot.O_BREACH_GATING_BACK}, active = true}
            end,
            ends = {trigger = Slot.PT_FIRST_WEAPON_GIVE}},
        -- "There. A rifle."
        {id = "rifle", directive = Directive.ARM_YOURSELF,
            lines = {line(cue.CUE_10), line(cue.CUE_11)},
            on_start = function(context)
                context:activate_objects{slots = {Slot.O_WEAPON}, active = true}
            end,
            ends = {interact = Slot.O_WEAPON_INTERACT}},
        -- Through the Breach. Every ambush below is its own trigger; none of them gates the way.
        {id = "breach", directive = Directive.SURVIVE_GOING_THROUGH_THE_BREACH,
            lines = {line(cue.CUE_12)},
            on_start = function(context)
                context:activate_objects{slots = {Slot.O_BREACH_GATING_BACK, Slot.O_WEAPON},
                    active = false}
            end,
            ends = {trigger = Slot.PT_DIAG_CORNER}},
        {id = "first_fight", lines = {line(cue.CUE_13), line(cue.CUE_14)},
            ends = {trigger = Slot.PT_LOOTCACHE}},
        -- The weapon cache in the alley.
        {id = "cache", lines = {line(cue.CUE_15)},
            ends = {interact = Slot.O_CHEST_WEAPON}},
        {id = "shotgun", lines = {line(cue.CUE_17)},
            ends = {trigger = Slot.PT_MUSIC_ALLEY}},
        {id = "corridor", lines = {line(cue.CUE_24)},
            ends = {trigger = Slot.PT_TRANS_GRAVEYARD}},
        {id = "garage", ends = {trigger = Slot.PT_EXIT_8153C1E2, region = "divide"}},
        -- The Divide. The Ketch comes over the graveyard.
        {id = "gantry", lines = {line(cue.CUE_26)},
            on_start = function(context)
                context:activate_objects{slots = {Slot.O_KETCH_GANTRY}, active = true}
            end,
            ends = {trigger = Slot.PT_KETCH}},
        {id = "ketch", lines = {line(cue.CUE_27)},
            on_start = function(context)
                context:activate_objects{slots = {Slot.O_SIGNAL_FLARE}, active = true}
            end,
            ends = {trigger = Slot.PT_GRAVEYARD_REVEAL}},
        -- "Push back the assault." The reveal and the fight start together.
        {id = "assault", directive = Directive.PUSH_BACK_THE_ASSAULT,
            navpoint = Slot.NP_CHEST,
            lines = {line(cue.CUE_28)},
            barrier = true, ends = {clear = {"raiders", "walker"}}},
        {id = "signal", directive = Directive.GET_TO_THE_JUMPSHIP,
            navpoint = Slot.NP_END_MISSION_8153C210,
            lines = {line(cue.CUE_32)},
            ends = {trigger = Slot.PT_ENTER_HANGAR, region = "hangar"}},
        -- Dock 13. The ship and its wiring come up with the objective.
        {id = "dock", directive = Directive.FIND_THE_JUMPSHIP,
            navpoint = Slot.NP_END_MISSION_8153C272,
            lines = {line(cue.CUE_36)},
            on_start = function(context)
                context:activate_objects{slots = {Slot.O_SHIP, Slot.O_SHIP_WIRES,
                    Slot.O_SHIP_CONSOLE, Slot.O_ROOF_WIRES, Slot.O_ROOF}, active = true}
            end,
            ends = {interact = Slot.O_POWER_CHEST}},
        {id = "rocket", lines = {line(cue.CUE_38)},
            ends = {trigger = Slot.PT_MAIN_ROOM}},
        {id = "clear", directive = Directive.CLEAR_THE_AREA,
            navpoint = Slot.NP_END_MISSION_8153C272,
            lines = {line(cue.CUE_39)},
            barrier = true, ends = {clear = {"hangar", "backup"}}},
        -- "Your ship. Let's go."
        {id = "jumpship", directive = Directive.GET_TO_THE_JUMPSHIP,
            navpoint = Slot.NP_END_MISSION_8153C272,
            lines = {line(cue.CUE_40)},
            ends = {trigger = Slot.PT_END_MISSION}},
    },
    encounters = {
        nests, first_vandal, first_fight, cache, corridor, garage,
        raiders, walker, hangar, backup,
    },
}
