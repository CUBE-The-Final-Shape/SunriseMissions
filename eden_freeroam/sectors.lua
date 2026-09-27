-- Lost Sector encounter choices; live parity remains unverified.
return function(mission, freeroam)
    local Slot, Squad = mission.Slot, mission.Squad
    local unit = freeroam.unit
    return {
        -- Sanctum of Bones.
        [40] = {
            boss = Slot.SQ_BOSS_80BD76CA,
            chest = {Slot.REGION_CHEST_MAJOR1_80BD7F6D},
            squads = {
                unit(Squad.SQ_WAVE1_A_80BD760C, Slot.SQ_WAVE1_A_80BD760C, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BD760C,
                    group = mission.TaskGroup.OBJ_ALL_80BD760C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80BD760C, Slot.SQ_WAVE1_B_80BD760C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD760C,
                    group = mission.TaskGroup.OBJ_ALL_80BD760C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80BD760C, Slot.SQ_WAVE1_C_80BD760C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD760C,
                    group = mission.TaskGroup.OBJ_ALL_80BD760C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80BD760C, Slot.SQ_WAVE1_D_80BD760C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD760C,
                    group = mission.TaskGroup.OBJ_ALL_80BD760C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80BD760C, Slot.SQ_WAVE1_E_80BD760C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD760C,
                    group = mission.TaskGroup.OBJ_ALL_80BD760C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_F_80BD760C, Slot.SQ_WAVE1_F_80BD760C, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BD760C,
                    group = mission.TaskGroup.OBJ_ALL_80BD760C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_G_80BD760C, Slot.SQ_WAVE1_G_80BD760C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD760C,
                    group = mission.TaskGroup.OBJ_ALL_80BD760C.GROUP_0,
                }),
                unit(Squad.SQ_NIGHTMARES_80BD76CA, Slot.SQ_NIGHTMARES_80BD76CA, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BD76CA,
                    group = mission.TaskGroup.OBJ_ALL_80BD76CA.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_A_80BD76CA, Slot.SQ_WAVE1_A_80BD76CA, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD76CA,
                    group = mission.TaskGroup.OBJ_ALL_80BD76CA.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80BD76CA, Slot.SQ_WAVE1_B_80BD76CA, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD76CA,
                    group = mission.TaskGroup.OBJ_ALL_80BD76CA.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80BD76CA, Slot.SQ_WAVE1_C_80BD76CA, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD76CA,
                    group = mission.TaskGroup.OBJ_ALL_80BD76CA.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80BD76CA, Slot.SQ_WAVE1_D_80BD76CA, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD76CA,
                    group = mission.TaskGroup.OBJ_ALL_80BD76CA.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80BD76CA, Slot.SQ_WAVE1_E_80BD76CA, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD76CA,
                    group = mission.TaskGroup.OBJ_ALL_80BD76CA.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_F_80BD76CA, Slot.SQ_WAVE1_F_80BD76CA, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD76CA,
                    group = mission.TaskGroup.OBJ_ALL_80BD76CA.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_G_80BD76CA, Slot.SQ_WAVE1_G_80BD76CA, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD76CA,
                    group = mission.TaskGroup.OBJ_ALL_80BD76CA.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_H_80BD76CA, Slot.SQ_WAVE1_H_80BD76CA, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD76CA,
                    group = mission.TaskGroup.OBJ_ALL_80BD76CA.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_I, Slot.SQ_WAVE1_I, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD76CA,
                    group = mission.TaskGroup.OBJ_ALL_80BD76CA.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_J, Slot.SQ_WAVE1_J, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80BD76CA,
                    group = mission.TaskGroup.OBJ_ALL_80BD76CA.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_A_80BD76CA, Slot.SQ_WAVE2_A_80BD76CA, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD76CA,
                    group = mission.TaskGroup.OBJ_ALL_80BD76CA.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_B_80BD76CA, Slot.SQ_WAVE2_B_80BD76CA, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD76CA,
                    group = mission.TaskGroup.OBJ_ALL_80BD76CA.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_C, Slot.SQ_WAVE2_C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD76CA,
                    group = mission.TaskGroup.OBJ_ALL_80BD76CA.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_A, Slot.SQ_WAVE3_A, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD76CA,
                    group = mission.TaskGroup.OBJ_ALL_80BD76CA.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_B, Slot.SQ_WAVE3_B, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD76CA,
                    group = mission.TaskGroup.OBJ_ALL_80BD76CA.GROUP_0,
                }),
                unit(Squad.SQ_WAVE3_C, Slot.SQ_WAVE3_C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD76CA,
                    group = mission.TaskGroup.OBJ_ALL_80BD76CA.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80BD76CA, Slot.SQ_BOSS_80BD76CA, {
                    counts = {1},
                    objective = Slot.OBJ_BOSS_80BD76CA,
                    group = mission.TaskGroup.OBJ_BOSS_80BD76CA.GROUP_0,
                }),
            },
        },
        -- Aphix Conduit.
        [48] = {
            boss = Slot.SQ_BOSS_80BD7F87,
            chest = {Slot.REGION_CHEST_MAJOR2},
            squads = {
                unit(Squad.SQ_WAVE1_A_80BD8133, Slot.SQ_WAVE1_A_80BD8133, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BD8133,
                    group = mission.TaskGroup.OBJ_ALL_80BD8133.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80BD8133, Slot.SQ_WAVE1_B_80BD8133, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD8133,
                    group = mission.TaskGroup.OBJ_ALL_80BD8133.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80BD8133, Slot.SQ_WAVE1_C_80BD8133, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BD8133,
                    group = mission.TaskGroup.OBJ_ALL_80BD8133.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80BD8133, Slot.SQ_WAVE1_D_80BD8133, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BD8133,
                    group = mission.TaskGroup.OBJ_ALL_80BD8133.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80BD8133, Slot.SQ_WAVE1_E_80BD8133, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD8133,
                    group = mission.TaskGroup.OBJ_ALL_80BD8133.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_A_80BD8133, Slot.SQ_WAVE2_A_80BD8133, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BD8133,
                    group = mission.TaskGroup.OBJ_ALL_80BD8133.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_B_80BD8133, Slot.SQ_WAVE2_B_80BD8133, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BD8133,
                    group = mission.TaskGroup.OBJ_ALL_80BD8133.GROUP_0,
                }),
                unit(Squad.SQ_PILLAR_A, Slot.SQ_PILLAR_A, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BD8133,
                    group = mission.TaskGroup.OBJ_ALL_80BD8133.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_A_80BD80C0, Slot.SQ_WAVE1_A_80BD80C0, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BD80C0,
                    group = mission.TaskGroup.OBJ_ALL_80BD80C0.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80BD80C0, Slot.SQ_WAVE1_B_80BD80C0, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BD80C0,
                    group = mission.TaskGroup.OBJ_ALL_80BD80C0.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80BD80C0, Slot.SQ_WAVE1_C_80BD80C0, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BD80C0,
                    group = mission.TaskGroup.OBJ_ALL_80BD80C0.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80BD80C0, Slot.SQ_WAVE1_D_80BD80C0, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BD80C0,
                    group = mission.TaskGroup.OBJ_ALL_80BD80C0.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80BD80C0, Slot.SQ_WAVE1_E_80BD80C0, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BD80C0,
                    group = mission.TaskGroup.OBJ_ALL_80BD80C0.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_F_80BD80C0, Slot.SQ_WAVE1_F_80BD80C0, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BD80C0,
                    group = mission.TaskGroup.OBJ_ALL_80BD80C0.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_G_80BD80C0, Slot.SQ_WAVE1_G_80BD80C0, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BD80C0,
                    group = mission.TaskGroup.OBJ_ALL_80BD80C0.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_H_80BD80C0, Slot.SQ_WAVE1_H_80BD80C0, {
                    counts = {3},
                    objective = Slot.OBJ_ALL_80BD80C0,
                    group = mission.TaskGroup.OBJ_ALL_80BD80C0.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_A_80BD7F87, Slot.SQ_WAVE1_A_80BD7F87, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD7F87,
                    group = mission.TaskGroup.OBJ_ALL_80BD7F87.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80BD7F87, Slot.SQ_WAVE1_B_80BD7F87, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD7F87,
                    group = mission.TaskGroup.OBJ_ALL_80BD7F87.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80BD7F87, Slot.SQ_WAVE1_C_80BD7F87, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BD7F87,
                    group = mission.TaskGroup.OBJ_ALL_80BD7F87.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80BD7F87, Slot.SQ_WAVE1_D_80BD7F87, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BD7F87,
                    group = mission.TaskGroup.OBJ_ALL_80BD7F87.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80BD7F87, Slot.SQ_WAVE1_E_80BD7F87, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BD7F87,
                    group = mission.TaskGroup.OBJ_ALL_80BD7F87.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80BD7F87, Slot.SQ_BOSS_80BD7F87, {
                    counts = {1},
                    objective = Slot.OBJ_BOSS_80BD7F87,
                    group = mission.TaskGroup.OBJ_BOSS_80BD7F87.GROUP_0,
                }),
            },
        },
        -- Grove of Ulan-Tan.
        [144] = {
            boss = Slot.SQ_BOSS_80BD9B3C,
            chest = {Slot.REGION_CHEST_MAJOR1_80C36427},
            squads = {
                unit(Squad.SQ_WAVE1_A_80BD99FF, Slot.SQ_WAVE1_A_80BD99FF, {
                    counts = {1, 2},
                    objective = Slot.OBJ_ALL_80BD99FF,
                    group = mission.TaskGroup.OBJ_ALL_80BD99FF.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80BD99FF, Slot.SQ_WAVE1_B_80BD99FF, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD99FF,
                    group = mission.TaskGroup.OBJ_ALL_80BD99FF.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_A_80BD9A50, Slot.SQ_WAVE1_A_80BD9A50, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BD9A50,
                    group = mission.TaskGroup.OBJ_ALL_80BD9A50.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80BD9A50, Slot.SQ_WAVE1_B_80BD9A50, {
                    counts = {1, 2},
                    objective = Slot.OBJ_ALL_80BD9A50,
                    group = mission.TaskGroup.OBJ_ALL_80BD9A50.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80BD9A50, Slot.SQ_WAVE1_C_80BD9A50, {
                    counts = {1, 2},
                    objective = Slot.OBJ_ALL_80BD9A50,
                    group = mission.TaskGroup.OBJ_ALL_80BD9A50.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80BD9A50, Slot.SQ_WAVE1_D_80BD9A50, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD9A50,
                    group = mission.TaskGroup.OBJ_ALL_80BD9A50.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80BD9A50, Slot.SQ_WAVE1_E_80BD9A50, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD9A50,
                    group = mission.TaskGroup.OBJ_ALL_80BD9A50.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_F_80BD9A50, Slot.SQ_WAVE1_F_80BD9A50, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD9A50,
                    group = mission.TaskGroup.OBJ_ALL_80BD9A50.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_A_80BD9B57, Slot.SQ_WAVE1_A_80BD9B57, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD9B57,
                    group = mission.TaskGroup.OBJ_ALL_80BD9B57.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80BD9B57, Slot.SQ_WAVE1_B_80BD9B57, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD9B57,
                    group = mission.TaskGroup.OBJ_ALL_80BD9B57.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80BD9B57, Slot.SQ_WAVE1_C_80BD9B57, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD9B57,
                    group = mission.TaskGroup.OBJ_ALL_80BD9B57.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80BD9B57, Slot.SQ_WAVE1_D_80BD9B57, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD9B57,
                    group = mission.TaskGroup.OBJ_ALL_80BD9B57.GROUP_0,
                }),
                unit(Squad.SQ_HALL_A, Slot.SQ_HALL_A, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD9B3C,
                    group = mission.TaskGroup.OBJ_ALL_80BD9B3C.GROUP_0,
                }),
                unit(Squad.SQ_NIGHTMARES_80BD9B3C, Slot.SQ_NIGHTMARES_80BD9B3C, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BD9B3C,
                    group = mission.TaskGroup.OBJ_ALL_80BD9B3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_A_80BD9B3C, Slot.SQ_WAVE1_A_80BD9B3C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD9B3C,
                    group = mission.TaskGroup.OBJ_ALL_80BD9B3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_B_80BD9B3C, Slot.SQ_WAVE1_B_80BD9B3C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD9B3C,
                    group = mission.TaskGroup.OBJ_ALL_80BD9B3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_C_80BD9B3C, Slot.SQ_WAVE1_C_80BD9B3C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD9B3C,
                    group = mission.TaskGroup.OBJ_ALL_80BD9B3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_D_80BD9B3C, Slot.SQ_WAVE1_D_80BD9B3C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD9B3C,
                    group = mission.TaskGroup.OBJ_ALL_80BD9B3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_E_80BD9B3C, Slot.SQ_WAVE1_E_80BD9B3C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD9B3C,
                    group = mission.TaskGroup.OBJ_ALL_80BD9B3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE1_F_80BD9B3C, Slot.SQ_WAVE1_F_80BD9B3C, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80BD9B3C,
                    group = mission.TaskGroup.OBJ_ALL_80BD9B3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_A_80BD9B3C, Slot.SQ_WAVE2_A_80BD9B3C, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80BD9B3C,
                    group = mission.TaskGroup.OBJ_ALL_80BD9B3C.GROUP_0,
                }),
                unit(Squad.SQ_WAVE2_B_80BD9B3C, Slot.SQ_WAVE2_B_80BD9B3C, {
                    counts = {1, 2},
                    objective = Slot.OBJ_ALL_80BD9B3C,
                    group = mission.TaskGroup.OBJ_ALL_80BD9B3C.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80BD9B3C, Slot.SQ_BOSS_80BD9B3C, {
                    counts = {1},
                    objective = Slot.OBJ_BOSS_80BD9B3C,
                    group = mission.TaskGroup.OBJ_BOSS_80BD9B3C.GROUP_0,
                }),
            },
        },
    }
end
