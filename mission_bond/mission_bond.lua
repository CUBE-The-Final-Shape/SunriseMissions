-- A Garden World. Native mission logic; live play remains unverified.
-- Absent: lens vulnerability, golem release inputs, boss motion and shield ownership.
-- The Panoptes ending is partial and cannot complete the mission.
local missions = require("missions")
local mission = require(missions.MISSION_BOND)
local campaign = require("lib.campaign")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive, Scene = mission.Slot, mission.Squad, mission.Directive, mission.Scene
local cue = mission.DialogueCue.M_DIALOG_SENSOR_80F474CC

local function block(prefix)
    return {
        objects = {Slot[prefix .. "_O_VEX_LENS"], Slot[prefix .. "_O_WRAPPER"],
            Slot[prefix .. "_O_VEX_BLOCK"]},
        devices = {Slot[prefix .. "_D_VEX_LENS"], Slot[prefix .. "_D_VEX_BLOCK"],
            Slot[prefix .. "_D_LASER_IN"], Slot[prefix .. "_D_LASER_OUT"],
            Slot[prefix .. "_D_SHIELD"]},
    }
end

local function golem(prefix)
    return {
        objects = {Slot[prefix .. "_O_LENS"], Slot[prefix .. "_O_WRAPPER"]},
        devices = {Slot[prefix .. "_D_LENS"], Slot[prefix .. "_D_LASER"],
            Slot[prefix .. "_D_SHIELD"]},
    }
end

local blocks = {block("PF_BLOCK_0"), block("PF_BLOCK_1"), block("PF_BLOCK_2"),
    block("PF_BLOCK_3"), block("PF_BLOCK_4"), block("PF_TOWER_BLOCK")}
local golems = {golem("PF_TERRACE_GOLEM"), golem("PF_CANNON_GOLEM"),
    golem("PF_TOWER_GOLEM"), golem("PF_GOLEM_0"), golem("PF_GOLEM_1"),
    golem("PF_GOLEM_2"), golem("PF_GOLEM_3")}

local function prepare(context, group)
    context:activate_objects{slots = group.objects, active = true}
    move(context, group.devices, "open")
end

local omit = {Slot.BOSS_PLATFORM_O_LOOP, Slot.O_MAIN_LENS, Slot.LIGHTHOUSE_TELEPORT,
    Slot.O_CANNON, Slot.O_MAIN_CANNON}
for _, groups in ipairs({blocks, golems}) do
    for _, group in ipairs(groups) do
        for _, object in ipairs(group.objects) do omit[#omit + 1] = object end
    end
end

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

local forest_exit = {
    id = "forest_exit",
    after = "forest",
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

local dendron = {
    id = "dendron",
    on_start = function(context)
        context:slot(Slot.SQ_BOSS_BOND):bind_combatant_to_squad()
    end,
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
    after = "second_phase",
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
local closing = {
    id = "closing",
    after = "closing",
    squads = {
        unit(Squad.OSIRIS_ECHO_FRONT_SQUAD, Slot.OSIRIS_ECHO_FRONT_SQUAD),
        unit(Squad.OSIRIS_ECHO_BACK_SQUAD, Slot.OSIRIS_ECHO_BACK_SQUAD),
        unit(Squad.PANOPTES_SQUAD, Slot.PANOPTES_SQUAD),
    },
}
local function open_block(context, slots)
    move(context, slots, "close")
end

return campaign.new{
    key = "bondmission",
    complete = false,
    omit = omit,
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80F474CC,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80F474CC,
    legs = {
        {id = "lighthouse", state = mission.states.STATE_80F47445_000F_0000_80F47440,
            arm = {Slot.PT_SPAWN_CABAL}},
        {id = "forest", state = mission.states.STATE_80F47445_000A_0000_80F4743B,
            arm = {Slot.PT_BEGIN, Slot.PT_END, Slot.PT_FAR}},
        {id = "past", state = mission.states.STATE_80F47445_0001_0000_80F47430,
            arm = {Slot.PT_LOWER_CANNON, Slot.PT_UPPER_PLATFORM, Slot.PT_TERRACE_STEPS,
                Slot.PT_TERRACE_FAR, Slot.PT_GATES, Slot.PT_GATE_RAMP, Slot.PT_GATES_UPPER,
                Slot.PT_MAIN_CANNON, Slot.PT_DIALOG_GOLEM},
            watch = {Slot.PM_MACHINE}},
        {id = "spire", state = mission.states.STATE_80F47445_0011_0000_80F47442,
            arm = {Slot.PT_ENTRY, Slot.PT_MID, Slot.PT_SECOND_FLOOR, Slot.PT_THIRD_FLOOR,
                Slot.PT_MANCANNON2, Slot.PT_TOP, Slot.MACHINE_TOP_ENTRY_PLAYER_TRIGGER}},
    },
    steps = {
        {id = "briefing", directive = Directive.ENTER_THE_INFINITE_FOREST,
            lines = {line(cue.CUE_0)},
            on_start = function(context)
                context:activate_objects{slots = {Slot.LIGHTHOUSE_TELEPORT}, active = true}
            end,
            ends = {region = "forest"}},
        {id = "forest", directive = Directive.SEARCH_FOR_A_GATEWAY_TO_THE_PAST,
            lines = {line(cue.CUE_1)},
            on_start = function(context)
                context:slot(Slot.MAP_GENERATOR_SENSOR_80F5460E):generate_map{
                    seed = campaign.run_seed(context), enabled = true}
            end,
            ends = {trigger = {Slot.PT_END, Slot.PT_FAR}}},
        {id = "gate", directive = Directive.ENTER_THE_PAST, lines = {line(cue.CUE_2)},
            ends = {region = "past"}},
        {id = "past_arrival", directive = Directive.ENTER_THE_SPIRE_2D67AB51,
            lines = {line(cue.CUE_3)},
            on_start = function(context)
                move(context, {Slot.D_MANCANNON_0_80F54563, Slot.D_MANCANNON_1_80F54563,
                    Slot.D_MANCANNON_2_80F54563, Slot.D_MANCANNON_3_80F54563}, "open")
                context:activate_objects{slots = {Slot.O_CANNON}, active = true}
            end,
            ends = {trigger = Slot.PT_LOWER_CANNON}},
        {id = "radiolaria", directive = Directive.SABOTAGE_VEX_SECURITY_PROTOCOLS_82271EEA,
            ends = {trigger = Slot.PT_UPPER_PLATFORM}},
        {id = "countermeasures", lines = {line(cue.CUE_4)}, barrier = true,
            on_start = function(context) prepare(context, blocks[1]) end,
            ends = {destroyed = {Slot.PF_BLOCK_0_O_VEX_LENS}}},
        {id = "first_block",
            on_start = function(context)
                open_block(context, {Slot.PF_BLOCK_0_D_VEX_BLOCK, Slot.PF_BLOCK_0_D_LASER_IN,
                    Slot.PF_BLOCK_0_D_LASER_OUT, Slot.PF_BLOCK_0_D_SHIELD})
            end,
            ends = {trigger = {Slot.PT_TERRACE_STEPS, Slot.PT_TERRACE_FAR}}},
        {id = "terrace_platform", barrier = true,
            on_start = function(context) prepare(context, blocks[2]) end,
            ends = {destroyed = {Slot.PF_BLOCK_1_O_VEX_LENS}}},
        {id = "terrace", directive = Directive.ENTER_THE_SPIRE_6D15E881,
            navpoint = Slot.AP_TERRACE_GOLEM_LENS,
            scene = Scene.PF_TERRACE_GOLEM_SN_GOLEM,
            on_start = function(context)
                open_block(context, {Slot.PF_BLOCK_1_D_VEX_BLOCK, Slot.PF_BLOCK_1_D_LASER_IN,
                    Slot.PF_BLOCK_1_D_LASER_OUT, Slot.PF_BLOCK_1_D_SHIELD})
                prepare(context, golems[1])
            end,
            barrier = true, ends = {destroyed = {Slot.PF_TERRACE_GOLEM_O_LENS}}},
        {id = "terrace_clear", barrier = true,
            on_start = function(context)
                move(context, {Slot.PF_TERRACE_GOLEM_D_LASER,
                    Slot.PF_TERRACE_GOLEM_D_SHIELD}, "close")
            end,
            ends = {clear = "terrace_golem"}},
        {id = "terrace_block",
            on_start = function(context) prepare(context, blocks[3]) end,
            barrier = true, ends = {destroyed = {Slot.PF_BLOCK_2_O_VEX_LENS}}},
        {id = "corridor", directive = Directive.SABOTAGE_VEX_SECURITY_PROTOCOLS,
            on_start = function(context)
                open_block(context, {Slot.PF_BLOCK_1_D_VEX_BLOCK, Slot.PF_BLOCK_1_D_LASER_IN,
                    Slot.PF_BLOCK_1_D_LASER_OUT, Slot.PF_BLOCK_1_D_SHIELD,
                    Slot.PF_BLOCK_2_D_VEX_BLOCK, Slot.PF_BLOCK_2_D_LASER_IN,
                    Slot.PF_BLOCK_2_D_LASER_OUT, Slot.PF_BLOCK_2_D_SHIELD})
            end,
            ends = {trigger = {Slot.PT_GATES, Slot.PT_GATE_RAMP, Slot.PT_GATES_UPPER}}},
        {id = "gates", barrier = true,
            on_start = function(context) prepare(context, blocks[4]) end,
            ends = {destroyed = {Slot.PF_BLOCK_3_O_VEX_LENS}}},
        {id = "gate2",
            on_start = function(context)
                open_block(context, {Slot.PF_BLOCK_3_D_VEX_BLOCK, Slot.PF_BLOCK_3_D_LASER_IN,
                    Slot.PF_BLOCK_3_D_LASER_OUT, Slot.PF_BLOCK_3_D_SHIELD})
            end,
            ends = {}},
        {id = "cannon_golem", scene = Scene.PF_CANNON_GOLEM_SN_GOLEM,
            on_start = function(context) prepare(context, golems[2]) end,
            barrier = true, ends = {destroyed = {Slot.PF_CANNON_GOLEM_O_LENS}}},
        {id = "cannon_clear", barrier = true,
            on_start = function(context)
                move(context, {Slot.PF_CANNON_GOLEM_D_LASER,
                    Slot.PF_CANNON_GOLEM_D_SHIELD}, "close")
            end,
            ends = {clear = "cannon_golem"}},
        {id = "last_block", barrier = true,
            on_start = function(context) prepare(context, blocks[5]) end,
            ends = {destroyed = {Slot.PF_BLOCK_4_O_VEX_LENS}}},
        {id = "cannon", directive = Directive.ENTER_THE_SPIRE, navpoint = Slot.AP_TO_MACHINE,
            on_start = function(context)
                move(context, {Slot.PF_CANNON_GOLEM_D_LASER, Slot.PF_CANNON_GOLEM_D_SHIELD},
                    "close")
                open_block(context, {Slot.PF_BLOCK_4_D_VEX_BLOCK, Slot.PF_BLOCK_4_D_LASER_IN,
                    Slot.PF_BLOCK_4_D_LASER_OUT, Slot.PF_BLOCK_4_D_SHIELD})
                context:activate_objects{slots = {Slot.O_MAIN_CANNON}, active = true}
            end,
            ends = {trigger = Slot.PT_MAIN_CANNON}},
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
        {id = "middle", directive = Directive.CLIMB, navpoint = Slot.AP_LENS_GOLEM,
            scene = Scene.PF_TOWER_GOLEM_SN_GOLEM,
            on_start = function(context) prepare(context, golems[3]) end,
            barrier = true, ends = {destroyed = {Slot.PF_TOWER_GOLEM_O_LENS}}},
        {id = "tower_clear", barrier = true,
            on_start = function(context)
                move(context, {Slot.PF_TOWER_GOLEM_D_LASER,
                    Slot.PF_TOWER_GOLEM_D_SHIELD}, "close")
            end,
            ends = {clear = "tower_golem"}},
        {id = "tower_block",
            on_start = function(context)
                prepare(context, blocks[6])
            end,
            barrier = true, ends = {destroyed = {Slot.PF_TOWER_BLOCK_O_VEX_LENS}}},
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
            ends = {}},
        {id = "lens", barrier = true, ends = {destroyed = {Slot.O_MAIN_LENS}}},
        {id = "adds", directive = Directive.OVERCOME_THE_VEX_665C1E1C,
            lines = {line(cue.CUE_13)},
            on_start = function(context)
                move(context, {Slot.D_LASER_MAIN, Slot.D_TOWER_LASER}, "close")
            end,
            barrier = true,
            ends = {health = {slot = Slot.SQ_BOSS_BOND, at = 2 / 3}}},
        {id = "shield1", directive = Directive.OVERCOME_THE_VEX_665C1E1C,
            scene = Scene.PF_GOLEM_0_SN_GOLEM,
            on_start = function(context)
                prepare(context, golems[4])
                prepare(context, golems[5])
                context:scene(Scene.PF_GOLEM_1_SN_GOLEM):activate{}
                move(context, {Slot.D_LASER_GOLEM1}, "open")
            end,
            barrier = true,
            ends = {destroyed = {Slot.PF_GOLEM_0_O_LENS, Slot.PF_GOLEM_1_O_LENS}}},
        {id = "shield1_clear", barrier = true,
            on_start = function(context)
                move(context, {Slot.PF_GOLEM_0_D_LASER, Slot.PF_GOLEM_0_D_SHIELD,
                    Slot.PF_GOLEM_1_D_LASER, Slot.PF_GOLEM_1_D_SHIELD}, "close")
            end,
            ends = {clear = "shield1"}},
        {id = "second_phase", barrier = true,
            on_start = function(context) move(context, {Slot.D_LASER_GOLEM1}, "close") end,
            ends = {health = {slot = Slot.SQ_BOSS_BOND, at = 1 / 3}}},
        {id = "shield2", directive = Directive.OVERCOME_THE_VEX_665C1E1C,
            scene = Scene.PF_GOLEM_2_SN_GOLEM,
            on_start = function(context)
                prepare(context, golems[6])
                prepare(context, golems[7])
                context:scene(Scene.PF_GOLEM_3_SN_GOLEM):activate{}
                move(context, {Slot.D_LASER_GOLEM2}, "open")
            end,
            barrier = true,
            ends = {destroyed = {Slot.PF_GOLEM_2_O_LENS, Slot.PF_GOLEM_3_O_LENS}}},
        {id = "shield2_clear", barrier = true,
            on_start = function(context)
                move(context, {Slot.PF_GOLEM_2_D_LASER, Slot.PF_GOLEM_2_D_SHIELD,
                    Slot.PF_GOLEM_3_D_LASER, Slot.PF_GOLEM_3_D_SHIELD}, "close")
            end,
            ends = {clear = "shield2"}},
        {id = "final", directive = Directive.OVERCOME_THE_VEX_665C1E1C,
            on_start = function(context) move(context, {Slot.D_LASER_GOLEM2}, "close") end,
            barrier = true, ends = {health = {slot = Slot.SQ_BOSS_BOND, at = 0}}},
        {id = "access", directive = Directive.LOCATE_PANOPTES,
            lines = {line(cue.CUE_14)},
            on_start = function(context)
                move(context, {Slot.SAFETY_PLATFORM_CENTER_DEVICE,
                    Slot.SAFETY_PLATFORM_ENTRY_DEVICE, Slot.MACHINE_STEP_01_LEFT_DEVICE,
                    Slot.MACHINE_STEP_01_RIGHT_DEVICE, Slot.MACHINE_STEP_02_LEFT_DEVICE,
                    Slot.MACHINE_STEP_02_RIGHT_DEVICE, Slot.MACHINE_STEP_03_LEFT_DEVICE,
                    Slot.MACHINE_STEP_03_RIGHT_DEVICE, Slot.MACHINE_STEP_04_DEVICE,
                    Slot.GHOST_INTERACT_SENSOR}, "open")
                context:activate_objects{slots = {Slot.MANCANNON_PUSH_OBJECT,
                    Slot.VEX_PROBABILITY_TREE_OBJECT, Slot.SAGIRA_FX_PROP}, active = true}
            end,
            ends = {trigger = Slot.MACHINE_TOP_ENTRY_PLAYER_TRIGGER}},
        {id = "closing", scene = Scene.OSIRIS_ECHO_SCENE,
            barrier = true, ends = {ghost_link = Slot.CLOSING_INTERACT_GHOST_LINK}},
        {id = "panoptes", scene = Scene.SAGIRA_FX_PROP_SCENE,
            on_start = function(context)
                move(context, {Slot.VEX_PROBABILITY_TREE_DEVICE}, "open")
            end,
            barrier = true, ends = {scene = Slot.OSIRIS_ECHO_SCENE}},
    },
    encounters = {
        lighthouse, forest_exit, arrival, modules, terrace, terrace_golem,
        gate1, gate2, cannon_guards, tower_guards, cannon_golem,
        spire_lower, spire_mid, tower_golem, spire_top, dendron,
        arena_adds, shield1, shield1_adds, shield2, shield2_adds, closing,
    },
}
