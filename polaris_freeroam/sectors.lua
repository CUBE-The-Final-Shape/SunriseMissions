-- Lost Sector encounter choices; live parity remains unverified.
return function(mission, freeroam)
    local Slot, Squad = mission.Slot, mission.Squad
    local unit = freeroam.unit
    return {
        -- Core Terminus.
        [16] = {
            boss = Slot.SQ_BOSS_80F73AD0,
            chest = {Slot.REGION_CHEST_MAJOR1_80F73C83},
            squads = {
                unit(Squad.SQ_WAVE1_A_80F73A65, Slot.SQ_WAVE1_A_80F73A65, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F73A65,
                    group = mission.TaskGroup.OBJ_ALL_80F73A65.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80F73A65, Slot.SQ_WAVE1_B_80F73A65, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F73A65,
                    group = mission.TaskGroup.OBJ_ALL_80F73A65.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80F73A65, Slot.SQ_WAVE1_C_80F73A65, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F73A65,
                    group = mission.TaskGroup.OBJ_ALL_80F73A65.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80F73A65, Slot.SQ_WAVE1_D_80F73A65, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F73A65,
                    group = mission.TaskGroup.OBJ_ALL_80F73A65.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80F73A65, Slot.SQ_WAVE1_E_80F73A65, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F73A65,
                    group = mission.TaskGroup.OBJ_ALL_80F73A65.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_F_80F73A65, Slot.SQ_WAVE1_F_80F73A65, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80F73A65,
                    group = mission.TaskGroup.OBJ_ALL_80F73A65.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_G_80F73A65, Slot.SQ_WAVE1_G_80F73A65, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80F73A65,
                    group = mission.TaskGroup.OBJ_ALL_80F73A65.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_L, Slot.SQ_WAVE1_L, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80F73A65,
                    group = mission.TaskGroup.OBJ_ALL_80F73A65.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_H, Slot.SQ_WAVE1_H, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80F73A65,
                    group = mission.TaskGroup.OBJ_ALL_80F73A65.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_I, Slot.SQ_WAVE1_I, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F73A65,
                    group = mission.TaskGroup.OBJ_ALL_80F73A65.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_J, Slot.SQ_WAVE1_J, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F73A65,
                    group = mission.TaskGroup.OBJ_ALL_80F73A65.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_K, Slot.SQ_WAVE1_K, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F73A65,
                    group = mission.TaskGroup.OBJ_ALL_80F73A65.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_M, Slot.SQ_WAVE1_M, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F73A65,
                    group = mission.TaskGroup.OBJ_ALL_80F73A65.GROUP_0,
                }),
                unit(Squad.SQ_INTRO_THRALL, Slot.SQ_INTRO_THRALL, {
                    counts = {3},
                    objective = Slot.OBJ_INTRO_THRALL,
                    group = mission.TaskGroup.OBJ_INTRO_THRALL.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_A_80F73AD0, Slot.SQ_WAVE1_A_80F73AD0, {
                    counts = {2},
                    objective = Slot.OBJ_RANGED,
                    group = mission.TaskGroup.OBJ_RANGED.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80F73AD0, Slot.SQ_WAVE1_B_80F73AD0, {
                    counts = {2},
                    objective = Slot.OBJ_RANGED,
                    group = mission.TaskGroup.OBJ_RANGED.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_MELEE_A, Slot.SQ_WAVE1_MELEE_A, {
                    counts = {2},
                    objective = Slot.OBJ_MELEE,
                    group = mission.TaskGroup.OBJ_MELEE.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_MELEE_B, Slot.SQ_WAVE1_MELEE_B, {
                    counts = {2},
                    objective = Slot.OBJ_MELEE,
                    group = mission.TaskGroup.OBJ_MELEE.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_MELEE_A, Slot.SQ_WAVE2_MELEE_A, {
                    counts = {3},
                    objective = Slot.OBJ_MELEE,
                    group = mission.TaskGroup.OBJ_MELEE.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_MELEE_B, Slot.SQ_WAVE2_MELEE_B, {
                    counts = {3},
                    objective = Slot.OBJ_MELEE,
                    group = mission.TaskGroup.OBJ_MELEE.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_MELEE_A, Slot.SQ_WAVE3_MELEE_A, {
                    counts = {2},
                    objective = Slot.OBJ_MELEE,
                    group = mission.TaskGroup.OBJ_MELEE.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_MELEE_B, Slot.SQ_WAVE3_MELEE_B, {
                    counts = {2},
                    objective = Slot.OBJ_MELEE,
                    group = mission.TaskGroup.OBJ_MELEE.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_MELEE_C, Slot.SQ_WAVE3_MELEE_C, {
                    counts = {1},
                    objective = Slot.OBJ_MELEE,
                    group = mission.TaskGroup.OBJ_MELEE.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_MELEE_D, Slot.SQ_WAVE3_MELEE_D, {
                    counts = {1},
                    objective = Slot.OBJ_MELEE,
                    group = mission.TaskGroup.OBJ_MELEE.GROUP_0,
                }),
                unit(Squad.SQ_WAVE4_MELEE_A, Slot.SQ_WAVE4_MELEE_A, {
                    counts = {2},
                    objective = Slot.OBJ_MELEE,
                    group = mission.TaskGroup.OBJ_MELEE.GROUP_0,
                }),
                unit(Squad.SQ_WAVE4_MELEE_B, Slot.SQ_WAVE4_MELEE_B, {
                    counts = {2},
                    objective = Slot.OBJ_MELEE,
                    group = mission.TaskGroup.OBJ_MELEE.GROUP_0,
                }),
                unit(Squad.SQ_WAVE4_MELEE_C, Slot.SQ_WAVE4_MELEE_C, {
                    counts = {1},
                    objective = Slot.OBJ_MELEE,
                    group = mission.TaskGroup.OBJ_MELEE.GROUP_0,
                }),
                unit(Squad.SQ_WAVE4_MELEE_D, Slot.SQ_WAVE4_MELEE_D, {
                    counts = {1},
                    objective = Slot.OBJ_MELEE,
                    group = mission.TaskGroup.OBJ_MELEE.GROUP_0,
                }),
                unit(Squad.SQ_WAVE4_A, Slot.SQ_WAVE4_A, {
                    counts = {2},
                    objective = Slot.OBJ_RANGED,
                    group = mission.TaskGroup.OBJ_RANGED.GROUP_0,
                }),
                unit(Squad.SQ_WAVE4_B, Slot.SQ_WAVE4_B, {
                    counts = {2},
                    objective = Slot.OBJ_RANGED,
                    group = mission.TaskGroup.OBJ_RANGED.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80F73AD0, Slot.SQ_BOSS_80F73AD0, {
                    counts = {1},
                    objective = Slot.OBJ_BOSS_80F73AD0,
                    group = mission.TaskGroup.OBJ_BOSS_80F73AD0.GROUP_0,
                }),
            },
        },
        -- Ma'adim Subterrane.
        [48] = {
            boss = Slot.SQ_BOSS_80F73EAC,
            chest = {Slot.REGION_CHEST_MAJOR1_80F76089},
            squads = {
                unit(Squad.SQ_WAVE1_A_80F73E64, Slot.SQ_WAVE1_A_80F73E64, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80F73E64,
                    group = mission.TaskGroup.OBJ_ALL_80F73E64.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80F73E64, Slot.SQ_WAVE1_B_80F73E64, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80F73E64,
                    group = mission.TaskGroup.OBJ_ALL_80F73E64.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80F73E64, Slot.SQ_WAVE1_C_80F73E64, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F73E64,
                    group = mission.TaskGroup.OBJ_ALL_80F73E64.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80F73E64, Slot.SQ_WAVE1_D_80F73E64, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F73E64,
                    group = mission.TaskGroup.OBJ_ALL_80F73E64.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_A_80F73ED8, Slot.SQ_WAVE1_A_80F73ED8, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80F73ED8,
                    group = mission.TaskGroup.OBJ_ALL_80F73ED8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80F73ED8, Slot.SQ_WAVE1_B_80F73ED8, {
                    counts = {1, 2},
                    objective = Slot.OBJ_ALL_80F73ED8,
                    group = mission.TaskGroup.OBJ_ALL_80F73ED8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80F73ED8, Slot.SQ_WAVE1_C_80F73ED8, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80F73ED8,
                    group = mission.TaskGroup.OBJ_ALL_80F73ED8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80F73ED8, Slot.SQ_WAVE1_D_80F73ED8, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80F73ED8,
                    group = mission.TaskGroup.OBJ_ALL_80F73ED8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80F73ED8, Slot.SQ_WAVE1_E_80F73ED8, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80F73ED8,
                    group = mission.TaskGroup.OBJ_ALL_80F73ED8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_F_80F73ED8, Slot.SQ_WAVE1_F_80F73ED8, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80F73ED8,
                    group = mission.TaskGroup.OBJ_ALL_80F73ED8.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_G_80F73ED8, Slot.SQ_WAVE1_G_80F73ED8, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80F73ED8,
                    group = mission.TaskGroup.OBJ_ALL_80F73ED8.GROUP_0,
                }),
                unit(Squad.SQ_HALL_A, Slot.SQ_HALL_A, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F73EAC,
                    group = mission.TaskGroup.OBJ_ALL_80F73EAC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_A_80F73EAC, Slot.SQ_WAVE1_A_80F73EAC, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F73EAC,
                    group = mission.TaskGroup.OBJ_ALL_80F73EAC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80F73EAC, Slot.SQ_WAVE1_B_80F73EAC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80F73EAC,
                    group = mission.TaskGroup.OBJ_ALL_80F73EAC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80F73EAC, Slot.SQ_WAVE1_C_80F73EAC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80F73EAC,
                    group = mission.TaskGroup.OBJ_ALL_80F73EAC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80F73EAC, Slot.SQ_WAVE1_D_80F73EAC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80F73EAC,
                    group = mission.TaskGroup.OBJ_ALL_80F73EAC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80F73EAC, Slot.SQ_WAVE1_E_80F73EAC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80F73EAC,
                    group = mission.TaskGroup.OBJ_ALL_80F73EAC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_F_80F73EAC, Slot.SQ_WAVE1_F_80F73EAC, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F73EAC,
                    group = mission.TaskGroup.OBJ_ALL_80F73EAC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_A, Slot.SQ_WAVE2_A, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F73EAC,
                    group = mission.TaskGroup.OBJ_ALL_80F73EAC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_B, Slot.SQ_WAVE2_B, {
                    counts = {1, 1},
                    objective = Slot.OBJ_ALL_80F73EAC,
                    group = mission.TaskGroup.OBJ_ALL_80F73EAC.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80F73EAC, Slot.SQ_BOSS_80F73EAC, {
                    counts = {1},
                    objective = Slot.OBJ_BOSS_80F73EAC,
                    group = mission.TaskGroup.OBJ_BOSS_80F73EAC.GROUP_0,
                }),
            },
        },
    }
end
