-- Chosen. Panoptes, the Infinite Mind. Ported from the Dawn fork; not tested in game.
-- Three legs: the Lighthouse (120), Infinite Forest D (88), the Lair and the Crown (112).
-- Dawn keeps this mission's whole combat order in C++ behind one plugin argument, so the wave
-- order below is read out of its catalogs and written here as explicit steps.
-- Not ported: Panoptes himself. His arms, eye, lift, teleports, damage phases and the arc-charge
-- crown are client-side in Dawn, and the damage transaction protocol is not decoded. The rescue
-- of Osiris, the boss reveal cinematic and the Mercury ending handoff are out for the same reason.
-- What this script owns is the route, the objectives, the dialogue and all fifteen enemy waves.
local missions = require("missions")
local mission = require(missions.MISSION_SCOT)
local campaign = require("lib.campaign")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive, Scene = mission.Slot, mission.Squad, mission.Directive, mission.Scene
local cue = mission.DialogueCue.M_DIALOG_SENSOR_80F47BDD

-- The Lair's first summon, on the left arm.
local lair_left = {
    id = "lair_left",
    after = "lair_left",
    objective = Slot.OBJ_ALL_80F47979,
    squads = {
        unit(Squad.SQ_FRONT_1_80F47979, Slot.SQ_FRONT_1_80F47979),
        unit(Squad.SQ_FRONT_2_80F47979, Slot.SQ_FRONT_2_80F47979),
        unit(Squad.SQ_FRONT_3, Slot.SQ_FRONT_3),
        unit(Squad.SQ_FRONT_4, Slot.SQ_FRONT_4),
        unit(Squad.SQ_SIDE_1, Slot.SQ_SIDE_1),
        unit(Squad.SQ_SIDE_2, Slot.SQ_SIDE_2),
    },
}

-- The second summon, on the right arm, with the named anchor.
local lair_right = {
    id = "lair_right",
    after = "lair_right",
    objective = Slot.OBJ_ALL_80F47979,
    squads = {
        unit(Squad.SQ_ANCHOR_80F47979, Slot.SQ_ANCHOR_80F47979),
        unit(Squad.SQ_WAVE_B_1_80F47979, Slot.SQ_WAVE_B_1_80F47979),
        unit(Squad.SQ_WAVE_B_2_80F47979, Slot.SQ_WAVE_B_2_80F47979),
        unit(Squad.SQ_GUARDS_1, Slot.SQ_GUARDS_1),
        unit(Squad.SQ_GUARDS_2, Slot.SQ_GUARDS_2),
    },
}

local island_a = {
    id = "island_a",
    after = "island_a",
    objective = Slot.OBJ_ISLANDS,
    squads = {
        unit(Squad.SQ_ISLAND_A_1, Slot.SQ_ISLAND_A_1),
        unit(Squad.SQ_ISLAND_A_2, Slot.SQ_ISLAND_A_2),
    },
}

local island_b = {
    id = "island_b",
    after = "island_b",
    objective = Slot.OBJ_ISLANDS,
    squads = {
        unit(Squad.SQ_ISLAND_B_1, Slot.SQ_ISLAND_B_1),
        unit(Squad.SQ_ISLAND_B_2, Slot.SQ_ISLAND_B_2),
    },
}

local island_c = {
    id = "island_c",
    after = "island_c",
    objective = Slot.OBJ_ISLANDS,
    squads = {
        unit(Squad.SQ_ISLAND_C_1, Slot.SQ_ISLAND_C_1),
        unit(Squad.SQ_ISLAND_C_2, Slot.SQ_ISLAND_C_2),
    },
}

-- Crown cycle 1, the Fallen.
local crown1_a = {
    id = "crown1_a",
    after = "crown1_a",
    objective = Slot.OBJ_ALL_80F476C6,
    squads = {
        unit(Squad.SQ_FRONT_1_80F476C6, Slot.SQ_FRONT_1_80F476C6),
        unit(Squad.SQ_FRONT_2_80F476C6, Slot.SQ_FRONT_2_80F476C6),
        unit(Squad.SQ_SIDE_LEFT_1_80F476C6, Slot.SQ_SIDE_LEFT_1_80F476C6),
        unit(Squad.SQ_SIDE_LEFT_2_80F476C6, Slot.SQ_SIDE_LEFT_2_80F476C6),
        unit(Squad.SQ_SIDE_RIGHT_1_80F476C6, Slot.SQ_SIDE_RIGHT_1_80F476C6),
        unit(Squad.SQ_SIDE_RIGHT_2_80F476C6, Slot.SQ_SIDE_RIGHT_2_80F476C6),
        unit(Squad.SQ_BACK_1_80F476C6, Slot.SQ_BACK_1_80F476C6),
        unit(Squad.SQ_BACK_2_80F476C6, Slot.SQ_BACK_2_80F476C6),
    },
}

local crown1_b = {
    id = "crown1_b",
    after = "crown1_b",
    objective = Slot.OBJ_ALL_80F476C6,
    squads = {
        unit(Squad.SQ_WAVE_B_1_80F476C6, Slot.SQ_WAVE_B_1_80F476C6),
        unit(Squad.SQ_WAVE_B_2_80F476C6, Slot.SQ_WAVE_B_2_80F476C6),
        unit(Squad.SQ_WAVE_B_3_80F476C6, Slot.SQ_WAVE_B_3_80F476C6),
    },
}

local crown1_c = {
    id = "crown1_c",
    after = "crown1_c",
    objective = Slot.OBJ_ALL_80F476C6,
    squads = {
        unit(Squad.SQ_ANCHOR_80F476C6, Slot.SQ_ANCHOR_80F476C6),
        unit(Squad.SQ_WAVE_C_1_80F476C6, Slot.SQ_WAVE_C_1_80F476C6),
        unit(Squad.SQ_WAVE_C_2_80F476C6, Slot.SQ_WAVE_C_2_80F476C6),
        unit(Squad.SQ_WAVE_C_3_80F476C6, Slot.SQ_WAVE_C_3_80F476C6),
    },
}

-- Crown cycle 2, the Hive.
local crown2_a = {
    id = "crown2_a",
    after = "crown2_a",
    objective = Slot.OBJ_ALL_80F4779F,
    squads = {
        unit(Squad.SQ_FRONT_1_80F4779F, Slot.SQ_FRONT_1_80F4779F),
        unit(Squad.SQ_FRONT_2_80F4779F, Slot.SQ_FRONT_2_80F4779F),
        unit(Squad.SQ_SIDE_LEFT_1_80F4779F, Slot.SQ_SIDE_LEFT_1_80F4779F),
        unit(Squad.SQ_SIDE_LEFT_2_80F4779F, Slot.SQ_SIDE_LEFT_2_80F4779F),
        unit(Squad.SQ_SIDE_RIGHT_1_80F4779F, Slot.SQ_SIDE_RIGHT_1_80F4779F),
        unit(Squad.SQ_SIDE_RIGHT_2_80F4779F, Slot.SQ_SIDE_RIGHT_2_80F4779F),
        unit(Squad.SQ_BACK_1_80F4779F, Slot.SQ_BACK_1_80F4779F),
        unit(Squad.SQ_BACK_2_80F4779F, Slot.SQ_BACK_2_80F4779F),
    },
}

local crown2_b = {
    id = "crown2_b",
    after = "crown2_b",
    objective = Slot.OBJ_ALL_80F4779F,
    squads = {
        unit(Squad.SQ_WAVE_B_1_80F4779F, Slot.SQ_WAVE_B_1_80F4779F),
        unit(Squad.SQ_WAVE_B_2_80F4779F, Slot.SQ_WAVE_B_2_80F4779F),
        unit(Squad.SQ_WAVE_B_MELEE_80F4779F, Slot.SQ_WAVE_B_MELEE_80F4779F),
    },
}

local crown2_c = {
    id = "crown2_c",
    after = "crown2_c",
    objective = Slot.OBJ_ALL_80F4779F,
    squads = {
        unit(Squad.SQ_ANCHOR_80F4779F, Slot.SQ_ANCHOR_80F4779F),
        unit(Squad.SQ_WAVE_C_1_80F4779F, Slot.SQ_WAVE_C_1_80F4779F),
        unit(Squad.SQ_WAVE_C_2_80F4779F, Slot.SQ_WAVE_C_2_80F4779F),
        unit(Squad.SQ_WAVE_C_3_80F4779F, Slot.SQ_WAVE_C_3_80F4779F),
    },
}

-- The Cabal that cover Panoptes' escape. Never a kill barrier: he leaves while they live.
local escape = {
    id = "escape",
    after = "escape",
    objective = Slot.OBJ_ALL_80F47807,
    squads = {
        unit(Squad.SQ_WAVE_A_1_80F47807, Slot.SQ_WAVE_A_1_80F47807),
        unit(Squad.SQ_WAVE_A_2_80F47807, Slot.SQ_WAVE_A_2_80F47807),
        unit(Squad.SQ_WAVE_A_3_80F47807, Slot.SQ_WAVE_A_3_80F47807),
        unit(Squad.SQ_WAVE_A_4_80F47807, Slot.SQ_WAVE_A_4_80F47807),
        unit(Squad.SQ_ANCHOR_80F47807, Slot.SQ_ANCHOR_80F47807),
        unit(Squad.SQ_MELEE_1, Slot.SQ_MELEE_1),
        unit(Squad.SQ_MELEE_2, Slot.SQ_MELEE_2),
        unit(Squad.SQ_MELEE_3, Slot.SQ_MELEE_3),
        unit(Squad.SQ_MELEE_4, Slot.SQ_MELEE_4),
        unit(Squad.SQ_MELEE_5, Slot.SQ_MELEE_5),
        unit(Squad.SQ_MELEE_6, Slot.SQ_MELEE_6),
    },
}

-- Crown cycle 3, the Vex.
local crown3_a = {
    id = "crown3_a",
    after = "crown3_a",
    objective = Slot.OBJ_ALL_80F478BD,
    squads = {
        unit(Squad.SQ_WAVE_A_1_80F478BD, Slot.SQ_WAVE_A_1_80F478BD),
        unit(Squad.SQ_WAVE_A_2_80F478BD, Slot.SQ_WAVE_A_2_80F478BD),
        unit(Squad.SQ_WAVE_A_3_80F478BD, Slot.SQ_WAVE_A_3_80F478BD),
        unit(Squad.SQ_WAVE_A_4_80F478BD, Slot.SQ_WAVE_A_4_80F478BD),
        unit(Squad.SQ_WAVE_A_5, Slot.SQ_WAVE_A_5),
        unit(Squad.SQ_WAVE_A_6, Slot.SQ_WAVE_A_6),
        unit(Squad.SQ_FANATICS_INITIAL, Slot.SQ_FANATICS_INITIAL),
    },
}

local crown3_b = {
    id = "crown3_b",
    after = "crown3_b",
    objective = Slot.OBJ_ALL_80F478BD,
    squads = {
        unit(Squad.SQ_WAVE_B_MELEE_80F478BD, Slot.SQ_WAVE_B_MELEE_80F478BD),
        unit(Squad.SQ_WAVE_B_1_80F478BD, Slot.SQ_WAVE_B_1_80F478BD),
        unit(Squad.SQ_WAVE_B_2_80F478BD, Slot.SQ_WAVE_B_2_80F478BD),
        unit(Squad.SQ_WAVE_B_3_80F478BD, Slot.SQ_WAVE_B_3_80F478BD),
    },
}

local crown3_c = {
    id = "crown3_c",
    after = "crown3_c",
    objective = Slot.OBJ_ALL_80F478BD,
    squads = {
        unit(Squad.SQ_ANCHOR_80F478BD, Slot.SQ_ANCHOR_80F478BD),
        unit(Squad.SQ_WAVE_C_1_80F478BD, Slot.SQ_WAVE_C_1_80F478BD),
        unit(Squad.SQ_WAVE_C_2_80F478BD, Slot.SQ_WAVE_C_2_80F478BD),
    },
}

return campaign.new{
    key = "scot",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80F47BDD,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80F47BDD,
    legs = {
        {id = "lighthouse", state = mission.states.STATE_80F47522_000F_0000_80F4751C,
            arm = {Slot.PT_START_IKORA_VIGNETTE, Slot.PT_START_IKORA_OUTER_DIALOGUE},
            watch = {Slot.PM_WEAPONDOWN, Slot.INFINITE_FOREST_ENTRANCE_PLAYER_MONITOR}},
        {id = "forest", state = mission.states.STATE_80F47522_000B_0000_80F47518,
            arm = {}, watch = {Slot.BUBBLE_MONITOR_D}},
        {id = "lair", state = mission.states.STATE_80F47522_000E_0000_80F4751B,
            arm = {Slot.PT_BOSS_PLATFORM, Slot.PT_SPAWN_BOSS, Slot.PT_SIDES,
                Slot.PT_FIRST_ISLAND, Slot.PT_FIRST_ISLAND_HALFWAY, Slot.PT_SECOND_ISLAND,
                Slot.PT_FINAL_ISLAND, Slot.PT_FINAL_FLIGHT,
                Slot.PT_PLATFORM_START_80F476C6, Slot.PT_JUMP_PLATFORM_80F476C6,
                Slot.PT_PLATFORM_START_80F4779F, Slot.PT_JUMP_PLATFORM_80F4779F,
                Slot.PT_PLATFORM_START_80F47807, Slot.PT_BACK_PLATFORM, Slot.PT_SPAWN_MELEE,
                Slot.PT_PLATFORM_START_80F478BD},
            watch = {Slot.PM_LAIR_80F47B4B}},
    },
    steps = {
        -- Ikora holds the Forest gate shut until the player walks up to her.
        {id = "gate", directive = Directive.DESTROY_PANOPTES_THE_INFINITE_MIND,
            on_start = function(context)
                move(context, {Slot.D_GATE_CONTROLLER}, "close")
            end,
            ends = {monitor = Slot.PM_WEAPONDOWN}},
        {id = "ikora", scene = Scene.SCENE_IKORA_OPENS_PORTAL,
            ends = {scene = Slot.SCENE_IKORA_OPENS_PORTAL}},
        -- The lattice releases and the gate opens.
        {id = "portal",
            on_start = function(context)
                move(context, {Slot.D_GATE_CONTROLLER}, "open")
                context:slot(Slot.MAP_GENERATOR_SENSOR_80F47539):generate_map{
                    seed = campaign.run_seed(context), enabled = true}
            end,
            ends = {monitor = Slot.INFINITE_FOREST_ENTRANCE_PLAYER_MONITOR, region = "forest"}},
        -- Infinite Forest D. Its four landmarks have no authored player trigger, so the crossing
        -- ends on the bubble monitor and the lines go out with it.
        {id = "forest", directive = Directive.DESTROY_PANOPTES_THE_INFINITE_MIND,
            lines = {line(cue.CUE_6), line(cue.CUE_7)},
            ends = {monitor = Slot.BUBBLE_MONITOR_D}},
        {id = "lair_arrival", directive = Directive.TEAM_UP_WITH_OSIRIS_TO_DEFEAT_PANOPTES_3517D4D5,
            navpoint = Slot.AP_BOSS_PLATFORM,
            lines = {line(cue.CUE_9)},
            ends = {monitor = Slot.PM_LAIR_80F47B4B, region = "lair"}},
        -- The Lair. Panoptes summons from one arm, then the other.
        {id = "lair_left", navpoint = Slot.AP_BOSS_PLATFORM,
            barrier = true, ends = {clear = "lair_left"}},
        {id = "lair_right", navpoint = Slot.AP_BOSS_PLATFORM,
            barrier = true, ends = {clear = "lair_right"}},
        -- Three islands on the way to the Crown.
        {id = "island_a", barrier = true, ends = {clear = "island_a"}},
        {id = "island_b", barrier = true, ends = {clear = "island_b"}},
        {id = "island_c", barrier = true, ends = {clear = "island_c"}},
        -- Crown cycle 1, the Fallen. Three waves, each a kill barrier.
        {id = "crown1_a", barrier = true, ends = {clear = "crown1_a"}},
        {id = "crown1_b", barrier = true, ends = {clear = "crown1_b"}},
        {id = "crown1_c", barrier = true, ends = {clear = "crown1_c"}},
        -- Crown cycle 2, the Hive.
        {id = "crown2_a", barrier = true, ends = {clear = "crown2_a"}},
        {id = "crown2_b", barrier = true, ends = {clear = "crown2_b"}},
        {id = "crown2_c", barrier = true, ends = {clear = "crown2_c"}},
        -- The escape cover. It places and the mission moves on; nothing waits for it to die.
        {id = "escape", ends = {trigger = Slot.PT_PLATFORM_START_80F478BD}},
        -- Crown cycle 3, the Vex.
        {id = "crown3_a", barrier = true, ends = {clear = "crown3_a"}},
        {id = "crown3_b", barrier = true, ends = {clear = "crown3_b"}},
        {id = "crown3_c", barrier = true, ends = {clear = "crown3_c"}},
    },
    encounters = {
        lair_left, lair_right, island_a, island_b, island_c,
        crown1_a, crown1_b, crown1_c, crown2_a, crown2_b, crown2_c,
        escape, crown3_a, crown3_b, crown3_c,
    },
}
