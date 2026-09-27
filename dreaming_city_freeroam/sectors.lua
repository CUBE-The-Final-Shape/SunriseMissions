-- Lost Sector encounter choices; live parity remains unverified.
return function(mission, freeroam)
    local Slot, Squad = mission.Slot, mission.Squad
    local unit = freeroam.unit
    return {
        -- Bay of Drowned Wishes.
        [64] = {
            boss = Slot.SQ_LS_BOSS,
            chest = {Slot.REGION_CHEST_MAJOR1_80F25086},
            squads = {
                unit(Squad.SQ_CRAB_1, Slot.SQ_CRAB_1, {
                    counts = {1},
                    objective = Slot.BEACH_OBJECTIVE,
                    group = mission.TaskGroup.BEACH_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_CRAB_2, Slot.SQ_CRAB_2, {
                    counts = {1},
                    objective = Slot.BEACH_OBJECTIVE,
                    group = mission.TaskGroup.BEACH_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_CRAB_3, Slot.SQ_CRAB_3, {
                    counts = {1},
                    objective = Slot.BEACH_OBJECTIVE,
                    group = mission.TaskGroup.BEACH_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_CRAB_4, Slot.SQ_CRAB_4, {
                    counts = {1},
                    objective = Slot.BEACH_OBJECTIVE,
                    group = mission.TaskGroup.BEACH_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_CRAB_5, Slot.SQ_CRAB_5, {
                    counts = {1},
                    objective = Slot.BEACH_OBJECTIVE,
                    group = mission.TaskGroup.BEACH_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_CRAB_8, Slot.SQ_CRAB_8, {
                    counts = {1},
                    objective = Slot.BEACH_OBJECTIVE,
                    group = mission.TaskGroup.BEACH_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_CRAB_6, Slot.SQ_CRAB_6, {
                    counts = {1},
                    objective = Slot.BEACH_OBJECTIVE,
                    group = mission.TaskGroup.BEACH_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_CRAB_9, Slot.SQ_CRAB_9, {
                    counts = {1},
                    objective = Slot.BEACH_OBJECTIVE,
                    group = mission.TaskGroup.BEACH_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_CRAB_7, Slot.SQ_CRAB_7, {
                    counts = {1},
                    objective = Slot.BEACH_OBJECTIVE,
                    group = mission.TaskGroup.BEACH_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_CRAB_10, Slot.SQ_CRAB_10, {
                    counts = {1},
                    objective = Slot.BEACH_OBJECTIVE,
                    group = mission.TaskGroup.BEACH_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_SNIPER_1_80F25045, Slot.SQ_SNIPER_1_80F25045, {
                    counts = {1},
                    objective = Slot.BEACH_OBJECTIVE,
                    group = mission.TaskGroup.BEACH_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_SNIPER_2_80F25045, Slot.SQ_SNIPER_2_80F25045, {
                    counts = {1},
                    objective = Slot.BEACH_OBJECTIVE,
                    group = mission.TaskGroup.BEACH_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_DOOR_GUARDS, Slot.SQ_DOOR_GUARDS, {
                    counts = {3},
                    objective = Slot.BEACH_OBJECTIVE,
                    group = mission.TaskGroup.BEACH_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_BEACH_GREETERS, Slot.SQ_BEACH_GREETERS, {
                    counts = {4, 1},
                    objective = Slot.BEACH_OBJECTIVE,
                    group = mission.TaskGroup.BEACH_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_CAPTAIN_1, Slot.SQ_CAPTAIN_1, {
                    counts = {1},
                    objective = Slot.BEACH_OBJECTIVE,
                    group = mission.TaskGroup.BEACH_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_CAPTAIN_2, Slot.SQ_CAPTAIN_2, {
                    counts = {1},
                    objective = Slot.BEACH_OBJECTIVE,
                    group = mission.TaskGroup.BEACH_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_CAPTAIN_3, Slot.SQ_CAPTAIN_3, {
                    counts = {1},
                    objective = Slot.BEACH_OBJECTIVE,
                    group = mission.TaskGroup.BEACH_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_LS_BOSS, Slot.SQ_LS_BOSS, {
                    counts = {1},
                    objective = Slot.BOSS_OBJECTIVE,
                    group = mission.TaskGroup.BOSS_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_EXPLODERS_1, Slot.SQ_BOSS_EXPLODERS_1, {
                    counts = {1},
                    objective = Slot.BOSS_OBJECTIVE,
                    group = mission.TaskGroup.BOSS_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_EXPLODERS_2, Slot.SQ_BOSS_EXPLODERS_2, {
                    counts = {1},
                    objective = Slot.BOSS_OBJECTIVE,
                    group = mission.TaskGroup.BOSS_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_ROOM_RANGED, Slot.SQ_BOSS_ROOM_RANGED, {
                    counts = {2},
                    objective = Slot.BOSS_OBJECTIVE,
                    group = mission.TaskGroup.BOSS_OBJECTIVE.GROUP_0,
                }),
            },
        },
        -- Chamber of Starlight.
        [72] = {
            -- Absent: SQ_TURRET_L has no generated squad.
            -- Absent: SQ_TURRET_R has no generated squad.
            boss = Slot.SQ_BOSS_80F25324,
            chest = {Slot.REGION_CHEST_MAJOR1_80F25376},
            squads = {
                unit(Squad.SQ_BOSS_80F25324, Slot.SQ_BOSS_80F25324, {
                    counts = {1},
                    objective = Slot.FINALE_OBJECTIVE,
                    group = mission.TaskGroup.FINALE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_ADD, Slot.SQ_BOSS_ADD, {
                    counts = {1},
                    objective = Slot.FINALE_OBJECTIVE,
                    group = mission.TaskGroup.FINALE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_ADD_2, Slot.SQ_BOSS_ADD_2, {
                    counts = {5},
                    objective = Slot.FINALE_OBJECTIVE,
                    group = mission.TaskGroup.FINALE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_THRALL_L, Slot.SQ_THRALL_L, {
                    counts = {6},
                    objective = Slot.FINALE_OBJECTIVE,
                    group = mission.TaskGroup.FINALE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_THRALL_R, Slot.SQ_THRALL_R, {
                    counts = {6},
                    objective = Slot.FINALE_OBJECTIVE,
                    group = mission.TaskGroup.FINALE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_INF_L, Slot.SQ_INF_L, {
                    counts = {1, 1},
                    objective = Slot.FINALE_OBJECTIVE,
                    group = mission.TaskGroup.FINALE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_INF_R, Slot.SQ_INF_R, {
                    counts = {1},
                    objective = Slot.FINALE_OBJECTIVE,
                    group = mission.TaskGroup.FINALE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_REAR, Slot.SQ_REAR, {
                    counts = {3, 1},
                    objective = Slot.FINALE_OBJECTIVE,
                    group = mission.TaskGroup.FINALE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_SNIPE_80F25324, Slot.SQ_SNIPE_80F25324, {
                    counts = {3},
                    objective = Slot.FINALE_OBJECTIVE,
                    group = mission.TaskGroup.FINALE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_SNIPERS_80F25324, Slot.SQ_BOSS_SNIPERS_80F25324, {
                    counts = {2},
                    objective = Slot.FINALE_OBJECTIVE,
                    group = mission.TaskGroup.FINALE_OBJECTIVE.GROUP_0,
                }),
            },
        },
        -- Aphelion's Rest.
        [80] = {
            boss = Slot.SQ_BOSS_80F255C4,
            chest = {Slot.REGION_CHEST_MAJOR1_80F255FC},
            squads = {
                unit(Squad.SQ_FRONT_1, Slot.SQ_FRONT_1, {
                    counts = {1},
                    objective = Slot.MAZE_OBJECTIVE,
                    group = mission.TaskGroup.MAZE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_FRONT_1_TURRET, Slot.SQ_FRONT_1_TURRET, {
                    counts = {1},
                    objective = Slot.MAZE_OBJECTIVE,
                    group = mission.TaskGroup.MAZE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_FRONT_3, Slot.SQ_FRONT_3, {
                    counts = {1},
                    objective = Slot.MAZE_OBJECTIVE,
                    group = mission.TaskGroup.MAZE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_FRONT_3_TURRET, Slot.SQ_FRONT_3_TURRET, {
                    counts = {1},
                    objective = Slot.MAZE_OBJECTIVE,
                    group = mission.TaskGroup.MAZE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_FRONT_2, Slot.SQ_FRONT_2, {
                    counts = {1},
                    objective = Slot.MAZE_OBJECTIVE,
                    group = mission.TaskGroup.MAZE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_FRONT_2_TURRET, Slot.SQ_FRONT_2_TURRET, {
                    counts = {1},
                    objective = Slot.MAZE_OBJECTIVE,
                    group = mission.TaskGroup.MAZE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_ANCHOR_80F255C4, Slot.SQ_ANCHOR_80F255C4, {
                    counts = {1},
                    objective = Slot.MAZE_OBJECTIVE,
                    group = mission.TaskGroup.MAZE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_PSION_1, Slot.SQ_PSION_1, {
                    counts = {3},
                    objective = Slot.MAZE_OBJECTIVE,
                    group = mission.TaskGroup.MAZE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_PSION_2, Slot.SQ_PSION_2, {
                    counts = {3},
                    objective = Slot.MAZE_OBJECTIVE,
                    group = mission.TaskGroup.MAZE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_PSION_3, Slot.SQ_PSION_3, {
                    counts = {2},
                    objective = Slot.MAZE_OBJECTIVE,
                    group = mission.TaskGroup.MAZE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_PHALANX, Slot.SQ_PHALANX, {
                    counts = {1},
                    objective = Slot.MAZE_OBJECTIVE,
                    group = mission.TaskGroup.MAZE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_SNIPE_80F255C4, Slot.SQ_SNIPE_80F255C4, {
                    counts = {2},
                    objective = Slot.MAZE_OBJECTIVE,
                    group = mission.TaskGroup.MAZE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80F255C4, Slot.SQ_BOSS_80F255C4, {
                    counts = {1},
                    objective = Slot.MAZE_OBJECTIVE,
                    group = mission.TaskGroup.MAZE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_THRALL, Slot.SQ_BOSS_THRALL, {
                    counts = {5},
                    objective = Slot.MAZE_OBJECTIVE,
                    group = mission.TaskGroup.MAZE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_ANCHORS, Slot.SQ_BOSS_ANCHORS, {
                    counts = {1},
                    objective = Slot.MAZE_OBJECTIVE,
                    group = mission.TaskGroup.MAZE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_SNIPERS_80F255C4, Slot.SQ_BOSS_SNIPERS_80F255C4, {
                    counts = {3},
                    objective = Slot.MAZE_OBJECTIVE,
                    group = mission.TaskGroup.MAZE_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_PSIONS, Slot.SQ_BOSS_PSIONS, {
                    counts = {2},
                    objective = Slot.MAZE_OBJECTIVE,
                    group = mission.TaskGroup.MAZE_OBJECTIVE.GROUP_0,
                }),
            },
        },
    }
end
