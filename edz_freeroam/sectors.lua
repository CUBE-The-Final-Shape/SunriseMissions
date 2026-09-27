-- Lost Sector encounter choices; live parity remains unverified.
return function(mission, freeroam)
    local Slot, Squad = mission.Slot, mission.Squad
    local unit = freeroam.unit
    return {
        -- The Drain.
        [32] = {
            boss = Slot.SQ_COURTYARD_BOSS,
            chest = {Slot.REGION_CHEST_MAJOR1_80BE3307},
            squads = {
                unit(Squad.SQ_COURTYARD_1, Slot.SQ_COURTYARD_1, {
                    counts = {3},
                    objective = Slot.OBJ_COURTYARD,
                    group = mission.TaskGroup.OBJ_COURTYARD.GROUP_0,
                }),
                unit(Squad.SQ_COURTYARD_2, Slot.SQ_COURTYARD_2, {
                    counts = {1, 2},
                    objective = Slot.OBJ_COURTYARD,
                    group = mission.TaskGroup.OBJ_COURTYARD.GROUP_0,
                }),
                unit(Squad.SQ_COURTYARD_3, Slot.SQ_COURTYARD_3, {
                    counts = {2},
                    objective = Slot.OBJ_COURTYARD,
                    group = mission.TaskGroup.OBJ_COURTYARD.GROUP_0,
                }),
                unit(Squad.SQ_COURTYARD_4, Slot.SQ_COURTYARD_4, {
                    counts = {4, 2},
                    objective = Slot.OBJ_COURTYARD,
                    group = mission.TaskGroup.OBJ_COURTYARD.GROUP_0,
                }),
                unit(Squad.SQ_COURTYARD_BOSS, Slot.SQ_COURTYARD_BOSS, {
                    counts = {1},
                    objective = Slot.OBJ_COURTYARD,
                    group = mission.TaskGroup.OBJ_COURTYARD.GROUP_0,
                    member = Slot.SQ_COURTYARD_BOSS_BOSS,
                }),
                unit(Squad.SQ_COURTYARD_NIGHTMARES, Slot.SQ_COURTYARD_NIGHTMARES, {
                    counts = {1},
                    objective = Slot.OBJ_COURTYARD,
                    group = mission.TaskGroup.OBJ_COURTYARD.GROUP_0,
                }),
            },
        },
        -- Whispered Falls.
        [40] = {
            boss = Slot.SQ_STATION_BOSS,
            chest = {Slot.REGION_CHEST_MAJOR2_80BE33A0},
            squads = {
                unit(Squad.SQ_STATION_BOT_1, Slot.SQ_STATION_BOT_1, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE337C,
                    group = mission.TaskGroup.OBJ_ALL_80BE337C.GROUP_0,
                }),
                unit(Squad.SQ_STATION_BOT_2, Slot.SQ_STATION_BOT_2, {
                    counts = {3, 2},
                    objective = Slot.OBJ_ALL_80BE337C,
                    group = mission.TaskGroup.OBJ_ALL_80BE337C.GROUP_0,
                }),
                unit(Squad.SQ_STATION_BOT_3, Slot.SQ_STATION_BOT_3, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE337C,
                    group = mission.TaskGroup.OBJ_ALL_80BE337C.GROUP_0,
                }),
                unit(Squad.SQ_STATION_BOT_7, Slot.SQ_STATION_BOT_7, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE337C,
                    group = mission.TaskGroup.OBJ_ALL_80BE337C.GROUP_0,
                }),
                unit(Squad.SQ_STATION_BOT_4, Slot.SQ_STATION_BOT_4, {
                    counts = {4, 3},
                    objective = Slot.OBJ_ALL_80BE337C,
                    group = mission.TaskGroup.OBJ_ALL_80BE337C.GROUP_0,
                }),
                unit(Squad.SQ_STATION_BOT_5, Slot.SQ_STATION_BOT_5, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE337C,
                    group = mission.TaskGroup.OBJ_ALL_80BE337C.GROUP_0,
                }),
                unit(Squad.SQ_STATION_BOT_6, Slot.SQ_STATION_BOT_6, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BE337C,
                    group = mission.TaskGroup.OBJ_ALL_80BE337C.GROUP_0,
                }),
                unit(Squad.SQ_STATION_BOT_8, Slot.SQ_STATION_BOT_8, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE337C,
                    group = mission.TaskGroup.OBJ_ALL_80BE337C.GROUP_0,
                }),
                unit(Squad.SQ_STATION_BOT_9, Slot.SQ_STATION_BOT_9, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BE337C,
                    group = mission.TaskGroup.OBJ_ALL_80BE337C.GROUP_0,
                }),
                unit(Squad.SQ_STATION_BOT_10, Slot.SQ_STATION_BOT_10, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE337C,
                    group = mission.TaskGroup.OBJ_ALL_80BE337C.GROUP_0,
                }),
                unit(Squad.SQ_STATION_TOP_1, Slot.SQ_STATION_TOP_1, {
                    counts = {2, 3},
                    objective = Slot.OBJ_ALL_80BE337C,
                    group = mission.TaskGroup.OBJ_ALL_80BE337C.GROUP_0,
                }),
                unit(Squad.SQ_STATION_TOP_2, Slot.SQ_STATION_TOP_2, {
                    counts = {4, 3},
                    objective = Slot.OBJ_ALL_80BE337C,
                    group = mission.TaskGroup.OBJ_ALL_80BE337C.GROUP_0,
                }),
                unit(Squad.SQ_STATION_BOSS, Slot.SQ_STATION_BOSS, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE337C,
                    group = mission.TaskGroup.OBJ_ALL_80BE337C.GROUP_0,
                    member = Slot.SQ_STATION_BOSS_BOSS,
                }),
                unit(Squad.SQ_STATION_NIGHTMARES, Slot.SQ_STATION_NIGHTMARES, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE337C,
                    group = mission.TaskGroup.OBJ_ALL_80BE337C.GROUP_0,
                }),
            },
        },
        -- Scavenger's Den.
        [48] = {
            boss = Slot.SQ_RUINS_BOSS,
            chest = {Slot.REGION_CHEST_MAJOR3_80BE376B},
            squads = {
                unit(Squad.SQ_RUINS_BOSS, Slot.SQ_RUINS_BOSS, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE360A,
                    group = mission.TaskGroup.OBJ_ALL_80BE360A.GROUP_0,
                    member = Slot.SQ_RUINS_BOSS_BOSS,
                }),
                unit(Squad.SQ_RUINS_WAVE1_A, Slot.SQ_RUINS_WAVE1_A, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE360A,
                    group = mission.TaskGroup.OBJ_ALL_80BE360A.GROUP_0,
                }),
                unit(Squad.SQ_RUINS_WAVE1_B, Slot.SQ_RUINS_WAVE1_B, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BE360A,
                    group = mission.TaskGroup.OBJ_ALL_80BE360A.GROUP_0,
                }),
                unit(Squad.SQ_RUINS_WAVE1_C, Slot.SQ_RUINS_WAVE1_C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BE360A,
                    group = mission.TaskGroup.OBJ_ALL_80BE360A.GROUP_0,
                }),
                unit(Squad.SQ_RUINS_WAVE1_D, Slot.SQ_RUINS_WAVE1_D, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE360A,
                    group = mission.TaskGroup.OBJ_ALL_80BE360A.GROUP_0,
                }),
                unit(Squad.SQ_RUINS_WAVE1_E, Slot.SQ_RUINS_WAVE1_E, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE360A,
                    group = mission.TaskGroup.OBJ_ALL_80BE360A.GROUP_0,
                }),
                unit(Squad.SQ_RUINS_WAVE2_A, Slot.SQ_RUINS_WAVE2_A, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE360A,
                    group = mission.TaskGroup.OBJ_ALL_80BE360A.GROUP_0,
                }),
                unit(Squad.SQ_RUINS_WAVE2_B, Slot.SQ_RUINS_WAVE2_B, {
                    counts = {3, 3},
                    objective = Slot.OBJ_ALL_80BE360A,
                    group = mission.TaskGroup.OBJ_ALL_80BE360A.GROUP_0,
                }),
                unit(Squad.SQ_RUINS_WAVE2_C, Slot.SQ_RUINS_WAVE2_C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BE360A,
                    group = mission.TaskGroup.OBJ_ALL_80BE360A.GROUP_0,
                }),
                unit(Squad.SQ_RUINS_WAVE3_A, Slot.SQ_RUINS_WAVE3_A, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE360A,
                    group = mission.TaskGroup.OBJ_ALL_80BE360A.GROUP_0,
                }),
                unit(Squad.SQ_RUINS_WAVE3_B, Slot.SQ_RUINS_WAVE3_B, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BE360A,
                    group = mission.TaskGroup.OBJ_ALL_80BE360A.GROUP_0,
                }),
                unit(Squad.SQ_RUINS_WAVE3_C, Slot.SQ_RUINS_WAVE3_C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BE360A,
                    group = mission.TaskGroup.OBJ_ALL_80BE360A.GROUP_0,
                }),
                unit(Squad.SQ_RUINS_WAVE3_D, Slot.SQ_RUINS_WAVE3_D, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE360A,
                    group = mission.TaskGroup.OBJ_ALL_80BE360A.GROUP_0,
                }),
                unit(Squad.SQ_RUINS_WAVE3_E, Slot.SQ_RUINS_WAVE3_E, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE360A,
                    group = mission.TaskGroup.OBJ_ALL_80BE360A.GROUP_0,
                }),
            },
        },
        -- Flooded Chasm.
        [88] = {
            boss = Slot.SQ_CHAMBER_BOSS_80BE471B,
            chest = {Slot.REGION_CHEST_MAJOR1_80BE4A10},
            squads = {
                unit(Squad.SQ_CHAMBER_BOSS_80BE471B, Slot.SQ_CHAMBER_BOSS_80BE471B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE471B,
                    group = mission.TaskGroup.OBJ_ALL_80BE471B.GROUP_0,
                    member = Slot.SQ_CHAMBER_BOSS_BOSS_80BE471B,
                }),
                unit(Squad.SQ_NIGHTMARES_80BE471B, Slot.SQ_NIGHTMARES_80BE471B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE471B,
                    group = mission.TaskGroup.OBJ_ALL_80BE471B.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_BOSS_GUARDS, Slot.SQ_CHAMBER_BOSS_GUARDS, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BE471B,
                    group = mission.TaskGroup.OBJ_ALL_80BE471B.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_WAVE1_A, Slot.SQ_CHAMBER_WAVE1_A, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE471B,
                    group = mission.TaskGroup.OBJ_ALL_80BE471B.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_WAVE1_B, Slot.SQ_CHAMBER_WAVE1_B, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE471B,
                    group = mission.TaskGroup.OBJ_ALL_80BE471B.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_WAVE1_C, Slot.SQ_CHAMBER_WAVE1_C, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE471B,
                    group = mission.TaskGroup.OBJ_ALL_80BE471B.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_WAVE1_D, Slot.SQ_CHAMBER_WAVE1_D, {
                    counts = {3, 1},
                    objective = Slot.OBJ_ALL_80BE471B,
                    group = mission.TaskGroup.OBJ_ALL_80BE471B.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_WAVE1_E, Slot.SQ_CHAMBER_WAVE1_E, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE471B,
                    group = mission.TaskGroup.OBJ_ALL_80BE471B.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_WAVE1_F, Slot.SQ_CHAMBER_WAVE1_F, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BE471B,
                    group = mission.TaskGroup.OBJ_ALL_80BE471B.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_WAVE1_G, Slot.SQ_CHAMBER_WAVE1_G, {
                    counts = {2, 2},
                    objective = Slot.OBJ_ALL_80BE471B,
                    group = mission.TaskGroup.OBJ_ALL_80BE471B.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_WAVE1_H, Slot.SQ_CHAMBER_WAVE1_H, {
                    counts = {4, 3},
                    objective = Slot.OBJ_ALL_80BE471B,
                    group = mission.TaskGroup.OBJ_ALL_80BE471B.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_WAVE1_I, Slot.SQ_CHAMBER_WAVE1_I, {
                    counts = {2, 2},
                    objective = Slot.OBJ_ALL_80BE471B,
                    group = mission.TaskGroup.OBJ_ALL_80BE471B.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_WAVE1_J, Slot.SQ_CHAMBER_WAVE1_J, {
                    counts = {3, 3},
                    objective = Slot.OBJ_ALL_80BE471B,
                    group = mission.TaskGroup.OBJ_ALL_80BE471B.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_WAVE2_A, Slot.SQ_CHAMBER_WAVE2_A, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE471B,
                    group = mission.TaskGroup.OBJ_ALL_80BE471B.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_WAVE2_B, Slot.SQ_CHAMBER_WAVE2_B, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE471B,
                    group = mission.TaskGroup.OBJ_ALL_80BE471B.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_WAVE2_C, Slot.SQ_CHAMBER_WAVE2_C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BE471B,
                    group = mission.TaskGroup.OBJ_ALL_80BE471B.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_WAVE2_D, Slot.SQ_CHAMBER_WAVE2_D, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE471B,
                    group = mission.TaskGroup.OBJ_ALL_80BE471B.GROUP_0,
                }),
            },
        },
        -- The Pit.
        [104] = {
            boss = Slot.SQ_BOSS_80BE625E,
            chest = {Slot.REGION_CHEST_MAJOR1_80BE626F},
            squads = {
                unit(Squad.SQ_FRONT_A_80BE625E, Slot.SQ_FRONT_A_80BE625E, {
                    counts = {2, 4},
                    objective = Slot.OBJ_ALL_80BE625E,
                    group = mission.TaskGroup.OBJ_ALL_80BE625E.GROUP_0,
                }),
                unit(Squad.SQ_LEFT_A, Slot.SQ_LEFT_A, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE625E,
                    group = mission.TaskGroup.OBJ_ALL_80BE625E.GROUP_0,
                }),
                unit(Squad.SQ_PIT_A, Slot.SQ_PIT_A, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE625E,
                    group = mission.TaskGroup.OBJ_ALL_80BE625E.GROUP_0,
                }),
                unit(Squad.SQ_PIT_B, Slot.SQ_PIT_B, {
                    counts = {5},
                    objective = Slot.OBJ_ALL_80BE625E,
                    group = mission.TaskGroup.OBJ_ALL_80BE625E.GROUP_0,
                }),
                unit(Squad.SQ_PIT_F, Slot.SQ_PIT_F, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BE625E,
                    group = mission.TaskGroup.OBJ_ALL_80BE625E.GROUP_0,
                }),
                unit(Squad.SQ_PIT_C, Slot.SQ_PIT_C, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE625E,
                    group = mission.TaskGroup.OBJ_ALL_80BE625E.GROUP_0,
                }),
                unit(Squad.SQ_PIT_D, Slot.SQ_PIT_D, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BE625E,
                    group = mission.TaskGroup.OBJ_ALL_80BE625E.GROUP_0,
                }),
                unit(Squad.SQ_PIT_E, Slot.SQ_PIT_E, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE625E,
                    group = mission.TaskGroup.OBJ_ALL_80BE625E.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_A_80BE625E, Slot.SQ_WAVE1_A_80BE625E, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE625E,
                    group = mission.TaskGroup.OBJ_ALL_80BE625E.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80BE625E, Slot.SQ_WAVE1_B_80BE625E, {
                    counts = {3, 4},
                    objective = Slot.OBJ_ALL_80BE625E,
                    group = mission.TaskGroup.OBJ_ALL_80BE625E.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80BE625E, Slot.SQ_WAVE1_C_80BE625E, {
                    counts = {1, 5},
                    objective = Slot.OBJ_ALL_80BE625E,
                    group = mission.TaskGroup.OBJ_ALL_80BE625E.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80BE625E, Slot.SQ_WAVE1_D_80BE625E, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE625E,
                    group = mission.TaskGroup.OBJ_ALL_80BE625E.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80BE625E, Slot.SQ_WAVE1_E_80BE625E, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE625E,
                    group = mission.TaskGroup.OBJ_ALL_80BE625E.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_F_80BE625E, Slot.SQ_WAVE1_F_80BE625E, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE625E,
                    group = mission.TaskGroup.OBJ_ALL_80BE625E.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_A_80BE625E, Slot.SQ_WAVE2_A_80BE625E, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE625E,
                    group = mission.TaskGroup.OBJ_ALL_80BE625E.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_B_80BE625E, Slot.SQ_WAVE2_B_80BE625E, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE625E,
                    group = mission.TaskGroup.OBJ_ALL_80BE625E.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_C_80BE625E, Slot.SQ_WAVE2_C_80BE625E, {
                    counts = {5},
                    objective = Slot.OBJ_ALL_80BE625E,
                    group = mission.TaskGroup.OBJ_ALL_80BE625E.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_A_80BE625E, Slot.SQ_WAVE3_A_80BE625E, {
                    counts = {6},
                    objective = Slot.OBJ_ALL_80BE625E,
                    group = mission.TaskGroup.OBJ_ALL_80BE625E.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_B_80BE625E, Slot.SQ_WAVE3_B_80BE625E, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BE625E,
                    group = mission.TaskGroup.OBJ_ALL_80BE625E.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80BE625E, Slot.SQ_BOSS_80BE625E, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE625E,
                    group = mission.TaskGroup.OBJ_ALL_80BE625E.GROUP_0,
                    member = Slot.SQ_BOSS_BOSS_80BE625E,
                }),
                unit(Squad.SQ_NIGHTMARES_80BE625E, Slot.SQ_NIGHTMARES_80BE625E, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE625E,
                    group = mission.TaskGroup.OBJ_ALL_80BE625E.GROUP_0,
                }),
            },
        },
        -- Excavation Site XII.
        [112] = {
            boss = Slot.SQ_BOSS_80BE628F,
            chest = {Slot.REGION_CHEST_MAJOR2_80BE631C},
            squads = {
                unit(Squad.SQ_INITIAL_1, Slot.SQ_INITIAL_1, {
                    counts = {6, 1},
                    objective = Slot.OBJ_ALL_80BE628F,
                    group = mission.TaskGroup.OBJ_ALL_80BE628F.GROUP_0,
                }),
                unit(Squad.SQ_INITIAL_2, Slot.SQ_INITIAL_2, {
                    counts = {5},
                    objective = Slot.OBJ_ALL_80BE628F,
                    group = mission.TaskGroup.OBJ_ALL_80BE628F.GROUP_0,
                }),
                unit(Squad.SQ_INITIAL_3, Slot.SQ_INITIAL_3, {
                    counts = {1, 6},
                    objective = Slot.OBJ_ALL_80BE628F,
                    group = mission.TaskGroup.OBJ_ALL_80BE628F.GROUP_0,
                }),
                unit(Squad.SQ_INITIAL_4, Slot.SQ_INITIAL_4, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE628F,
                    group = mission.TaskGroup.OBJ_ALL_80BE628F.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80BE628F, Slot.SQ_BOSS_80BE628F, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE628F,
                    group = mission.TaskGroup.OBJ_ALL_80BE628F.GROUP_0,
                    member = Slot.SQ_BOSS_BOSS_80BE628F,
                }),
                unit(Squad.SQ_NIGHTMARES_80BE628F, Slot.SQ_NIGHTMARES_80BE628F, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE628F,
                    group = mission.TaskGroup.OBJ_ALL_80BE628F.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_A_80BE628F, Slot.SQ_WAVE1_A_80BE628F, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE628F,
                    group = mission.TaskGroup.OBJ_ALL_80BE628F.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80BE628F, Slot.SQ_WAVE1_B_80BE628F, {
                    counts = {6},
                    objective = Slot.OBJ_ALL_80BE628F,
                    group = mission.TaskGroup.OBJ_ALL_80BE628F.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80BE628F, Slot.SQ_WAVE1_C_80BE628F, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE628F,
                    group = mission.TaskGroup.OBJ_ALL_80BE628F.GROUP_0,
                }),
            },
        },
        -- Pathfinder's Crash.
        [120] = {
            boss = Slot.SQ_BOSS_80BE6408,
            chest = {Slot.REGION_CHEST_MAJOR3_80BE6419},
            squads = {
                unit(Squad.SQ_TUNNEL_A, Slot.SQ_TUNNEL_A, {
                    counts = {6},
                    objective = Slot.OBJ_ALL_80BE6408,
                    group = mission.TaskGroup.OBJ_ALL_80BE6408.GROUP_0,
                }),
                unit(Squad.SQ_TUNNEL_B, Slot.SQ_TUNNEL_B, {
                    counts = {4, 3},
                    objective = Slot.OBJ_ALL_80BE6408,
                    group = mission.TaskGroup.OBJ_ALL_80BE6408.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_A_80BE6408, Slot.SQ_WAVE1_A_80BE6408, {
                    counts = {4, 2},
                    objective = Slot.OBJ_ALL_80BE6408,
                    group = mission.TaskGroup.OBJ_ALL_80BE6408.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80BE6408, Slot.SQ_WAVE1_B_80BE6408, {
                    counts = {6},
                    objective = Slot.OBJ_ALL_80BE6408,
                    group = mission.TaskGroup.OBJ_ALL_80BE6408.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80BE6408, Slot.SQ_WAVE1_C_80BE6408, {
                    counts = {5, 3},
                    objective = Slot.OBJ_ALL_80BE6408,
                    group = mission.TaskGroup.OBJ_ALL_80BE6408.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80BE6408, Slot.SQ_WAVE1_D_80BE6408, {
                    counts = {3, 3},
                    objective = Slot.OBJ_ALL_80BE6408,
                    group = mission.TaskGroup.OBJ_ALL_80BE6408.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80BE6408, Slot.SQ_WAVE1_E_80BE6408, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE6408,
                    group = mission.TaskGroup.OBJ_ALL_80BE6408.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_F_80BE6408, Slot.SQ_WAVE1_F_80BE6408, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE6408,
                    group = mission.TaskGroup.OBJ_ALL_80BE6408.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_G, Slot.SQ_WAVE1_G, {
                    counts = {6},
                    objective = Slot.OBJ_ALL_80BE6408,
                    group = mission.TaskGroup.OBJ_ALL_80BE6408.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_H, Slot.SQ_WAVE1_H, {
                    counts = {5},
                    objective = Slot.OBJ_ALL_80BE6408,
                    group = mission.TaskGroup.OBJ_ALL_80BE6408.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_I, Slot.SQ_WAVE1_I, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE6408,
                    group = mission.TaskGroup.OBJ_ALL_80BE6408.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_A_80BE6408, Slot.SQ_WAVE2_A_80BE6408, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE6408,
                    group = mission.TaskGroup.OBJ_ALL_80BE6408.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_B_80BE6408, Slot.SQ_WAVE2_B_80BE6408, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE6408,
                    group = mission.TaskGroup.OBJ_ALL_80BE6408.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_C_80BE6408, Slot.SQ_WAVE2_C_80BE6408, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE6408,
                    group = mission.TaskGroup.OBJ_ALL_80BE6408.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_A_80BE6408, Slot.SQ_WAVE3_A_80BE6408, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE6408,
                    group = mission.TaskGroup.OBJ_ALL_80BE6408.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_B_80BE6408, Slot.SQ_WAVE3_B_80BE6408, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE6408,
                    group = mission.TaskGroup.OBJ_ALL_80BE6408.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_C, Slot.SQ_WAVE3_C, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE6408,
                    group = mission.TaskGroup.OBJ_ALL_80BE6408.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80BE6408, Slot.SQ_BOSS_80BE6408, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE6408,
                    group = mission.TaskGroup.OBJ_ALL_80BE6408.GROUP_0,
                    member = Slot.SQ_BOSS_BOSS_80BE6408,
                }),
                unit(Squad.SQ_NIGHTMARES_80BE6408, Slot.SQ_NIGHTMARES_80BE6408, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE6408,
                    group = mission.TaskGroup.OBJ_ALL_80BE6408.GROUP_0,
                }),
            },
        },
        -- The Weep.
        [288] = {
            boss = Slot.SQ_BOSS_80BE7A42,
            chest = {Slot.REGION_CHEST_MAJOR1_80BE7AC9},
            squads = {
                unit(Squad.SQ_MOUND_A, Slot.SQ_MOUND_A, {
                    counts = {4, 3},
                    objective = Slot.OBJ_ALL_80BE7A42,
                    group = mission.TaskGroup.OBJ_ALL_80BE7A42.GROUP_0,
                }),
                unit(Squad.SQ_MOUND_B, Slot.SQ_MOUND_B, {
                    counts = {4, 4},
                    objective = Slot.OBJ_ALL_80BE7A42,
                    group = mission.TaskGroup.OBJ_ALL_80BE7A42.GROUP_0,
                }),
                unit(Squad.SQ_MOUND_C, Slot.SQ_MOUND_C, {
                    counts = {3, 1},
                    objective = Slot.OBJ_ALL_80BE7A42,
                    group = mission.TaskGroup.OBJ_ALL_80BE7A42.GROUP_0,
                }),
                unit(Squad.SQ_MOUND_D, Slot.SQ_MOUND_D, {
                    counts = {4, 3},
                    objective = Slot.OBJ_ALL_80BE7A42,
                    group = mission.TaskGroup.OBJ_ALL_80BE7A42.GROUP_0,
                }),
                unit(Squad.SQ_MOUND_E, Slot.SQ_MOUND_E, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BE7A42,
                    group = mission.TaskGroup.OBJ_ALL_80BE7A42.GROUP_0,
                }),
                unit(Squad.SQ_MOUND_F, Slot.SQ_MOUND_F, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BE7A42,
                    group = mission.TaskGroup.OBJ_ALL_80BE7A42.GROUP_0,
                }),
                unit(Squad.SQ_MOUND_G, Slot.SQ_MOUND_G, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE7A42,
                    group = mission.TaskGroup.OBJ_ALL_80BE7A42.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80BE7A42, Slot.SQ_BOSS_80BE7A42, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE7A42,
                    group = mission.TaskGroup.OBJ_ALL_80BE7A42.GROUP_0,
                    member = Slot.SQ_BOSS_BOSS_80BE7A42,
                }),
                unit(Squad.SQ_NIGHTMARES_80BE7A42, Slot.SQ_NIGHTMARES_80BE7A42, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE7A42,
                    group = mission.TaskGroup.OBJ_ALL_80BE7A42.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_A_80BE7A42, Slot.SQ_WAVE1_A_80BE7A42, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE7A42,
                    group = mission.TaskGroup.OBJ_ALL_80BE7A42.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80BE7A42, Slot.SQ_WAVE1_B_80BE7A42, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE7A42,
                    group = mission.TaskGroup.OBJ_ALL_80BE7A42.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80BE7A42, Slot.SQ_WAVE1_C_80BE7A42, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80BE7A42,
                    group = mission.TaskGroup.OBJ_ALL_80BE7A42.GROUP_0,
                }),
            },
        },
        -- Skydock IV.
        [320] = {
            boss = Slot.SQ_ROOM_BOSS,
            chest = {Slot.REGION_CHEST_MAJOR1_80BE811F},
            squads = {
                unit(Squad.SQ_ROOM_BOSS, Slot.SQ_ROOM_BOSS, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE7D97,
                    group = mission.TaskGroup.OBJ_ALL_80BE7D97.GROUP_0,
                    member = Slot.SQ_ROOM_BOSS_BOSS,
                }),
                unit(Squad.SQ_NIGHTMARES_80BE7D97, Slot.SQ_NIGHTMARES_80BE7D97, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE7D97,
                    group = mission.TaskGroup.OBJ_ALL_80BE7D97.GROUP_0,
                }),
                unit(Squad.SQ_ROOM_CATWALK, Slot.SQ_ROOM_CATWALK, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE7D97,
                    group = mission.TaskGroup.OBJ_ALL_80BE7D97.GROUP_0,
                }),
                unit(Squad.SQ_ROOM_FRONT, Slot.SQ_ROOM_FRONT, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE7D97,
                    group = mission.TaskGroup.OBJ_ALL_80BE7D97.GROUP_0,
                }),
                unit(Squad.SQ_ROOM_MIDDLE_A, Slot.SQ_ROOM_MIDDLE_A, {
                    counts = {5},
                    objective = Slot.OBJ_ALL_80BE7D97,
                    group = mission.TaskGroup.OBJ_ALL_80BE7D97.GROUP_0,
                }),
                unit(Squad.SQ_ROOM_MIDDLE_B, Slot.SQ_ROOM_MIDDLE_B, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE7D97,
                    group = mission.TaskGroup.OBJ_ALL_80BE7D97.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_A_80BE7D97, Slot.SQ_WAVE2_A_80BE7D97, {
                    counts = {2, 4},
                    objective = Slot.OBJ_ALL_80BE7D97,
                    group = mission.TaskGroup.OBJ_ALL_80BE7D97.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_A_80BE7D97, Slot.SQ_WAVE3_A_80BE7D97, {
                    counts = {1, 6},
                    objective = Slot.OBJ_ALL_80BE7D97,
                    group = mission.TaskGroup.OBJ_ALL_80BE7D97.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_B_80BE7D97, Slot.SQ_WAVE3_B_80BE7D97, {
                    counts = {2, 4},
                    objective = Slot.OBJ_ALL_80BE7D97,
                    group = mission.TaskGroup.OBJ_ALL_80BE7D97.GROUP_0,
                }),
            },
        },
        -- The Quarry.
        [328] = {
            boss = Slot.SQ_COLLAPSE_BOSS,
            chest = {Slot.REGION_CHEST_MAJOR2_80BE8348},
            squads = {
                unit(Squad.SQ_COLLAPSE_LOWER_A, Slot.SQ_COLLAPSE_LOWER_A, {
                    counts = {3},
                    objective = Slot.OBJ_COLLAPSE,
                    group = mission.TaskGroup.OBJ_COLLAPSE.GROUP_0,
                }),
                unit(Squad.SQ_COLLAPSE_UPPER_A, Slot.SQ_COLLAPSE_UPPER_A, {
                    counts = {2},
                    objective = Slot.OBJ_COLLAPSE,
                    group = mission.TaskGroup.OBJ_COLLAPSE.GROUP_0,
                }),
                unit(Squad.SQ_COLLAPSE_LOWER_B, Slot.SQ_COLLAPSE_LOWER_B, {
                    counts = {6},
                    objective = Slot.OBJ_COLLAPSE,
                    group = mission.TaskGroup.OBJ_COLLAPSE.GROUP_0,
                }),
                unit(Squad.SQ_COLLAPSE_LOWER_C, Slot.SQ_COLLAPSE_LOWER_C, {
                    counts = {5},
                    objective = Slot.OBJ_COLLAPSE,
                    group = mission.TaskGroup.OBJ_COLLAPSE.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_A_80BE8256, Slot.SQ_WAVE2_A_80BE8256, {
                    counts = {6},
                    objective = Slot.OBJ_COLLAPSE,
                    group = mission.TaskGroup.OBJ_COLLAPSE.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_B_80BE8256, Slot.SQ_WAVE2_B_80BE8256, {
                    counts = {2},
                    objective = Slot.OBJ_COLLAPSE,
                    group = mission.TaskGroup.OBJ_COLLAPSE.GROUP_0,
                }),
                unit(Squad.SQ_COLLAPSE_BOSS, Slot.SQ_COLLAPSE_BOSS, {
                    counts = {1},
                    objective = Slot.OBJ_COLLAPSE,
                    group = mission.TaskGroup.OBJ_COLLAPSE.GROUP_0,
                    member = Slot.SQ_COLLAPSE_BOSS_BOSS,
                }),
                unit(Squad.SQ_NIGHTMARES_80BE8256, Slot.SQ_NIGHTMARES_80BE8256, {
                    counts = {1},
                    objective = Slot.OBJ_COLLAPSE,
                    group = mission.TaskGroup.OBJ_COLLAPSE.GROUP_0,
                }),
            },
        },
        -- Atrium.
        [416] = {
            boss = Slot.SQ_BOSS_80BE988B,
            chest = {Slot.REGION_CHEST_MAJOR1_80BE98A8},
            squads = {
                unit(Squad.SQ_ATRIUM_A, Slot.SQ_ATRIUM_A, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE988B,
                    group = mission.TaskGroup.OBJ_ALL_80BE988B.GROUP_0,
                }),
                unit(Squad.SQ_ATRIUM_B, Slot.SQ_ATRIUM_B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE988B,
                    group = mission.TaskGroup.OBJ_ALL_80BE988B.GROUP_0,
                }),
                unit(Squad.SQ_ATRIUM_C, Slot.SQ_ATRIUM_C, {
                    counts = {4, 4},
                    objective = Slot.OBJ_ALL_80BE988B,
                    group = mission.TaskGroup.OBJ_ALL_80BE988B.GROUP_0,
                }),
                unit(Squad.SQ_ATRIUM_D, Slot.SQ_ATRIUM_D, {
                    counts = {4, 2},
                    objective = Slot.OBJ_ALL_80BE988B,
                    group = mission.TaskGroup.OBJ_ALL_80BE988B.GROUP_0,
                }),
                unit(Squad.SQ_ATRIUM_E, Slot.SQ_ATRIUM_E, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE988B,
                    group = mission.TaskGroup.OBJ_ALL_80BE988B.GROUP_0,
                }),
                unit(Squad.SQ_ATRIUM_F, Slot.SQ_ATRIUM_F, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE988B,
                    group = mission.TaskGroup.OBJ_ALL_80BE988B.GROUP_0,
                }),
                unit(Squad.SQ_ATRIUM_G, Slot.SQ_ATRIUM_G, {
                    counts = {3, 3},
                    objective = Slot.OBJ_ALL_80BE988B,
                    group = mission.TaskGroup.OBJ_ALL_80BE988B.GROUP_0,
                }),
                unit(Squad.SQ_ATRIUM_H, Slot.SQ_ATRIUM_H, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE988B,
                    group = mission.TaskGroup.OBJ_ALL_80BE988B.GROUP_0,
                }),
                unit(Squad.SQ_ATRIUM_I, Slot.SQ_ATRIUM_I, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE988B,
                    group = mission.TaskGroup.OBJ_ALL_80BE988B.GROUP_0,
                }),
                unit(Squad.SQ_ATRIUM_J, Slot.SQ_ATRIUM_J, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BE988B,
                    group = mission.TaskGroup.OBJ_ALL_80BE988B.GROUP_0,
                }),
                unit(Squad.SQ_ATRIUM_K, Slot.SQ_ATRIUM_K, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE988B,
                    group = mission.TaskGroup.OBJ_ALL_80BE988B.GROUP_0,
                }),
                unit(Squad.SQ_ATRIUM_L, Slot.SQ_ATRIUM_L, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE988B,
                    group = mission.TaskGroup.OBJ_ALL_80BE988B.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80BE988B, Slot.SQ_BOSS_80BE988B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE988B,
                    group = mission.TaskGroup.OBJ_ALL_80BE988B.GROUP_0,
                    member = Slot.SQ_BOSS_BOSS_80BE988B,
                }),
            },
        },
        -- Terminus East.
        [424] = {
            boss = Slot.SQ_BOSS_80BE991D,
            chest = {Slot.REGION_CHEST_MAJOR2_80BE99D1},
            squads = {
                unit(Squad.SQ_BOSS_80BE991D, Slot.SQ_BOSS_80BE991D, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE991D,
                    group = mission.TaskGroup.OBJ_ALL_80BE991D.GROUP_0,
                    member = Slot.SQ_BOSS_BOSS_80BE991D,
                }),
                unit(Squad.SQ_NIGHTMARES_80BE991D, Slot.SQ_NIGHTMARES_80BE991D, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE991D,
                    group = mission.TaskGroup.OBJ_ALL_80BE991D.GROUP_0,
                }),
                unit(Squad.SQ_FRONT_A_80BE991D, Slot.SQ_FRONT_A_80BE991D, {
                    counts = {4, 3},
                    objective = Slot.OBJ_ALL_80BE991D,
                    group = mission.TaskGroup.OBJ_ALL_80BE991D.GROUP_0,
                }),
                unit(Squad.SQ_MID_A_80BE991D, Slot.SQ_MID_A_80BE991D, {
                    counts = {3, 1},
                    objective = Slot.OBJ_ALL_80BE991D,
                    group = mission.TaskGroup.OBJ_ALL_80BE991D.GROUP_0,
                }),
                unit(Squad.SQ_MID_B_80BE991D, Slot.SQ_MID_B_80BE991D, {
                    counts = {4, 2},
                    objective = Slot.OBJ_ALL_80BE991D,
                    group = mission.TaskGroup.OBJ_ALL_80BE991D.GROUP_0,
                }),
                unit(Squad.SQ_MID_C_80BE991D, Slot.SQ_MID_C_80BE991D, {
                    counts = {2, 3},
                    objective = Slot.OBJ_ALL_80BE991D,
                    group = mission.TaskGroup.OBJ_ALL_80BE991D.GROUP_0,
                }),
                unit(Squad.SQ_MID_D_80BE991D, Slot.SQ_MID_D_80BE991D, {
                    counts = {3, 3},
                    objective = Slot.OBJ_ALL_80BE991D,
                    group = mission.TaskGroup.OBJ_ALL_80BE991D.GROUP_0,
                }),
                unit(Squad.SQ_BACK_A_80BE991D, Slot.SQ_BACK_A_80BE991D, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BE991D,
                    group = mission.TaskGroup.OBJ_ALL_80BE991D.GROUP_0,
                }),
                unit(Squad.SQ_BACK_B_80BE991D, Slot.SQ_BACK_B_80BE991D, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE991D,
                    group = mission.TaskGroup.OBJ_ALL_80BE991D.GROUP_0,
                }),
                unit(Squad.SQ_BACK_C_80BE991D, Slot.SQ_BACK_C_80BE991D, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE991D,
                    group = mission.TaskGroup.OBJ_ALL_80BE991D.GROUP_0,
                }),
                unit(Squad.SQ_BACK_D_80BE991D, Slot.SQ_BACK_D_80BE991D, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE991D,
                    group = mission.TaskGroup.OBJ_ALL_80BE991D.GROUP_0,
                }),
                unit(Squad.SQ_BACK_E_80BE991D, Slot.SQ_BACK_E_80BE991D, {
                    counts = {3, 1},
                    objective = Slot.OBJ_ALL_80BE991D,
                    group = mission.TaskGroup.OBJ_ALL_80BE991D.GROUP_0,
                }),
                unit(Squad.SQ_TOP_A_80BE991D, Slot.SQ_TOP_A_80BE991D, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE991D,
                    group = mission.TaskGroup.OBJ_ALL_80BE991D.GROUP_0,
                }),
                unit(Squad.SQ_TOP_B_80BE991D, Slot.SQ_TOP_B_80BE991D, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE991D,
                    group = mission.TaskGroup.OBJ_ALL_80BE991D.GROUP_0,
                }),
                unit(Squad.SQ_TOP_C_80BE991D, Slot.SQ_TOP_C_80BE991D, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BE991D,
                    group = mission.TaskGroup.OBJ_ALL_80BE991D.GROUP_0,
                }),
            },
        },
        -- Widow's Walk.
        [432] = {
            boss = Slot.SQ_BOSS_80BE9A3D,
            chest = {Slot.REGION_CHEST_MAJOR3_80BE9B07},
            squads = {
                unit(Squad.SQ_WAVE1_A_80BE9A3D, Slot.SQ_WAVE1_A_80BE9A3D, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80BE9A3D,
                    group = mission.TaskGroup.OBJ_ALL_80BE9A3D.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80BE9A3D, Slot.SQ_WAVE1_B_80BE9A3D, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE9A3D,
                    group = mission.TaskGroup.OBJ_ALL_80BE9A3D.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80BE9A3D, Slot.SQ_WAVE1_C_80BE9A3D, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE9A3D,
                    group = mission.TaskGroup.OBJ_ALL_80BE9A3D.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80BE9A3D, Slot.SQ_WAVE1_D_80BE9A3D, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE9A3D,
                    group = mission.TaskGroup.OBJ_ALL_80BE9A3D.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_A_80BE9A3D, Slot.SQ_WAVE2_A_80BE9A3D, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE9A3D,
                    group = mission.TaskGroup.OBJ_ALL_80BE9A3D.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_B_80BE9A3D, Slot.SQ_WAVE2_B_80BE9A3D, {
                    counts = {4, 1},
                    objective = Slot.OBJ_ALL_80BE9A3D,
                    group = mission.TaskGroup.OBJ_ALL_80BE9A3D.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_C_80BE9A3D, Slot.SQ_WAVE2_C_80BE9A3D, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE9A3D,
                    group = mission.TaskGroup.OBJ_ALL_80BE9A3D.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_D, Slot.SQ_WAVE2_D, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE9A3D,
                    group = mission.TaskGroup.OBJ_ALL_80BE9A3D.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_E, Slot.SQ_WAVE2_E, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BE9A3D,
                    group = mission.TaskGroup.OBJ_ALL_80BE9A3D.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_A_80BE9A3D, Slot.SQ_WAVE3_A_80BE9A3D, {
                    counts = {4},
                    objective = Slot.OBJ_ALL_80BE9A3D,
                    group = mission.TaskGroup.OBJ_ALL_80BE9A3D.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_B_80BE9A3D, Slot.SQ_WAVE3_B_80BE9A3D, {
                    counts = {4, 1},
                    objective = Slot.OBJ_ALL_80BE9A3D,
                    group = mission.TaskGroup.OBJ_ALL_80BE9A3D.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80BE9A3D, Slot.SQ_BOSS_80BE9A3D, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE9A3D,
                    group = mission.TaskGroup.OBJ_ALL_80BE9A3D.GROUP_0,
                    member = Slot.SQ_BOSS_BOSS_80BE9A3D,
                }),
                unit(Squad.SQ_NIGHTMARES_80BE9A3D, Slot.SQ_NIGHTMARES_80BE9A3D, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BE9A3D,
                    group = mission.TaskGroup.OBJ_ALL_80BE9A3D.GROUP_0,
                }),
            },
        },
        -- Cavern of Souls.
        [456] = {
            boss = Slot.SQ_CHAMBER_BOSS_80C26C53,
            chest = {Slot.REGION_CHEST_MAJOR1_80C272B5},
            squads = {
                unit(Squad.SQ_CHAMBER_BOSS_80C26C53, Slot.SQ_CHAMBER_BOSS_80C26C53, {
                    counts = {1},
                    objective = Slot.OBJ_CHAMBER_BOSS,
                    group = mission.TaskGroup.OBJ_CHAMBER_BOSS.GROUP_0,
                    member = Slot.SQ_CHAMBER_BOSS_BOSS_80C26C53,
                }),
                unit(Squad.SQ_CHAMBER_FRONT_A, Slot.SQ_CHAMBER_FRONT_A, {
                    counts = {7},
                    objective = Slot.OBJ_CHAMBER_BOSS,
                    group = mission.TaskGroup.OBJ_CHAMBER_BOSS.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_FRONT_B, Slot.SQ_CHAMBER_FRONT_B, {
                    counts = {7},
                    objective = Slot.OBJ_CHAMBER_BOSS,
                    group = mission.TaskGroup.OBJ_CHAMBER_BOSS.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_MID_A, Slot.SQ_CHAMBER_MID_A, {
                    counts = {3},
                    objective = Slot.OBJ_CHAMBER_BOSS,
                    group = mission.TaskGroup.OBJ_CHAMBER_BOSS.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_BACK_A, Slot.SQ_CHAMBER_BACK_A, {
                    counts = {3},
                    objective = Slot.OBJ_CHAMBER_BOSS,
                    group = mission.TaskGroup.OBJ_CHAMBER_BOSS.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_BACKUP, Slot.SQ_CHAMBER_BACKUP, {
                    counts = {7},
                    objective = Slot.OBJ_CHAMBER_BOSS,
                    group = mission.TaskGroup.OBJ_CHAMBER_BOSS.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_BACKUP_1, Slot.SQ_CHAMBER_BACKUP_1, {
                    counts = {3},
                    objective = Slot.OBJ_CHAMBER_BOSS,
                    group = mission.TaskGroup.OBJ_CHAMBER_BOSS.GROUP_0,
                }),
            },
        },
        -- Hallowed Grove.
        [464] = {
            boss = Slot.SQ_OPEN_UPPER_BOSS_A,
            chest = {Slot.REGION_CHEST_MAJOR2_80C273CD},
            squads = {
                unit(Squad.SQ_OPEN_RAMP_BACK_A, Slot.SQ_OPEN_RAMP_BACK_A, {
                    counts = {1},
                    objective = Slot.OBJ_OPEN_RAMP,
                    group = mission.TaskGroup.OBJ_OPEN_RAMP.GROUP_0,
                }),
                unit(Squad.SQ_OPEN_RAMP_FRONT_A, Slot.SQ_OPEN_RAMP_FRONT_A, {
                    counts = {7},
                    objective = Slot.OBJ_OPEN_RAMP,
                    group = mission.TaskGroup.OBJ_OPEN_RAMP.GROUP_0,
                }),
                unit(Squad.SQ_OPEN_RAMP_FRONT_B, Slot.SQ_OPEN_RAMP_FRONT_B, {
                    counts = {3},
                    objective = Slot.OBJ_OPEN_RAMP,
                    group = mission.TaskGroup.OBJ_OPEN_RAMP.GROUP_0,
                }),
                unit(Squad.SQ_OPEN_LOWER_BACK_A, Slot.SQ_OPEN_LOWER_BACK_A, {
                    counts = {1},
                    objective = Slot.OBJ_OPEN_RAMP,
                    group = mission.TaskGroup.OBJ_OPEN_RAMP.GROUP_0,
                }),
                unit(Squad.SQ_OPEN_LOWER_BACK_B, Slot.SQ_OPEN_LOWER_BACK_B, {
                    counts = {1},
                    objective = Slot.OBJ_OPEN_RAMP,
                    group = mission.TaskGroup.OBJ_OPEN_RAMP.GROUP_0,
                }),
                unit(Squad.SQ_OPEN_LOWER_FRONT_A, Slot.SQ_OPEN_LOWER_FRONT_A, {
                    counts = {7},
                    objective = Slot.OBJ_OPEN_RAMP,
                    group = mission.TaskGroup.OBJ_OPEN_RAMP.GROUP_0,
                }),
                unit(Squad.SQ_OPEN_RAISED_A, Slot.SQ_OPEN_RAISED_A, {
                    counts = {2},
                    objective = Slot.OBJ_OPEN_RAMP,
                    group = mission.TaskGroup.OBJ_OPEN_RAMP.GROUP_0,
                }),
                unit(Squad.SQ_OPEN_RAISED_B, Slot.SQ_OPEN_RAISED_B, {
                    counts = {2},
                    objective = Slot.OBJ_OPEN_RAMP,
                    group = mission.TaskGroup.OBJ_OPEN_RAMP.GROUP_0,
                }),
                unit(Squad.SQ_OPEN_RAISED_C, Slot.SQ_OPEN_RAISED_C, {
                    counts = {3},
                    objective = Slot.OBJ_OPEN_RAMP,
                    group = mission.TaskGroup.OBJ_OPEN_RAMP.GROUP_0,
                }),
                unit(Squad.SQ_OPEN_UPPER_FRONT_A, Slot.SQ_OPEN_UPPER_FRONT_A, {
                    counts = {7},
                    objective = Slot.OBJ_OPEN_RAMP,
                    group = mission.TaskGroup.OBJ_OPEN_RAMP.GROUP_0,
                }),
                unit(Squad.SQ_OPEN_UPPER_MID_A, Slot.SQ_OPEN_UPPER_MID_A, {
                    counts = {3},
                    objective = Slot.OBJ_OPEN_RAMP,
                    group = mission.TaskGroup.OBJ_OPEN_RAMP.GROUP_0,
                }),
                unit(Squad.SQ_OPEN_UPPER_BACK_A, Slot.SQ_OPEN_UPPER_BACK_A, {
                    counts = {3},
                    objective = Slot.OBJ_OPEN_RAMP,
                    group = mission.TaskGroup.OBJ_OPEN_RAMP.GROUP_0,
                }),
                unit(Squad.SQ_OPEN_UPPER_RAISED_A, Slot.SQ_OPEN_UPPER_RAISED_A, {
                    counts = {3},
                    objective = Slot.OBJ_OPEN_RAMP,
                    group = mission.TaskGroup.OBJ_OPEN_RAMP.GROUP_0,
                }),
                unit(Squad.SQ_OPEN_UPPER_RAISED_B, Slot.SQ_OPEN_UPPER_RAISED_B, {
                    counts = {2},
                    objective = Slot.OBJ_OPEN_RAMP,
                    group = mission.TaskGroup.OBJ_OPEN_RAMP.GROUP_0,
                }),
                unit(Squad.SQ_OPEN_UPPER_BOSS_A, Slot.SQ_OPEN_UPPER_BOSS_A, {
                    counts = {1},
                    objective = Slot.OBJ_OPEN_RAMP,
                    group = mission.TaskGroup.OBJ_OPEN_RAMP.GROUP_0,
                }),
            },
        },
        -- Shaft 13.
        [472] = {
            boss = Slot.SQ_BOSS_A,
            chest = {Slot.REGION_CHEST_MAJOR3_80C2745E},
            squads = {
                unit(Squad.SQ_ENTRY_FRONT_A_80C2743C, Slot.SQ_ENTRY_FRONT_A_80C2743C, {
                    counts = {4},
                    objective = Slot.OBJ_ENTRY_80C2743C,
                    group = mission.TaskGroup.OBJ_ENTRY_80C2743C.GROUP_0,
                }),
                unit(Squad.SQ_ENTRY_RAMP_A, Slot.SQ_ENTRY_RAMP_A, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRY_80C2743C,
                    group = mission.TaskGroup.OBJ_ENTRY_80C2743C.GROUP_0,
                }),
                unit(Squad.SQ_BUILDING_A, Slot.SQ_BUILDING_A, {
                    counts = {2},
                    objective = Slot.OBJ_ENTRY_80C2743C,
                    group = mission.TaskGroup.OBJ_ENTRY_80C2743C.GROUP_0,
                }),
                unit(Squad.SQ_BUILDING_B, Slot.SQ_BUILDING_B, {
                    counts = {3},
                    objective = Slot.OBJ_ENTRY_80C2743C,
                    group = mission.TaskGroup.OBJ_ENTRY_80C2743C.GROUP_0,
                }),
                unit(Squad.SQ_BUILDING_BALCONY_A, Slot.SQ_BUILDING_BALCONY_A, {
                    counts = {3},
                    objective = Slot.OBJ_ENTRY_80C2743C,
                    group = mission.TaskGroup.OBJ_ENTRY_80C2743C.GROUP_0,
                }),
                unit(Squad.SQ_BUILDING_INTERIOR_A, Slot.SQ_BUILDING_INTERIOR_A, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRY_80C2743C,
                    group = mission.TaskGroup.OBJ_ENTRY_80C2743C.GROUP_0,
                }),
                unit(Squad.SQ_OPEN_A, Slot.SQ_OPEN_A, {
                    counts = {2},
                    objective = Slot.OBJ_ENTRY_80C2743C,
                    group = mission.TaskGroup.OBJ_ENTRY_80C2743C.GROUP_0,
                }),
                unit(Squad.SQ_OPEN_B, Slot.SQ_OPEN_B, {
                    counts = {2},
                    objective = Slot.OBJ_ENTRY_80C2743C,
                    group = mission.TaskGroup.OBJ_ENTRY_80C2743C.GROUP_0,
                }),
                unit(Squad.SQ_OPEN_C, Slot.SQ_OPEN_C, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRY_80C2743C,
                    group = mission.TaskGroup.OBJ_ENTRY_80C2743C.GROUP_0,
                }),
                unit(Squad.SQ_SALTBLOCKS_A, Slot.SQ_SALTBLOCKS_A, {
                    counts = {2},
                    objective = Slot.OBJ_ENTRY_80C2743C,
                    group = mission.TaskGroup.OBJ_ENTRY_80C2743C.GROUP_0,
                }),
                unit(Squad.SQ_SALTBLOCKS_B, Slot.SQ_SALTBLOCKS_B, {
                    counts = {3},
                    objective = Slot.OBJ_ENTRY_80C2743C,
                    group = mission.TaskGroup.OBJ_ENTRY_80C2743C.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_A, Slot.SQ_BOSS_A, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRY_80C2743C,
                    group = mission.TaskGroup.OBJ_ENTRY_80C2743C.GROUP_0,
                    member = Slot.SQ_BOSS_A_BOSS,
                }),
                unit(Squad.SQ_NIGHTMARES_80C2743C, Slot.SQ_NIGHTMARES_80C2743C, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRY_80C2743C,
                    group = mission.TaskGroup.OBJ_ENTRY_80C2743C.GROUP_0,
                }),
            },
        },
    }
end
