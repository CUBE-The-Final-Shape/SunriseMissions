-- Lost Sector encounter choices; live parity remains unverified.
return function(mission, freeroam)
    local Slot, Squad = mission.Slot, mission.Squad
    local unit = freeroam.unit
    return {
        -- The Rift.
        [40] = {
            boss = Slot.SQ_BOSS_80C06CF8,
            chest = {Slot.REGION_CHEST_MAJOR1_80C06D92},
            squads = {
                unit(Squad.SQ_WAVE1_A_80C06D74, Slot.SQ_WAVE1_A_80C06D74, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C06D74,
                    group = mission.TaskGroup.OBJ_ALL_80C06D74.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80C06D74, Slot.SQ_WAVE1_B_80C06D74, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C06D74,
                    group = mission.TaskGroup.OBJ_ALL_80C06D74.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80C06D74, Slot.SQ_WAVE1_C_80C06D74, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C06D74,
                    group = mission.TaskGroup.OBJ_ALL_80C06D74.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80C06D74, Slot.SQ_WAVE1_D_80C06D74, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C06D74,
                    group = mission.TaskGroup.OBJ_ALL_80C06D74.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80C06D74, Slot.SQ_WAVE1_E_80C06D74, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C06D74,
                    group = mission.TaskGroup.OBJ_ALL_80C06D74.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_F_80C06D74, Slot.SQ_WAVE1_F_80C06D74, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C06D74,
                    group = mission.TaskGroup.OBJ_ALL_80C06D74.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_A_80C06D74, Slot.SQ_WAVE2_A_80C06D74, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C06D74,
                    group = mission.TaskGroup.OBJ_ALL_80C06D74.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_B_80C06D74, Slot.SQ_WAVE2_B_80C06D74, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C06D74,
                    group = mission.TaskGroup.OBJ_ALL_80C06D74.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_C_80C06D74, Slot.SQ_WAVE2_C_80C06D74, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C06D74,
                    group = mission.TaskGroup.OBJ_ALL_80C06D74.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_D_80C06D74, Slot.SQ_WAVE2_D_80C06D74, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C06D74,
                    group = mission.TaskGroup.OBJ_ALL_80C06D74.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_A_80C06D74, Slot.SQ_WAVE3_A_80C06D74, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C06D74,
                    group = mission.TaskGroup.OBJ_ALL_80C06D74.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_B_80C06D74, Slot.SQ_WAVE3_B_80C06D74, {
                    counts = {1, 1},
                    objective = Slot.OBJ_ALL_80C06D74,
                    group = mission.TaskGroup.OBJ_ALL_80C06D74.GROUP_0,
                }),
                unit(Squad.SQ_NIGHTMARES_80C06CF8, Slot.SQ_NIGHTMARES_80C06CF8, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C06CF8,
                    group = mission.TaskGroup.OBJ_ALL_80C06CF8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_A_80C06CF8, Slot.SQ_WAVE1_A_80C06CF8, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C06CF8,
                    group = mission.TaskGroup.OBJ_ALL_80C06CF8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80C06CF8, Slot.SQ_WAVE1_B_80C06CF8, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C06CF8,
                    group = mission.TaskGroup.OBJ_ALL_80C06CF8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80C06CF8, Slot.SQ_WAVE1_C_80C06CF8, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C06CF8,
                    group = mission.TaskGroup.OBJ_ALL_80C06CF8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80C06CF8, Slot.SQ_WAVE1_D_80C06CF8, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C06CF8,
                    group = mission.TaskGroup.OBJ_ALL_80C06CF8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80C06CF8, Slot.SQ_WAVE1_E_80C06CF8, {
                    counts = {1, 1},
                    objective = Slot.OBJ_ALL_80C06CF8,
                    group = mission.TaskGroup.OBJ_ALL_80C06CF8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_F_80C06CF8, Slot.SQ_WAVE1_F_80C06CF8, {
                    counts = {1, 1},
                    objective = Slot.OBJ_ALL_80C06CF8,
                    group = mission.TaskGroup.OBJ_ALL_80C06CF8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_G_80C06CF8, Slot.SQ_WAVE1_G_80C06CF8, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C06CF8,
                    group = mission.TaskGroup.OBJ_ALL_80C06CF8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_A_80C06CF8, Slot.SQ_WAVE2_A_80C06CF8, {
                    counts = {1, 1},
                    objective = Slot.OBJ_ALL_80C06CF8,
                    group = mission.TaskGroup.OBJ_ALL_80C06CF8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_B_80C06CF8, Slot.SQ_WAVE2_B_80C06CF8, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C06CF8,
                    group = mission.TaskGroup.OBJ_ALL_80C06CF8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_C_80C06CF8, Slot.SQ_WAVE2_C_80C06CF8, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C06CF8,
                    group = mission.TaskGroup.OBJ_ALL_80C06CF8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_D_80C06CF8, Slot.SQ_WAVE2_D_80C06CF8, {
                    counts = {1, 1},
                    objective = Slot.OBJ_ALL_80C06CF8,
                    group = mission.TaskGroup.OBJ_ALL_80C06CF8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_E_80C06CF8, Slot.SQ_WAVE2_E_80C06CF8, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C06CF8,
                    group = mission.TaskGroup.OBJ_ALL_80C06CF8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_F_80C06CF8, Slot.SQ_WAVE2_F_80C06CF8, {
                    counts = {1, 1},
                    objective = Slot.OBJ_ALL_80C06CF8,
                    group = mission.TaskGroup.OBJ_ALL_80C06CF8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_A_80C06CF8, Slot.SQ_WAVE3_A_80C06CF8, {
                    counts = {1, 1},
                    objective = Slot.OBJ_ALL_80C06CF8,
                    group = mission.TaskGroup.OBJ_ALL_80C06CF8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_B_80C06CF8, Slot.SQ_WAVE3_B_80C06CF8, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C06CF8,
                    group = mission.TaskGroup.OBJ_ALL_80C06CF8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_C_80C06CF8, Slot.SQ_WAVE3_C_80C06CF8, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C06CF8,
                    group = mission.TaskGroup.OBJ_ALL_80C06CF8.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80C06CF8, Slot.SQ_BOSS_80C06CF8, {
                    counts = {1},
                    objective = Slot.OBJ_BOSS_80C06CF8,
                    group = mission.TaskGroup.OBJ_BOSS_80C06CF8.GROUP_0,
                }),
            },
        },
        -- The Conflux.
        [96] = {
            boss = Slot.SQ_BOSS_80C08B57,
            chest = {Slot.REGION_CHEST_MAJOR1_80C08BFA},
            squads = {
                unit(Squad.SQ_NIGHTMARES_80C08B57, Slot.SQ_NIGHTMARES_80C08B57, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08B57,
                    group = mission.TaskGroup.OBJ_ALL_80C08B57.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_A_80C08B57, Slot.SQ_WAVE1_A_80C08B57, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80C08B57,
                    group = mission.TaskGroup.OBJ_ALL_80C08B57.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80C08B57, Slot.SQ_WAVE1_B_80C08B57, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C08B57,
                    group = mission.TaskGroup.OBJ_ALL_80C08B57.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80C08B57, Slot.SQ_WAVE1_C_80C08B57, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80C08B57,
                    group = mission.TaskGroup.OBJ_ALL_80C08B57.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80C08B57, Slot.SQ_WAVE1_D_80C08B57, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80C08B57,
                    group = mission.TaskGroup.OBJ_ALL_80C08B57.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80C08B57, Slot.SQ_WAVE1_E_80C08B57, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80C08B57,
                    group = mission.TaskGroup.OBJ_ALL_80C08B57.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_F_80C08B57, Slot.SQ_WAVE1_F_80C08B57, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80C08B57,
                    group = mission.TaskGroup.OBJ_ALL_80C08B57.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_G_80C08B57, Slot.SQ_WAVE1_G_80C08B57, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C08B57,
                    group = mission.TaskGroup.OBJ_ALL_80C08B57.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_A_80C08B57, Slot.SQ_WAVE2_A_80C08B57, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08B57,
                    group = mission.TaskGroup.OBJ_ALL_80C08B57.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_B_80C08B57, Slot.SQ_WAVE2_B_80C08B57, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08B57,
                    group = mission.TaskGroup.OBJ_ALL_80C08B57.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_C_80C08B57, Slot.SQ_WAVE2_C_80C08B57, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08B57,
                    group = mission.TaskGroup.OBJ_ALL_80C08B57.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_D_80C08B57, Slot.SQ_WAVE2_D_80C08B57, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08B57,
                    group = mission.TaskGroup.OBJ_ALL_80C08B57.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_A_80C08B57, Slot.SQ_WAVE3_A_80C08B57, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08B57,
                    group = mission.TaskGroup.OBJ_ALL_80C08B57.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_B_80C08B57, Slot.SQ_WAVE3_B_80C08B57, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08B57,
                    group = mission.TaskGroup.OBJ_ALL_80C08B57.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_C_80C08B57, Slot.SQ_WAVE3_C_80C08B57, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08B57,
                    group = mission.TaskGroup.OBJ_ALL_80C08B57.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_D_80C08B57, Slot.SQ_WAVE3_D_80C08B57, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08B57,
                    group = mission.TaskGroup.OBJ_ALL_80C08B57.GROUP_0,
                }),
                unit(Squad.SQ_WAVE4_A_80C08B57, Slot.SQ_WAVE4_A_80C08B57, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08B57,
                    group = mission.TaskGroup.OBJ_ALL_80C08B57.GROUP_0,
                }),
                unit(Squad.SQ_WAVE4_B_80C08B57, Slot.SQ_WAVE4_B_80C08B57, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08B57,
                    group = mission.TaskGroup.OBJ_ALL_80C08B57.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80C08B57, Slot.SQ_BOSS_80C08B57, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08B57,
                    group = mission.TaskGroup.OBJ_ALL_80C08B57.GROUP_0,
                }),
            },
        },
        -- The Orrery.
        [112] = {
            boss = Slot.SQ_BOSS_80C08ECC,
            chest = {Slot.REGION_CHEST_MAJOR1_80C0902F},
            squads = {
                unit(Squad.SQ_NIGHTMARES_80C08ECC, Slot.SQ_NIGHTMARES_80C08ECC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_FRONT_SNIPER_1, Slot.SQ_FRONT_SNIPER_1, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_FRONT_SNIPER_2, Slot.SQ_FRONT_SNIPER_2, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_MID_SNIPER_1, Slot.SQ_MID_SNIPER_1, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_MID_SNIPER_2, Slot.SQ_MID_SNIPER_2, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_FRONT, Slot.SQ_WAVE1_FRONT, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_A_80C08ECC, Slot.SQ_WAVE1_A_80C08ECC, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80C08ECC, Slot.SQ_WAVE1_B_80C08ECC, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80C08ECC, Slot.SQ_WAVE1_C_80C08ECC, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80C08ECC, Slot.SQ_WAVE1_D_80C08ECC, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80C08ECC, Slot.SQ_WAVE1_E_80C08ECC, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_A_80C08ECC, Slot.SQ_WAVE2_A_80C08ECC, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_B_80C08ECC, Slot.SQ_WAVE2_B_80C08ECC, {
                    counts = {1, 1},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_C_80C08ECC, Slot.SQ_WAVE2_C_80C08ECC, {
                    counts = {1, 1},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_A_80C08ECC, Slot.SQ_WAVE3_A_80C08ECC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_B_80C08ECC, Slot.SQ_WAVE3_B_80C08ECC, {
                    counts = {1, 1},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_C_80C08ECC, Slot.SQ_WAVE3_C_80C08ECC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_D_80C08ECC, Slot.SQ_WAVE3_D_80C08ECC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_E_80C08ECC, Slot.SQ_WAVE3_E_80C08ECC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_F, Slot.SQ_WAVE3_F, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE4_A_80C08ECC, Slot.SQ_WAVE4_A_80C08ECC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE4_B_80C08ECC, Slot.SQ_WAVE4_B_80C08ECC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE4_C, Slot.SQ_WAVE4_C, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE4_D, Slot.SQ_WAVE4_D, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE4_E, Slot.SQ_WAVE4_E, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE5_A, Slot.SQ_WAVE5_A, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE5_B, Slot.SQ_WAVE5_B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE5_C, Slot.SQ_WAVE5_C, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE5_D, Slot.SQ_WAVE5_D, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C08ECC,
                    group = mission.TaskGroup.OBJ_ALL_80C08ECC.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80C08ECC, Slot.SQ_BOSS_80C08ECC, {
                    counts = {1},
                    objective = Slot.OBJ_BOSS_80C08ECC,
                    group = mission.TaskGroup.OBJ_BOSS_80C08ECC.GROUP_0,
                }),
            },
        },
        -- The Carrion Pit.
        [248] = {
            boss = Slot.SQ_BOSS_80C09958,
            chest = {Slot.REGION_CHEST_MAJOR1_80C09CC1},
            squads = {
                unit(Squad.SQ_WAVE1_A_80C09917, Slot.SQ_WAVE1_A_80C09917, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C09917,
                    group = mission.TaskGroup.OBJ_ALL_80C09917.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80C09917, Slot.SQ_WAVE1_B_80C09917, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C09917,
                    group = mission.TaskGroup.OBJ_ALL_80C09917.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80C09917, Slot.SQ_WAVE1_C_80C09917, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80C09917,
                    group = mission.TaskGroup.OBJ_ALL_80C09917.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80C09917, Slot.SQ_WAVE1_D_80C09917, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80C09917,
                    group = mission.TaskGroup.OBJ_ALL_80C09917.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80C09917, Slot.SQ_WAVE1_E_80C09917, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C09917,
                    group = mission.TaskGroup.OBJ_ALL_80C09917.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_F_80C09917, Slot.SQ_WAVE1_F_80C09917, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C09917,
                    group = mission.TaskGroup.OBJ_ALL_80C09917.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_A_80C09917, Slot.SQ_WAVE2_A_80C09917, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C09917,
                    group = mission.TaskGroup.OBJ_ALL_80C09917.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_B_80C09917, Slot.SQ_WAVE2_B_80C09917, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C09917,
                    group = mission.TaskGroup.OBJ_ALL_80C09917.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_C_80C09917, Slot.SQ_WAVE2_C_80C09917, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C09917,
                    group = mission.TaskGroup.OBJ_ALL_80C09917.GROUP_0,
                }),
                unit(Squad.SQ_NIGHTMARES_80C09958, Slot.SQ_NIGHTMARES_80C09958, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C09958,
                    group = mission.TaskGroup.OBJ_ALL_80C09958.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_A_80C09958, Slot.SQ_WAVE1_A_80C09958, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C09958,
                    group = mission.TaskGroup.OBJ_ALL_80C09958.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80C09958, Slot.SQ_WAVE1_B_80C09958, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C09958,
                    group = mission.TaskGroup.OBJ_ALL_80C09958.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80C09958, Slot.SQ_WAVE1_C_80C09958, {
                    counts = {1, 1},
                    objective = Slot.OBJ_ALL_80C09958,
                    group = mission.TaskGroup.OBJ_ALL_80C09958.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80C09958, Slot.SQ_WAVE1_D_80C09958, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C09958,
                    group = mission.TaskGroup.OBJ_ALL_80C09958.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80C09958, Slot.SQ_WAVE1_E_80C09958, {
                    counts = {1, 1},
                    objective = Slot.OBJ_ALL_80C09958,
                    group = mission.TaskGroup.OBJ_ALL_80C09958.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_F_80C09958, Slot.SQ_WAVE1_F_80C09958, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C09958,
                    group = mission.TaskGroup.OBJ_ALL_80C09958.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_G_80C09958, Slot.SQ_WAVE1_G_80C09958, {
                    counts = {1, 1},
                    objective = Slot.OBJ_ALL_80C09958,
                    group = mission.TaskGroup.OBJ_ALL_80C09958.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_H_80C09958, Slot.SQ_WAVE1_H_80C09958, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C09958,
                    group = mission.TaskGroup.OBJ_ALL_80C09958.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_I_80C09958, Slot.SQ_WAVE1_I_80C09958, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C09958,
                    group = mission.TaskGroup.OBJ_ALL_80C09958.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_A_80C09958, Slot.SQ_WAVE2_A_80C09958, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C09958,
                    group = mission.TaskGroup.OBJ_ALL_80C09958.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_B_80C09958, Slot.SQ_WAVE2_B_80C09958, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C09958,
                    group = mission.TaskGroup.OBJ_ALL_80C09958.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_C_80C09958, Slot.SQ_WAVE2_C_80C09958, {
                    counts = {1, 1},
                    objective = Slot.OBJ_ALL_80C09958,
                    group = mission.TaskGroup.OBJ_ALL_80C09958.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_A_80C09958, Slot.SQ_WAVE3_A_80C09958, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C09958,
                    group = mission.TaskGroup.OBJ_ALL_80C09958.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_B_80C09958, Slot.SQ_WAVE3_B_80C09958, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C09958,
                    group = mission.TaskGroup.OBJ_ALL_80C09958.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_C_80C09958, Slot.SQ_WAVE3_C_80C09958, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C09958,
                    group = mission.TaskGroup.OBJ_ALL_80C09958.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_D_80C09958, Slot.SQ_WAVE3_D_80C09958, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C09958,
                    group = mission.TaskGroup.OBJ_ALL_80C09958.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_E_80C09958, Slot.SQ_WAVE3_E_80C09958, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C09958,
                    group = mission.TaskGroup.OBJ_ALL_80C09958.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80C09958, Slot.SQ_BOSS_80C09958, {
                    counts = {1},
                    objective = Slot.OBJ_BOSS_80C09958,
                    group = mission.TaskGroup.OBJ_BOSS_80C09958.GROUP_0,
                }),
            },
        },
        -- Ancient's Haunt.
        [312] = {
            boss = Slot.SQ_BOSS_80C30CCD,
            chest = {Slot.REGION_CHEST_MAJOR1_80C31050},
            squads = {
                unit(Squad.SQ_WAVE1_A_80C30C3C, Slot.SQ_WAVE1_A_80C30C3C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C30C3C,
                    group = mission.TaskGroup.OBJ_ALL_80C30C3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80C30C3C, Slot.SQ_WAVE1_B_80C30C3C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C30C3C,
                    group = mission.TaskGroup.OBJ_ALL_80C30C3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80C30C3C, Slot.SQ_WAVE1_C_80C30C3C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C30C3C,
                    group = mission.TaskGroup.OBJ_ALL_80C30C3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80C30C3C, Slot.SQ_WAVE1_D_80C30C3C, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C30C3C,
                    group = mission.TaskGroup.OBJ_ALL_80C30C3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_I_80C30C3C, Slot.SQ_WAVE1_I_80C30C3C, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C30C3C,
                    group = mission.TaskGroup.OBJ_ALL_80C30C3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80C30C3C, Slot.SQ_WAVE1_E_80C30C3C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C30C3C,
                    group = mission.TaskGroup.OBJ_ALL_80C30C3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_F_80C30C3C, Slot.SQ_WAVE1_F_80C30C3C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C30C3C,
                    group = mission.TaskGroup.OBJ_ALL_80C30C3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_G_80C30C3C, Slot.SQ_WAVE1_G_80C30C3C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C30C3C,
                    group = mission.TaskGroup.OBJ_ALL_80C30C3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_H_80C30C3C, Slot.SQ_WAVE1_H_80C30C3C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C30C3C,
                    group = mission.TaskGroup.OBJ_ALL_80C30C3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_A_80C30C3C, Slot.SQ_WAVE2_A_80C30C3C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80C30C3C,
                    group = mission.TaskGroup.OBJ_ALL_80C30C3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_B_80C30C3C, Slot.SQ_WAVE2_B_80C30C3C, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C30C3C,
                    group = mission.TaskGroup.OBJ_ALL_80C30C3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_C_80C30C3C, Slot.SQ_WAVE2_C_80C30C3C, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C30C3C,
                    group = mission.TaskGroup.OBJ_ALL_80C30C3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_D_80C30C3C, Slot.SQ_WAVE2_D_80C30C3C, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C30C3C,
                    group = mission.TaskGroup.OBJ_ALL_80C30C3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_E_80C30C3C, Slot.SQ_WAVE2_E_80C30C3C, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C30C3C,
                    group = mission.TaskGroup.OBJ_ALL_80C30C3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_F_80C30C3C, Slot.SQ_WAVE2_F_80C30C3C, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C30C3C,
                    group = mission.TaskGroup.OBJ_ALL_80C30C3C.GROUP_0,
                }),
                unit(Squad.SQ_NIGHTMARES_80C30CCD, Slot.SQ_NIGHTMARES_80C30CCD, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C30CCD,
                    group = mission.TaskGroup.OBJ_ALL_80C30CCD.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_A_80C30CCD, Slot.SQ_WAVE1_A_80C30CCD, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C30CCD,
                    group = mission.TaskGroup.OBJ_ALL_80C30CCD.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80C30CCD, Slot.SQ_WAVE1_B_80C30CCD, {
                    counts = {1, 1},
                    objective = Slot.OBJ_ALL_80C30CCD,
                    group = mission.TaskGroup.OBJ_ALL_80C30CCD.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80C30CCD, Slot.SQ_WAVE1_C_80C30CCD, {
                    counts = {1, 1},
                    objective = Slot.OBJ_ALL_80C30CCD,
                    group = mission.TaskGroup.OBJ_ALL_80C30CCD.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80C30CCD, Slot.SQ_WAVE1_D_80C30CCD, {
                    counts = {1, 1},
                    objective = Slot.OBJ_ALL_80C30CCD,
                    group = mission.TaskGroup.OBJ_ALL_80C30CCD.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80C30CCD, Slot.SQ_WAVE1_E_80C30CCD, {
                    counts = {1, 1},
                    objective = Slot.OBJ_ALL_80C30CCD,
                    group = mission.TaskGroup.OBJ_ALL_80C30CCD.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_A_80C30CCD, Slot.SQ_WAVE2_A_80C30CCD, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C30CCD,
                    group = mission.TaskGroup.OBJ_ALL_80C30CCD.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_B_80C30CCD, Slot.SQ_WAVE2_B_80C30CCD, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80C30CCD,
                    group = mission.TaskGroup.OBJ_ALL_80C30CCD.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80C30CCD, Slot.SQ_BOSS_80C30CCD, {
                    counts = {1},
                    objective = Slot.OBJ_BOSS_80C30CCD,
                    group = mission.TaskGroup.OBJ_BOSS_80C30CCD.GROUP_0,
                }),
            },
        },
    }
end
