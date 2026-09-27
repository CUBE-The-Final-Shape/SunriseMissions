-- Lost Sector encounter choices; live parity remains unverified.
return function(mission, freeroam)
    local Slot, Squad = mission.Slot, mission.Squad
    local unit = freeroam.unit
    return {
        -- Pariah's Refuge.
        [128] = {
            boss = Slot.SQ_BOSS_80F5E6A5,
            chest = {Slot.DUNGEON_CHEST},
            squads = {
                unit(Squad.SQ_HALL_1, Slot.SQ_HALL_1, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F5E6F5,
                    group = mission.TaskGroup.OBJ_ALL_80F5E6F5.GROUP_0,
                }),
                unit(Squad.SQ_HALL_2, Slot.SQ_HALL_2, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80F5E6F5,
                    group = mission.TaskGroup.OBJ_ALL_80F5E6F5.GROUP_0,
                }),
                unit(Squad.SQ_HALL_3, Slot.SQ_HALL_3, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80F5E6F5,
                    group = mission.TaskGroup.OBJ_ALL_80F5E6F5.GROUP_0,
                }),
                unit(Squad.SQ_HALL_4, Slot.SQ_HALL_4, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80F5E6F5,
                    group = mission.TaskGroup.OBJ_ALL_80F5E6F5.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_1, Slot.SQ_CHAMBER_1, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F5E6F5,
                    group = mission.TaskGroup.OBJ_ALL_80F5E6F5.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_2, Slot.SQ_CHAMBER_2, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F5E6F5,
                    group = mission.TaskGroup.OBJ_ALL_80F5E6F5.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_3, Slot.SQ_CHAMBER_3, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80F5E6F5,
                    group = mission.TaskGroup.OBJ_ALL_80F5E6F5.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_4, Slot.SQ_CHAMBER_4, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80F5E6F5,
                    group = mission.TaskGroup.OBJ_ALL_80F5E6F5.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_B_1, Slot.SQ_CHAMBER_B_1, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F5E6F5,
                    group = mission.TaskGroup.OBJ_ALL_80F5E6F5.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_B_2, Slot.SQ_CHAMBER_B_2, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80F5E6F5,
                    group = mission.TaskGroup.OBJ_ALL_80F5E6F5.GROUP_0,
                }),
                unit(Squad.SQ_CHAMBER_B_3, Slot.SQ_CHAMBER_B_3, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80F5E6F5,
                    group = mission.TaskGroup.OBJ_ALL_80F5E6F5.GROUP_0,
                }),
                unit(Squad.SQ_GUARDS, Slot.SQ_GUARDS, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80F5E6A5,
                    group = mission.TaskGroup.OBJ_ALL_80F5E6A5.GROUP_0,
                }),
                unit(Squad.SQ_SNIPER_1, Slot.SQ_SNIPER_1, {
                    counts = {1},
                    objective = Slot.OBJ_ALL_80F5E6A5,
                    group = mission.TaskGroup.OBJ_ALL_80F5E6A5.GROUP_0,
                }),
                unit(Squad.SQ_WAVE_A_1, Slot.SQ_WAVE_A_1, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F5E6A5,
                    group = mission.TaskGroup.OBJ_ALL_80F5E6A5.GROUP_0,
                }),
                unit(Squad.SQ_WAVE_A_2, Slot.SQ_WAVE_A_2, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F5E6A5,
                    group = mission.TaskGroup.OBJ_ALL_80F5E6A5.GROUP_0,
                }),
                unit(Squad.SQ_WAVE_A_3, Slot.SQ_WAVE_A_3, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F5E6A5,
                    group = mission.TaskGroup.OBJ_ALL_80F5E6A5.GROUP_0,
                }),
                unit(Squad.SQ_WAVE_A_4, Slot.SQ_WAVE_A_4, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F5E6A5,
                    group = mission.TaskGroup.OBJ_ALL_80F5E6A5.GROUP_0,
                }),
                unit(Squad.SQ_WAVE_B_1, Slot.SQ_WAVE_B_1, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80F5E6A5,
                    group = mission.TaskGroup.OBJ_ALL_80F5E6A5.GROUP_0,
                }),
                unit(Squad.SQ_WAVE_B_2, Slot.SQ_WAVE_B_2, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80F5E6A5,
                    group = mission.TaskGroup.OBJ_ALL_80F5E6A5.GROUP_0,
                }),
                unit(Squad.SQ_WAVE_C_1, Slot.SQ_WAVE_C_1, {
                    counts = {2},
                    objective = Slot.OBJ_ALL_80F5E6A5,
                    group = mission.TaskGroup.OBJ_ALL_80F5E6A5.GROUP_0,
                }),
                unit(Squad.SQ_WAVE_C_2, Slot.SQ_WAVE_C_2, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ALL_80F5E6A5,
                    group = mission.TaskGroup.OBJ_ALL_80F5E6A5.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80F5E6A5, Slot.SQ_BOSS_80F5E6A5, {
                    counts = {1},
                    objective = Slot.OBJ_BOSS,
                    group = mission.TaskGroup.OBJ_BOSS.GROUP_0,
                }),
            },
        },
    }
end
