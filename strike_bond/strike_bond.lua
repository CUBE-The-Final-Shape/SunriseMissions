-- A Garden World. Ported from the Dawn fork's step graph; not tested in game.
-- Four legs: the Lighthouse (120), the Infinite Forest (80), the simulant past (8), the Spire
-- (136). The route is the cube puzzle: each Vex lens is shot, then its block and lasers come down.
-- Each run seeds the authored type-37 Forest worker and leaves its other inputs authored.
-- Dendron's shield phases read the health fraction his type-2 Sense already reports.
-- Not ported: the lens expose mechanic, which Dawn sends before a lens may be shot.
local missions = require("missions")
local mission = require(missions.STRIKE_BOND)
local campaign = require("lib.campaign")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive, Scene = mission.Slot, mission.Squad, mission.Directive, mission.Scene
local cue = mission.DialogueCue.M_DIALOG_SENSOR

local lighthouse = {
    id = "lighthouse",
    objective = Slot.OBJ_LIGHTHOUSE,
    squads = {
        unit(Squad.SQ_TOP, Slot.SQ_TOP),
        unit(Squad.SQ_STAIRS_LEFT, Slot.SQ_STAIRS_LEFT),
        unit(Squad.SQ_STAIRS_RIGHT, Slot.SQ_STAIRS_RIGHT),
        unit(Squad.SQ_LANDING, Slot.SQ_LANDING),
    },
}

-- The fixed exit-platform sources of Forest C, not procedural population.
local forest_exit = {
    id = "forest_exit",
    trigger = Slot.PT_BEGIN,
    objective = Slot.OBJ_IFC,
    squads = {
        unit(Squad.SQ_CYCLOPS_0, Slot.SQ_CYCLOPS_0),
        unit(Squad.SQ_CYCLOPS_1, Slot.SQ_CYCLOPS_1),
        unit(Squad.SQ_CYCLOPS_2, Slot.SQ_CYCLOPS_2),
        unit(Squad.SQ_GOBLINS_0, Slot.SQ_GOBLINS_0),
        unit(Squad.SQ_GOBLINS_1, Slot.SQ_GOBLINS_1),
    },
}

local arrival = {
    id = "arrival",
    after = "past_arrival",
    objective = Slot.OBJ_ARRIVAL,
    squads = {
        unit(Squad.SQ_ARRIVAL_0, Slot.SQ_ARRIVAL_0),
        unit(Squad.SQ_ARRIVAL_1, Slot.SQ_ARRIVAL_1),
        unit(Squad.SQ_ARRIVAL_2, Slot.SQ_ARRIVAL_2),
        unit(Squad.SQ_ARRIVAL_3, Slot.SQ_ARRIVAL_3),
        unit(Squad.SQ_ARRIVAL_4, Slot.SQ_ARRIVAL_4),
        unit(Squad.SQ_ARRIVAL_5, Slot.SQ_ARRIVAL_5),
        unit(Squad.SQ_ARRIVAL_6, Slot.SQ_ARRIVAL_6),
        unit(Squad.SQ_ARRIVAL_7, Slot.SQ_ARRIVAL_7),
        unit(Squad.SQ_ARRIVAL_RIGHT_FLANK, Slot.SQ_ARRIVAL_RIGHT_FLANK),
        unit(Squad.SQ_ARRIVAL_LEFT_FLANK, Slot.SQ_ARRIVAL_LEFT_FLANK),
        unit(Squad.SQ_LOWER_PLATFORM, Slot.SQ_LOWER_PLATFORM),
    },
}

local modules = {
    id = "modules",
    after = "countermeasures",
    objective = Slot.OBJ_ARRIVAL,
    squads = {
        unit(Squad.SQ_UPPER_PLATFORM_0, Slot.SQ_UPPER_PLATFORM_0),
        unit(Squad.SQ_UPPER_PLATFORM_1, Slot.SQ_UPPER_PLATFORM_1),
    },
}

local terrace = {
    id = "terrace",
    after = "terrace",
    objective = Slot.OBJ_BYGONE,
    squads = {
        unit(Squad.SQ_TERRACE_HIGH_0, Slot.SQ_TERRACE_HIGH_0),
        unit(Squad.SQ_TERRACE_HIGH_1, Slot.SQ_TERRACE_HIGH_1),
        unit(Squad.SQ_TERRACE_HIGH_2, Slot.SQ_TERRACE_HIGH_2),
        unit(Squad.SQ_TERRACE_HIGH_3, Slot.SQ_TERRACE_HIGH_3),
        unit(Squad.SQ_TERRACE_HIGH_4, Slot.SQ_TERRACE_HIGH_4),
        unit(Squad.SQ_TERRACE_LOW_0, Slot.SQ_TERRACE_LOW_0),
        unit(Squad.SQ_TERRACE_LOW_1, Slot.SQ_TERRACE_LOW_1),
        unit(Squad.SQ_TERRACE_LOW_2, Slot.SQ_TERRACE_LOW_2),
        unit(Squad.SQ_TERRACE_LOW_3, Slot.SQ_TERRACE_LOW_3),
        unit(Squad.SQ_TERRACE_GOLEM_SUPPORT_0, Slot.SQ_TERRACE_GOLEM_SUPPORT_0),
        unit(Squad.SQ_TERRACE_GOLEM_SUPPORT_1, Slot.SQ_TERRACE_GOLEM_SUPPORT_1),
        unit(Squad.SQ_TERRACE_GOLEM_SUPPORT_2, Slot.SQ_TERRACE_GOLEM_SUPPORT_2),
        unit(Squad.SQ_TERRACE_GOLEM_SUPPORT_3, Slot.SQ_TERRACE_GOLEM_SUPPORT_3),
    },
}

-- The Minotaur that holds the terrace shield. Its scene owns the reveal.
local terrace_golem = {
    id = "terrace_golem",
    after = "terrace",
    objective = Slot.OBJ_BYGONE,
    squads = {
        unit(Squad.PF_TERRACE_GOLEM_SQ_GOLEM, Slot.PF_TERRACE_GOLEM_SQ_GOLEM),
    },
}

local gate1 = {
    id = "gate1",
    after = "corridor",
    objective = Slot.OBJ_INTERIOR,
    squads = {
        unit(Squad.SQ_GATE1_0, Slot.SQ_GATE1_0),
        unit(Squad.SQ_GATE1_1, Slot.SQ_GATE1_1),
        unit(Squad.SQ_GATE1_2, Slot.SQ_GATE1_2),
        unit(Squad.SQ_GATE1_SUPPORT_0, Slot.SQ_GATE1_SUPPORT_0),
        unit(Squad.SQ_GATE1_SUPPORT_1, Slot.SQ_GATE1_SUPPORT_1),
        unit(Squad.SQ_GATE1_SNIPER_0, Slot.SQ_GATE1_SNIPER_0),
        unit(Squad.SQ_GATE1_SNIPER_1, Slot.SQ_GATE1_SNIPER_1),
    },
}

local gate2 = {
    id = "gate2",
    after = "gate2",
    objective = Slot.OBJ_INTERIOR,
    squads = {
        unit(Squad.SQ_GATE2_0, Slot.SQ_GATE2_0),
        unit(Squad.SQ_GATE2_1, Slot.SQ_GATE2_1),
        unit(Squad.SQ_GATE2_2, Slot.SQ_GATE2_2),
        unit(Squad.SQ_GATE2_SUPPORT_0, Slot.SQ_GATE2_SUPPORT_0),
        unit(Squad.SQ_GATE2_SUPPORT_1, Slot.SQ_GATE2_SUPPORT_1),
        unit(Squad.SQ_GATE2_SUPPORT_2, Slot.SQ_GATE2_SUPPORT_2),
    },
}

local cannon_guards = {
    id = "cannon_guards",
    after = "cannon_golem",
    objective = Slot.OBJ_BYGONE,
    squads = {
        unit(Squad.SQ_CANNON_0, Slot.SQ_CANNON_0),
        unit(Squad.SQ_CANNON_1, Slot.SQ_CANNON_1),
        unit(Squad.SQ_CANNON_2, Slot.SQ_CANNON_2),
        unit(Squad.SQ_CANNON_3, Slot.SQ_CANNON_3),
        unit(Squad.SQ_CANNON_SNIPERS, Slot.SQ_CANNON_SNIPERS),
    },
}

local tower_guards = {
    id = "tower_guards",
    after = "cannon_golem",
    objective = Slot.OBJ_CABAL,
    squads = {
        unit(Squad.SQ_TOWER, Slot.SQ_TOWER),
    },
}

local cannon_golem = {
    id = "cannon_golem",
    after = "cannon_golem",
    objective = Slot.OBJ_BYGONE,
    squads = {
        unit(Squad.PF_CANNON_GOLEM_SQ_GOLEM, Slot.PF_CANNON_GOLEM_SQ_GOLEM),
    },
}

local spire_lower = {
    id = "spire_lower",
    after = "climb",
    objective = Slot.OBJ_TOWER,
    squads = {
        unit(Squad.SQ_LOWER_0, Slot.SQ_LOWER_0),
        unit(Squad.SQ_LOWER_1, Slot.SQ_LOWER_1),
        unit(Squad.SQ_LOWER_2, Slot.SQ_LOWER_2),
        unit(Squad.SQ_LOWER_3, Slot.SQ_LOWER_3),
        unit(Squad.SQ_LOWER_4, Slot.SQ_LOWER_4),
    },
}

local spire_mid = {
    id = "spire_mid",
    after = "middle",
    objective = Slot.OBJ_TOWER_MID,
    squads = {
        unit(Squad.SQ_MID_0, Slot.SQ_MID_0),
        unit(Squad.SQ_MID_1, Slot.SQ_MID_1),
        unit(Squad.SQ_MID_2, Slot.SQ_MID_2),
        unit(Squad.SQ_MID_3, Slot.SQ_MID_3),
        unit(Squad.SQ_MID_4, Slot.SQ_MID_4),
        unit(Squad.SQ_MID_5, Slot.SQ_MID_5),
        unit(Squad.SQ_MID_6, Slot.SQ_MID_6),
        unit(Squad.SQ_MID_7, Slot.SQ_MID_7),
        unit(Squad.SQ_MID_SNIPER_0, Slot.SQ_MID_SNIPER_0),
        unit(Squad.SQ_MID_SNIPER_1, Slot.SQ_MID_SNIPER_1),
        unit(Squad.SQ_MID_SNIPER_2, Slot.SQ_MID_SNIPER_2),
        unit(Squad.SQ_MID_SNIPER_3, Slot.SQ_MID_SNIPER_3),
        unit(Squad.SQ_MID_SNIPER_4, Slot.SQ_MID_SNIPER_4),
    },
}

local tower_golem = {
    id = "tower_golem",
    after = "middle",
    objective = Slot.OBJ_TOWER_MID,
    squads = {
        unit(Squad.PF_TOWER_GOLEM_SQ_GOLEM, Slot.PF_TOWER_GOLEM_SQ_GOLEM),
    },
}

local spire_top = {
    id = "spire_top",
    after = "top",
    objective = Slot.OBJ_TOWER,
    squads = {
        unit(Squad.SQ_TOP_0, Slot.SQ_TOP_0),
        unit(Squad.SQ_TOP_1, Slot.SQ_TOP_1),
        unit(Squad.SQ_TOP_2, Slot.SQ_TOP_2),
        unit(Squad.SQ_TOP_3, Slot.SQ_TOP_3),
    },
}

-- Dendron stands on the platform from the arena's first push.
local dendron = {
    id = "dendron",
    after = "top",
    objective = Slot.OBJ_MACHINE,
    squads = {
        unit(Squad.SQ_BOSS_80F54A8E, Slot.SQ_BOSS_80F54A8E),
    },
}

local arena_adds = {
    id = "arena_adds",
    after = "adds",
    objective = Slot.OBJ_MACHINE,
    squads = {
        unit(Squad.SQ_BOSS_ADDS_0, Slot.SQ_BOSS_ADDS_0),
        unit(Squad.SQ_BOSS_ADDS_1, Slot.SQ_BOSS_ADDS_1),
        unit(Squad.SQ_BOSS_ADDS_2, Slot.SQ_BOSS_ADDS_2),
        unit(Squad.SQ_BOSS_ADDS_3, Slot.SQ_BOSS_ADDS_3),
        unit(Squad.SQ_LENS_ADDS_0, Slot.SQ_LENS_ADDS_0),
        unit(Squad.SQ_LENS_ADDS_1, Slot.SQ_LENS_ADDS_1),
        unit(Squad.SQ_LENS_ADDS_2, Slot.SQ_LENS_ADDS_2),
        unit(Squad.SQ_LENS_ADDS_3, Slot.SQ_LENS_ADDS_3),
        unit(Squad.SQ_LENS_ADDS_4, Slot.SQ_LENS_ADDS_4),
        unit(Squad.SQ_LENS_ADDS_5, Slot.SQ_LENS_ADDS_5),
    },
}

-- Two Minotaurs hold each shield. Killing both drops it and brings the next wave.
local shield1 = {
    id = "shield1",
    after = "shield1",
    objective = Slot.OBJ_MACHINE,
    squads = {
        unit(Squad.PF_GOLEM_0_SQ_GOLEM, Slot.PF_GOLEM_0_SQ_GOLEM),
        unit(Squad.PF_GOLEM_1_SQ_GOLEM, Slot.PF_GOLEM_1_SQ_GOLEM),
    },
}

local shield1_adds = {
    id = "shield1_adds",
    after = "shield2",
    objective = Slot.OBJ_MACHINE,
    squads = {
        unit(Squad.SQ_BOSS_ADDS_4, Slot.SQ_BOSS_ADDS_4),
        unit(Squad.SQ_BOSS_ADDS_5, Slot.SQ_BOSS_ADDS_5),
        unit(Squad.SQ_BOSS_ADDS_6, Slot.SQ_BOSS_ADDS_6),
        unit(Squad.SQ_BOSS_ADDS_7, Slot.SQ_BOSS_ADDS_7),
        unit(Squad.SQ_FINAL_ADDS1_0, Slot.SQ_FINAL_ADDS1_0),
        unit(Squad.SQ_FINAL_ADDS1_1, Slot.SQ_FINAL_ADDS1_1),
        unit(Squad.SQ_FINAL_ADDS1_2, Slot.SQ_FINAL_ADDS1_2),
        unit(Squad.SQ_FINAL_ADDS1_3, Slot.SQ_FINAL_ADDS1_3),
    },
}

local shield2 = {
    id = "shield2",
    after = "shield2",
    objective = Slot.OBJ_MACHINE,
    squads = {
        unit(Squad.PF_GOLEM_2_SQ_GOLEM, Slot.PF_GOLEM_2_SQ_GOLEM),
        unit(Squad.PF_GOLEM_3_SQ_GOLEM, Slot.PF_GOLEM_3_SQ_GOLEM),
    },
}

local shield2_adds = {
    id = "shield2_adds",
    after = "final",
    objective = Slot.OBJ_MACHINE,
    squads = {
        unit(Squad.SQ_BOSS_ADDS_8, Slot.SQ_BOSS_ADDS_8),
        unit(Squad.SQ_BOSS_ADDS_9, Slot.SQ_BOSS_ADDS_9),
        unit(Squad.SQ_BOSS_ADDS_10, Slot.SQ_BOSS_ADDS_10),
        unit(Squad.SQ_BOSS_ADDS_11, Slot.SQ_BOSS_ADDS_11),
        unit(Squad.SQ_FINAL_ADDS2_0, Slot.SQ_FINAL_ADDS2_0),
        unit(Squad.SQ_FINAL_ADDS2_1, Slot.SQ_FINAL_ADDS2_1),
        unit(Squad.SQ_FINAL_ADDS2_2, Slot.SQ_FINAL_ADDS2_2),
        unit(Squad.SQ_FINAL_ADDS2_3, Slot.SQ_FINAL_ADDS2_3),
        unit(Squad.SQ_FINAL_ADDS3_0, Slot.SQ_FINAL_ADDS3_0),
        unit(Squad.SQ_FINAL_ADDS3_1, Slot.SQ_FINAL_ADDS3_1),
        unit(Squad.SQ_FINAL_ADDS3_2, Slot.SQ_FINAL_ADDS3_2),
        unit(Squad.SQ_FINAL_ADDS3_3, Slot.SQ_FINAL_ADDS3_3),
    },
}

-- A cube is passed by removing its block and its two lasers. Position 0 removes a device body.
local function open_block(context, slots)
    move(context, slots, "close")
end

return campaign.new{
    key = "bond",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR,
    dialogue_sensor = Slot.M_DIALOG_SENSOR,
    legs = {
        {id = "lighthouse", state = mission.states.STATE_80F5426E_000F_0000_80F54269,
            arm = {Slot.PT_SPAWN_CABAL}},
        {id = "forest", state = mission.states.STATE_80F5426E_000A_0000_80F54264,
            arm = {Slot.PT_BEGIN, Slot.PT_END, Slot.PT_FAR}},
        {id = "past", state = mission.states.STATE_80F5426E_0001_0000_80F5425B,
            arm = {Slot.PT_LOWER_CANNON, Slot.PT_UPPER_PLATFORM, Slot.PT_TERRACE_STEPS,
                Slot.PT_TERRACE_FAR, Slot.PT_GATES, Slot.PT_GATE_RAMP, Slot.PT_GATES_UPPER,
                Slot.PT_MAIN_CANNON, Slot.PT_DIALOG_GOLEM},
            watch = {Slot.PM_MACHINE}},
        {id = "spire", state = mission.states.STATE_80F5426E_0011_0000_80F5426B,
            arm = {Slot.PT_ENTRY, Slot.PT_MID, Slot.PT_SECOND_FLOOR, Slot.PT_THIRD_FLOOR,
                Slot.PT_MANCANNON2, Slot.PT_TOP}},
    },
    steps = {
        -- Ikora sends the Guardian through the Lighthouse gate.
        {id = "briefing", directive = Directive.ENTER_THE_INFINITE_FOREST,
            lines = {line(cue.CUE_0)},
            on_start = function(context)
                context:activate_objects{slots = {Slot.LIGHTHOUSE_TELEPORT}, active = true}
            end,
            ends = {region = "forest"}},
        -- "Search for a gateway to the past." Forest C generates its islands from the seed.
        {id = "forest", directive = Directive.SEARCH_FOR_A_GATEWAY_TO_THE_PAST,
            lines = {line(cue.CUE_1)},
            on_start = function(context)
                context:slot(Slot.MAP_GENERATOR_SENSOR_80F5460E):generate_map{
                    seed = campaign.run_seed(context), enabled = true}
            end,
            ends = {trigger = {Slot.PT_END, Slot.PT_FAR}}},
        {id = "gate", directive = Directive.ENTER_THE_PAST, ends = {region = "past"}},
        -- The simulant past. The launch cannons come up with the arrival.
        {id = "past_arrival", directive = Directive.ENTER_THE_SPIRE_2D67AB51,
            lines = {line(cue.CUE_3)},
            on_start = function(context)
                move(context, {Slot.D_MANCANNON_0_80F54563, Slot.D_MANCANNON_1_80F54563,
                    Slot.D_MANCANNON_2_80F54563, Slot.D_MANCANNON_3_80F54563}, "open")
                context:activate_objects{slots = {Slot.O_CANNON}, active = true}
            end,
            ends = {trigger = Slot.PT_LOWER_CANNON}},
        -- "Radiolaria." The security modules are ahead.
        {id = "radiolaria", directive = Directive.SABOTAGE_VEX_SECURITY_PROTOCOLS_82271EEA,
            lines = {line(cue.CUE_5)},
            ends = {trigger = Slot.PT_UPPER_PLATFORM}},
        -- The first cube. Dawn sent a lens-expose mechanic before it could be shot; we do not have
        -- that verb, so the lens stands as the map seeds it.
        {id = "countermeasures", lines = {line(cue.CUE_4)},
            ends = {destroyed = {Slot.PF_BLOCK_0_O_VEX_LENS}}},
        {id = "first_block", lines = {line(cue.CUE_6), line(cue.CUE_7)},
            on_start = function(context)
                open_block(context, {Slot.PF_BLOCK_0_D_VEX_BLOCK, Slot.PF_BLOCK_0_D_LASER_IN,
                    Slot.PF_BLOCK_0_D_LASER_OUT, Slot.PF_BLOCK_0_D_SHIELD})
            end,
            ends = {trigger = {Slot.PT_TERRACE_STEPS, Slot.PT_TERRACE_FAR}}},
        -- The terrace Minotaur holds the second cube's shield.
        {id = "terrace", directive = Directive.ENTER_THE_SPIRE_6D15E881,
            navpoint = Slot.AP_TERRACE_GOLEM_LENS,
            lines = {line(cue.CUE_8), line(cue.CUE_9)},
            scene = Scene.PF_TERRACE_GOLEM_SN_GOLEM,
            ends = {clear = "terrace_golem"}},
        {id = "terrace_block", lines = {line(cue.CUE_10)},
            on_start = function(context)
                move(context, {Slot.PF_TERRACE_GOLEM_D_LASER, Slot.PF_TERRACE_GOLEM_D_SHIELD},
                    "close")
            end,
            ends = {destroyed = {Slot.PF_BLOCK_1_O_VEX_LENS, Slot.PF_BLOCK_2_O_VEX_LENS}}},
        {id = "corridor", directive = Directive.SABOTAGE_VEX_SECURITY_PROTOCOLS,
            on_start = function(context)
                open_block(context, {Slot.PF_BLOCK_1_D_VEX_BLOCK, Slot.PF_BLOCK_1_D_LASER_IN,
                    Slot.PF_BLOCK_1_D_LASER_OUT, Slot.PF_BLOCK_1_D_SHIELD,
                    Slot.PF_BLOCK_2_D_VEX_BLOCK, Slot.PF_BLOCK_2_D_LASER_IN,
                    Slot.PF_BLOCK_2_D_LASER_OUT, Slot.PF_BLOCK_2_D_SHIELD})
            end,
            ends = {trigger = {Slot.PT_GATES, Slot.PT_GATE_RAMP, Slot.PT_GATES_UPPER}}},
        {id = "gates", ends = {destroyed = {Slot.PF_BLOCK_3_O_VEX_LENS}}},
        {id = "gate2", lines = {line(cue.CUE_11)},
            on_start = function(context)
                open_block(context, {Slot.PF_BLOCK_3_D_VEX_BLOCK, Slot.PF_BLOCK_3_D_LASER_IN,
                    Slot.PF_BLOCK_3_D_LASER_OUT, Slot.PF_BLOCK_3_D_SHIELD})
            end,
            ends = {destroyed = {Slot.PF_BLOCK_4_O_VEX_LENS}}},
        -- The cannon Minotaur guards the way to the Spire.
        {id = "cannon_golem", scene = Scene.PF_CANNON_GOLEM_SN_GOLEM,
            on_start = function(context)
                open_block(context, {Slot.PF_BLOCK_4_D_VEX_BLOCK, Slot.PF_BLOCK_4_D_LASER_IN,
                    Slot.PF_BLOCK_4_D_LASER_OUT, Slot.PF_BLOCK_4_D_SHIELD})
            end,
            ends = {clear = "cannon_golem"}},
        {id = "cannon", directive = Directive.ENTER_THE_SPIRE, navpoint = Slot.AP_TO_MACHINE,
            on_start = function(context)
                move(context, {Slot.PF_CANNON_GOLEM_D_LASER, Slot.PF_CANNON_GOLEM_D_SHIELD},
                    "close")
                context:activate_objects{slots = {Slot.O_MAIN_CANNON}, active = true}
            end,
            ends = {trigger = Slot.PT_MAIN_CANNON}},
        -- "Arc energy." The Spire is entered from the cannon.
        {id = "spire_entry", directive = Directive.ENTER_THE_SPIRE, navpoint = Slot.AP_TO_MACHINE,
            lines = {line(cue.CUE_12)},
            ends = {region = "spire"}},
        {id = "climb", directive = Directive.CLIMB,
            on_start = function(context)
                move(context, {Slot.D_TOWER_LASER}, "open")
                move(context, {Slot.D_MANCANNON_0_80F54A8E, Slot.D_MANCANNON_1_80F54A8E,
                    Slot.D_MANCANNON_2_80F54A8E, Slot.D_MANCANNON_3_80F54A8E}, "open")
            end,
            ends = {trigger = {Slot.PT_MID, Slot.PT_SECOND_FLOOR, Slot.PT_THIRD_FLOOR,
                Slot.PT_MANCANNON2}}},
        -- The Spire Minotaur holds the last cube on the climb.
        {id = "middle", directive = Directive.CLIMB, navpoint = Slot.AP_LENS_GOLEM,
            scene = Scene.PF_TOWER_GOLEM_SN_GOLEM,
            ends = {clear = "tower_golem"}},
        {id = "tower_block",
            on_start = function(context)
                move(context, {Slot.PF_TOWER_GOLEM_D_LASER, Slot.PF_TOWER_GOLEM_D_SHIELD}, "close")
            end,
            ends = {destroyed = {Slot.PF_TOWER_BLOCK_O_VEX_LENS}}},
        -- The arena opens with Dendron already on his platform.
        {id = "top", directive = Directive.CLIMB, navpoint = Slot.AP_LENS_GOLEM,
            on_start = function(context)
                open_block(context, {Slot.PF_TOWER_BLOCK_D_VEX_BLOCK,
                    Slot.PF_TOWER_BLOCK_D_LASER_IN, Slot.PF_TOWER_BLOCK_D_LASER_OUT,
                    Slot.PF_TOWER_BLOCK_D_SHIELD})
                move(context, {Slot.BOSS_PLATFORM_D}, "close")
                move(context, {Slot.D_LASER_MAIN, Slot.D_MAIN_LENS}, "open")
                context:activate_objects{slots = {Slot.BOSS_PLATFORM_O_LOOP, Slot.O_MAIN_LENS},
                    active = true}
            end,
            ends = {trigger = Slot.PT_TOP}},
        {id = "arena", directive = Directive.SABOTAGE_VEX_SECURITY_PROTOCOLS_82271EEA,
            scene = Scene.SN_CYCLOPS_INTRO,
            barrier = true, ends = {scene = Slot.SN_CYCLOPS_INTRO}},
        {id = "lens", barrier = true, ends = {destroyed = {Slot.O_MAIN_LENS}}},
        -- "The power is cut." The Spire lasers go down and the fight starts.
        {id = "adds", directive = Directive.OVERCOME_THE_VEX_665C1E1C,
            lines = {line(cue.CUE_13)},
            on_start = function(context)
                move(context, {Slot.D_LASER_MAIN, Slot.D_TOWER_LASER}, "close")
            end,
            -- Dendron raises his first shield at two thirds health. The client reports
            -- that fraction on his type-2 Sense, so no client read is needed.
            barrier = true,
            ends = {clear = "arena_adds", health = {slot = Slot.SQ_BOSS_BOND, at = 2 / 3}}},
        {id = "shield1", directive = Directive.OVERCOME_THE_VEX_665C1E1C,
            scene = Scene.PF_GOLEM_0_SN_GOLEM,
            on_start = function(context)
                move(context, {Slot.D_LASER_GOLEM1}, "open")
            end,
            barrier = true,
            ends = {clear = "shield1", health = {slot = Slot.SQ_BOSS_BOND, at = 1 / 3}}},
        {id = "shield2", directive = Directive.OVERCOME_THE_VEX_665C1E1C,
            scene = Scene.PF_GOLEM_2_SN_GOLEM,
            on_start = function(context)
                move(context, {Slot.D_LASER_GOLEM1}, "close")
                move(context, {Slot.D_LASER_GOLEM2}, "open")
            end,
            barrier = true, ends = {clear = "shield2"}},
        {id = "final", directive = Directive.OVERCOME_THE_VEX_665C1E1C,
            on_start = function(context)
                move(context, {Slot.D_LASER_GOLEM2}, "close")
            end,
            barrier = true, ends = {clear = "dendron"}},
        -- The chest opens where Dendron fell.
        {id = "reward", lines = {line(cue.CUE_14)},
            on_start = function(context)
                context:activate_objects{slots = {Slot.PF_BOSS_CHEST_O_CHEST}, active = true}
            end},
    },
    encounters = {
        lighthouse, forest_exit, arrival, modules, terrace, terrace_golem,
        gate1, gate2, cannon_guards, tower_guards, cannon_golem,
        spire_lower, spire_mid, tower_golem, spire_top, dendron,
        arena_adds, shield1, shield1_adds, shield2, shield2_adds,
    },
}

