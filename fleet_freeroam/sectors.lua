-- Lost Sector encounter choices; live parity remains unverified.
return function(mission, freeroam)
    local Slot, Squad = mission.Slot, mission.Squad
    local unit = freeroam.unit
    return {
        -- Methane Flush.
        [24] = {
            boss = Slot.SQ_BOSS_80BF014B,
            chest = {Slot.REGION_CHEST_MAJOR1_80BF080B},
            squads = {
                unit(Squad.SQ_NIGHTMARES_80BF014B, Slot.SQ_NIGHTMARES_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_A_80BF014B, Slot.SQ_WAVE1_A_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80BF014B, Slot.SQ_WAVE1_B_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80BF014B, Slot.SQ_WAVE1_C_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80BF014B, Slot.SQ_WAVE1_D_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80BF014B, Slot.SQ_WAVE1_E_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_F_80BF014B, Slot.SQ_WAVE1_F_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_G_80BF014B, Slot.SQ_WAVE1_G_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_H_80BF014B, Slot.SQ_WAVE1_H_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_I_80BF014B, Slot.SQ_WAVE1_I_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_J_80BF014B, Slot.SQ_WAVE1_J_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_K_80BF014B, Slot.SQ_WAVE1_K_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_L_80BF014B, Slot.SQ_WAVE1_L_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_M_80BF014B, Slot.SQ_WAVE1_M_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_A_80BF014B, Slot.SQ_WAVE2_A_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_B_80BF014B, Slot.SQ_WAVE2_B_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_C_80BF014B, Slot.SQ_WAVE2_C_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_D_80BF014B, Slot.SQ_WAVE2_D_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_E_80BF014B, Slot.SQ_WAVE2_E_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_F, Slot.SQ_WAVE2_F, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_G, Slot.SQ_WAVE2_G, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_H, Slot.SQ_WAVE2_H, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_A, Slot.SQ_WAVE3_A, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_B, Slot.SQ_WAVE3_B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_C, Slot.SQ_WAVE3_C, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_D, Slot.SQ_WAVE3_D, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_E, Slot.SQ_WAVE3_E, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE4_A_80BF014B, Slot.SQ_WAVE4_A_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE4_B_80BF014B, Slot.SQ_WAVE4_B_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE4_C, Slot.SQ_WAVE4_C, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_WAVE4_D, Slot.SQ_WAVE4_D, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF014B,
                    group = mission.TaskGroup.OBJ_ALL_80BF014B.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80BF014B, Slot.SQ_BOSS_80BF014B, {
                    counts = {1},
                    objective = Slot.OBJ_BOSS_80BF014B,
                    group = mission.TaskGroup.OBJ_BOSS_80BF014B.GROUP_0,
                }),
            },
        },
        -- DS Quarters-2.
        [64] = {
            boss = Slot.SQ_BOSS_80BF60E6,
            chest = {Slot.REGION_CHEST_MAJOR1_80BF65DF},
            squads = {
                unit(Squad.SQ_WAVE1_A_80BF6158, Slot.SQ_WAVE1_A_80BF6158, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF6158,
                    group = mission.TaskGroup.OBJ_ALL_80BF6158.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80BF6158, Slot.SQ_WAVE1_B_80BF6158, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF6158,
                    group = mission.TaskGroup.OBJ_ALL_80BF6158.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80BF6158, Slot.SQ_WAVE1_C_80BF6158, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF6158,
                    group = mission.TaskGroup.OBJ_ALL_80BF6158.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80BF6158, Slot.SQ_WAVE1_D_80BF6158, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF6158,
                    group = mission.TaskGroup.OBJ_ALL_80BF6158.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80BF6158, Slot.SQ_WAVE1_E_80BF6158, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF6158,
                    group = mission.TaskGroup.OBJ_ALL_80BF6158.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_F_80BF6158, Slot.SQ_WAVE1_F_80BF6158, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF6158,
                    group = mission.TaskGroup.OBJ_ALL_80BF6158.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_G_80BF6158, Slot.SQ_WAVE1_G_80BF6158, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF6158,
                    group = mission.TaskGroup.OBJ_ALL_80BF6158.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_L_80BF6158, Slot.SQ_WAVE1_L_80BF6158, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF6158,
                    group = mission.TaskGroup.OBJ_ALL_80BF6158.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_H_80BF6158, Slot.SQ_WAVE1_H_80BF6158, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF6158,
                    group = mission.TaskGroup.OBJ_ALL_80BF6158.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_I_80BF6158, Slot.SQ_WAVE1_I_80BF6158, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF6158,
                    group = mission.TaskGroup.OBJ_ALL_80BF6158.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_J_80BF6158, Slot.SQ_WAVE1_J_80BF6158, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BF6158,
                    group = mission.TaskGroup.OBJ_ALL_80BF6158.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_K_80BF6158, Slot.SQ_WAVE1_K_80BF6158, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BF6158,
                    group = mission.TaskGroup.OBJ_ALL_80BF6158.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_M_80BF6158, Slot.SQ_WAVE1_M_80BF6158, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BF6158,
                    group = mission.TaskGroup.OBJ_ALL_80BF6158.GROUP_0,
                }),
                unit(Squad.SQ_NIGHTMARES_80BF60E6, Slot.SQ_NIGHTMARES_80BF60E6, {
                    counts = {1},
                    objective = Slot.OBJ_RANGED,
                    group = mission.TaskGroup.OBJ_RANGED.GROUP_0,
                }),
                unit(Squad.SQ_INTRO_THRALL, Slot.SQ_INTRO_THRALL, {
                    counts = {3},
                    objective = Slot.OBJ_INTRO_THRALL,
                    group = mission.TaskGroup.OBJ_INTRO_THRALL.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_A_80BF60E6, Slot.SQ_WAVE1_A_80BF60E6, {
                    counts = {1},
                    objective = Slot.OBJ_RANGED,
                    group = mission.TaskGroup.OBJ_RANGED.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80BF60E6, Slot.SQ_WAVE1_B_80BF60E6, {
                    counts = {1},
                    objective = Slot.OBJ_RANGED,
                    group = mission.TaskGroup.OBJ_RANGED.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_MELEE_A, Slot.SQ_WAVE1_MELEE_A, {
                    counts = {3},
                    objective = Slot.OBJ_MELEE,
                    group = mission.TaskGroup.OBJ_MELEE.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_MELEE_B, Slot.SQ_WAVE1_MELEE_B, {
                    counts = {3},
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
                    counts = {3},
                    objective = Slot.OBJ_MELEE,
                    group = mission.TaskGroup.OBJ_MELEE.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_MELEE_B, Slot.SQ_WAVE3_MELEE_B, {
                    counts = {3},
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
                    counts = {3},
                    objective = Slot.OBJ_MELEE,
                    group = mission.TaskGroup.OBJ_MELEE.GROUP_0,
                }),
                unit(Squad.SQ_WAVE4_MELEE_B, Slot.SQ_WAVE4_MELEE_B, {
                    counts = {3},
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
                unit(Squad.SQ_WAVE4_A_80BF60E6, Slot.SQ_WAVE4_A_80BF60E6, {
                    counts = {1},
                    objective = Slot.OBJ_RANGED,
                    group = mission.TaskGroup.OBJ_RANGED.GROUP_0,
                }),
                unit(Squad.SQ_WAVE4_B_80BF60E6, Slot.SQ_WAVE4_B_80BF60E6, {
                    counts = {1},
                    objective = Slot.OBJ_RANGED,
                    group = mission.TaskGroup.OBJ_RANGED.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80BF60E6, Slot.SQ_BOSS_80BF60E6, {
                    counts = {1},
                    objective = Slot.OBJ_BOSS_80BF60E6,
                    group = mission.TaskGroup.OBJ_BOSS_80BF60E6.GROUP_0,
                }),
            },
        },
        -- Cargo Bay 3.
        [72] = {
            boss = Slot.SQ_BOSS_80BF66AC,
            chest = {Slot.REGION_CHEST_MAJOR2},
            squads = {
                unit(Squad.SQ_WAVE1_A_80BF66AC, Slot.SQ_WAVE1_A_80BF66AC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF66AC,
                    group = mission.TaskGroup.OBJ_ALL_80BF66AC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80BF66AC, Slot.SQ_WAVE1_B_80BF66AC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF66AC,
                    group = mission.TaskGroup.OBJ_ALL_80BF66AC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80BF66AC, Slot.SQ_WAVE1_C_80BF66AC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF66AC,
                    group = mission.TaskGroup.OBJ_ALL_80BF66AC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80BF66AC, Slot.SQ_WAVE1_D_80BF66AC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF66AC,
                    group = mission.TaskGroup.OBJ_ALL_80BF66AC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80BF66AC, Slot.SQ_WAVE1_E_80BF66AC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF66AC,
                    group = mission.TaskGroup.OBJ_ALL_80BF66AC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_F_80BF66AC, Slot.SQ_WAVE1_F_80BF66AC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF66AC,
                    group = mission.TaskGroup.OBJ_ALL_80BF66AC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_G_80BF66AC, Slot.SQ_WAVE1_G_80BF66AC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF66AC,
                    group = mission.TaskGroup.OBJ_ALL_80BF66AC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_H_80BF66AC, Slot.SQ_WAVE1_H_80BF66AC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF66AC,
                    group = mission.TaskGroup.OBJ_ALL_80BF66AC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_I_80BF66AC, Slot.SQ_WAVE1_I_80BF66AC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF66AC,
                    group = mission.TaskGroup.OBJ_ALL_80BF66AC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_J_80BF66AC, Slot.SQ_WAVE1_J_80BF66AC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF66AC,
                    group = mission.TaskGroup.OBJ_ALL_80BF66AC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_K_80BF66AC, Slot.SQ_WAVE1_K_80BF66AC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF66AC,
                    group = mission.TaskGroup.OBJ_ALL_80BF66AC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_L_80BF66AC, Slot.SQ_WAVE1_L_80BF66AC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF66AC,
                    group = mission.TaskGroup.OBJ_ALL_80BF66AC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_M_80BF66AC, Slot.SQ_WAVE1_M_80BF66AC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF66AC,
                    group = mission.TaskGroup.OBJ_ALL_80BF66AC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_A_80BF66AC, Slot.SQ_WAVE2_A_80BF66AC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF66AC,
                    group = mission.TaskGroup.OBJ_ALL_80BF66AC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_B_80BF66AC, Slot.SQ_WAVE2_B_80BF66AC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF66AC,
                    group = mission.TaskGroup.OBJ_ALL_80BF66AC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_C_80BF66AC, Slot.SQ_WAVE2_C_80BF66AC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF66AC,
                    group = mission.TaskGroup.OBJ_ALL_80BF66AC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_D_80BF66AC, Slot.SQ_WAVE2_D_80BF66AC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF66AC,
                    group = mission.TaskGroup.OBJ_ALL_80BF66AC.GROUP_0,
                }),
                unit(Squad.SQ_NIGHTMARES_80BF66AC, Slot.SQ_NIGHTMARES_80BF66AC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF66AC,
                    group = mission.TaskGroup.OBJ_ALL_80BF66AC.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_E_80BF66AC, Slot.SQ_WAVE2_E_80BF66AC, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BF66AC,
                    group = mission.TaskGroup.OBJ_ALL_80BF66AC.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80BF66AC, Slot.SQ_BOSS_80BF66AC, {
                    counts = {1},
                    objective = Slot.OBJ_BOSS_80BF66AC,
                    group = mission.TaskGroup.OBJ_BOSS_80BF66AC.GROUP_0,
                }),
            },
        },
    }
end
