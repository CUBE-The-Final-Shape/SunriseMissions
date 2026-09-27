-- Lost Sector encounter choices; live parity remains unverified.
return function(mission, freeroam)
    local Slot, Squad = mission.Slot, mission.Squad
    local unit = freeroam.unit
    return {
        -- K1 Logistics.
        [8] = {
            -- Absent: FALLEN_NIGHTMARE_GENERATOR_1_SQ_815679F7 has no generated squad.
            -- Absent: FALLEN_NIGHTMARE_GENERATOR_2_SQ has no generated squad.
            boss = Slot.SQU_BOSS,
            chest = {Slot.BOSS_CHEST_81567B34},
            squads = {
                unit(Squad.SQU_ENTRY_MELEE_RIGHT, Slot.SQU_ENTRY_MELEE_RIGHT, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_ENTRY_MELEE_RIGHT_B, Slot.SQU_ENTRY_MELEE_RIGHT_B, {
                    counts = {3},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_ENTRY_MELEE_LEFT, Slot.SQU_ENTRY_MELEE_LEFT, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_ENTRY_SNIPERS_CENTER, Slot.SQU_ENTRY_SNIPERS_CENTER, {
                    counts = {1, 3},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_ENTRY_SNIPERS_LEFT, Slot.SQU_ENTRY_SNIPERS_LEFT, {
                    counts = {4},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_ENTRY_CAPTAIN, Slot.SQU_ENTRY_CAPTAIN, {
                    counts = {1, 4},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_GARAGE_SNIPERS_TOP, Slot.SQU_GARAGE_SNIPERS_TOP, {
                    counts = {2},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_GARAGE_EXPLODERS, Slot.SQU_GARAGE_EXPLODERS, {
                    counts = {3},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_GARAGE_EXPLODERS_1, Slot.SQU_GARAGE_EXPLODERS_1, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_GARAGE_EXPLODERS_2, Slot.SQU_GARAGE_EXPLODERS_2, {
                    counts = {2},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_GARAGE_EXPLODERS_3, Slot.SQU_GARAGE_EXPLODERS_3, {
                    counts = {3},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_GARAGE_EXPLODERS_4, Slot.SQU_GARAGE_EXPLODERS_4, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_GARAGE_EXPLODERS_5, Slot.SQU_GARAGE_EXPLODERS_5, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_GARAGE_SUPPORT_HI, Slot.SQU_GARAGE_SUPPORT_HI, {
                    counts = {2, 3},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_GARAGE_SUPPORT_LOW, Slot.SQU_GARAGE_SUPPORT_LOW, {
                    counts = {2, 2, 2},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_GARAGE_CAPTAIN, Slot.SQU_GARAGE_CAPTAIN, {
                    counts = {1, 4, 3},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_GARAGE_SHANK_SNIPERS, Slot.SQU_GARAGE_SHANK_SNIPERS, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_GARAGE_SHANK_SNIPERS_1, Slot.SQU_GARAGE_SHANK_SNIPERS_1, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_GARAGE_SHANKS, Slot.SQU_GARAGE_SHANKS, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_ARC_ENTRY_1, Slot.SQU_ARC_ENTRY_1, {
                    counts = {1, 1, 1},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_ARC_ENTRY, Slot.SQU_ARC_ENTRY, {
                    counts = {1, 1, 1},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_ARC_DREGS_B, Slot.SQU_ARC_DREGS_B, {
                    counts = {2, 4, 1},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_NM01_WAVE01, Slot.SQU_NM01_WAVE01, {
                    counts = {4, 4},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_NM01_WAVE02, Slot.SQU_NM01_WAVE02, {
                    counts = {4, 3},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_BOSS_SUPPORT_B, Slot.SQU_BOSS_SUPPORT_B, {
                    counts = {4, 3, 3},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_NM02_WAVE01, Slot.SQU_NM02_WAVE01, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_NM02_WAVE02, Slot.SQU_NM02_WAVE02, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_NM02_WAVE03, Slot.SQU_NM02_WAVE03, {
                    counts = {1, 2},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_BOSS_SUPPORT_A, Slot.SQU_BOSS_SUPPORT_A, {
                    counts = {2, 2},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_BOSS_SHIELD_A, Slot.SQU_BOSS_SHIELD_A, {
                    counts = {3, 1},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_BOSS_SHIELD_B, Slot.SQU_BOSS_SHIELD_B, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_BOSS_PLATFORM, Slot.SQU_BOSS_PLATFORM, {
                    counts = {4, 2},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                }),
                unit(Squad.SQU_BOSS, Slot.SQU_BOSS, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRY,
                    group = mission.TaskGroup.OBJ_ENTRY.GROUP_0,
                    member = Slot.SQU_BOSS_BOSS,
                }),
            },
        },
        -- K1 Revelation.
        [32] = {
            -- Absent: SQ_DIG_FILL_1 has no generated squad.
            -- Absent: SQ_DIG_FILL_2 has no generated squad.
            -- Absent: SQ_DIG_FILL_3 has no generated squad.
            -- Absent: SQ_DIG_FILL_4 has no generated squad.
            -- Absent: SQ_DIG_FILL_5 has no generated squad.
            -- Absent: DIG_NIGHTMARE_GENERATOR_SQ has no generated squad.
            boss = Slot.SQ_DIG_BOSS,
            chest = {Slot.BOSS_CHEST_8157022B},
            squads = {
                unit(Squad.SQ_HALL_A_1, Slot.SQ_HALL_A_1, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_HALL_A_2, Slot.SQ_HALL_A_2, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_HALL_A_3, Slot.SQ_HALL_A_3, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_HALL_A_4, Slot.SQ_HALL_A_4, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_HALL_A_5, Slot.SQ_HALL_A_5, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_HALL_A_6, Slot.SQ_HALL_A_6, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_HALL_A_ANCHOR, Slot.SQ_HALL_A_ANCHOR, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_HALL_B_1, Slot.SQ_HALL_B_1, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_HALL_B_2, Slot.SQ_HALL_B_2, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_HALL_B_3, Slot.SQ_HALL_B_3, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_BRIDGE_1_8157011D, Slot.SQ_BRIDGE_1_8157011D, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_BRIDGE_2, Slot.SQ_BRIDGE_2, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_BRIDGE_3, Slot.SQ_BRIDGE_3, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_BRIDGE_SHRIEKER, Slot.SQ_BRIDGE_SHRIEKER, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_FILL_6, Slot.SQ_DIG_FILL_6, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_FILL_7, Slot.SQ_DIG_FILL_7, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_FILL_8, Slot.SQ_DIG_FILL_8, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_FILL_9, Slot.SQ_DIG_FILL_9, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_FILL_10, Slot.SQ_DIG_FILL_10, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_CRYS1_WAVE1_1, Slot.SQ_DIG_CRYS1_WAVE1_1, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_CRYS1_WAVE1_2, Slot.SQ_DIG_CRYS1_WAVE1_2, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_CRYS1_WAVE1_3, Slot.SQ_DIG_CRYS1_WAVE1_3, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_CRYS1_WAVE2_1, Slot.SQ_DIG_CRYS1_WAVE2_1, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_CRYS1_WAVE2_2, Slot.SQ_DIG_CRYS1_WAVE2_2, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_CRYS1_WAVE2_3, Slot.SQ_DIG_CRYS1_WAVE2_3, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_CRYS1_ANCHOR, Slot.SQ_DIG_CRYS1_ANCHOR, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_CRYS2_WAVE1_1, Slot.SQ_DIG_CRYS2_WAVE1_1, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_CRYS2_WAVE1_2, Slot.SQ_DIG_CRYS2_WAVE1_2, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_CRYS2_WAVE1_3, Slot.SQ_DIG_CRYS2_WAVE1_3, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_CRYS2_WAVE2_1, Slot.SQ_DIG_CRYS2_WAVE2_1, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_CRYS2_WAVE2_2, Slot.SQ_DIG_CRYS2_WAVE2_2, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_CRYS2_WAVE2_3, Slot.SQ_DIG_CRYS2_WAVE2_3, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_CRYS2_ANCHOR, Slot.SQ_DIG_CRYS2_ANCHOR, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_CRYS3_WAVE1_1, Slot.SQ_DIG_CRYS3_WAVE1_1, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_CRYS3_WAVE1_2, Slot.SQ_DIG_CRYS3_WAVE1_2, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_CRYS3_WAVE1_3, Slot.SQ_DIG_CRYS3_WAVE1_3, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_CRYS3_WAVE2_1, Slot.SQ_DIG_CRYS3_WAVE2_1, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_CRYS3_WAVE2_2, Slot.SQ_DIG_CRYS3_WAVE2_2, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_CRYS3_WAVE2_3, Slot.SQ_DIG_CRYS3_WAVE2_3, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_CRYS3_ANCHOR, Slot.SQ_DIG_CRYS3_ANCHOR, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_WAVE_A_1, Slot.SQ_DIG_WAVE_A_1, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_WAVE_A_2, Slot.SQ_DIG_WAVE_A_2, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_WAVE_A_3, Slot.SQ_DIG_WAVE_A_3, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_WAVE_B_1, Slot.SQ_DIG_WAVE_B_1, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_WAVE_B_2, Slot.SQ_DIG_WAVE_B_2, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_WAVE_B_3, Slot.SQ_DIG_WAVE_B_3, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_WAVE_B_SNIPER, Slot.SQ_DIG_WAVE_B_SNIPER, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_WAVE_C_1, Slot.SQ_DIG_WAVE_C_1, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_WAVE_C_2, Slot.SQ_DIG_WAVE_C_2, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_WAVE_C_3, Slot.SQ_DIG_WAVE_C_3, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_WAVE_C_MELEE, Slot.SQ_DIG_WAVE_C_MELEE, {
                    counts = {6, 1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_WAVE_D_1, Slot.SQ_DIG_WAVE_D_1, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_WAVE_D_2, Slot.SQ_DIG_WAVE_D_2, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_WAVE_D_3, Slot.SQ_DIG_WAVE_D_3, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_WAVE_D_SNIPER, Slot.SQ_DIG_WAVE_D_SNIPER, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                }),
                unit(Squad.SQ_DIG_BOSS, Slot.SQ_DIG_BOSS, {
                    counts = {1},
                    objective = Slot.OBJ_HALL,
                    group = mission.TaskGroup.OBJ_HALL.GROUP_0,
                    member = Slot.SQ_DIG_BOSS_BOSS,
                }),
            },
        },
        -- K1 Crew Quarters.
        [80] = {
            -- Absent: FALLEN_NIGHTMARE_GENERATOR_1_SQ_81571311 has no generated squad.
            boss = Slot.SQ_BOSS_81571311,
            chest = {Slot.BOSS_CHEST_81571412},
            squads = {
                unit(Squad.SQ_ENTRANCE, Slot.SQ_ENTRANCE, {
                    counts = {3},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_ENTRANCE_1, Slot.SQ_ENTRANCE_1, {
                    counts = {1, 2},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_ENTRANCE_2, Slot.SQ_ENTRANCE_2, {
                    counts = {2, 2},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_ENTRANCE_3, Slot.SQ_ENTRANCE_3, {
                    counts = {3},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_ENTRANCE_4, Slot.SQ_ENTRANCE_4, {
                    counts = {4},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_ENTRANCE_5, Slot.SQ_ENTRANCE_5, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_ENTRANCE_6, Slot.SQ_ENTRANCE_6, {
                    counts = {2},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_BRIDGE, Slot.SQ_BRIDGE, {
                    counts = {2},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_BRIDGE_1_81571311, Slot.SQ_BRIDGE_1_81571311, {
                    counts = {2},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_RAVINE, Slot.SQ_RAVINE, {
                    counts = {2, 2},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_RAVINE_1, Slot.SQ_RAVINE_1, {
                    counts = {2},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_RAVINE_2, Slot.SQ_RAVINE_2, {
                    counts = {3},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_RAVINE_3, Slot.SQ_RAVINE_3, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_RAVINE_3B, Slot.SQ_RAVINE_3B, {
                    counts = {2},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_RAVINE_4, Slot.SQ_RAVINE_4, {
                    counts = {3},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_RAVINE_5, Slot.SQ_RAVINE_5, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_RAVINE_6, Slot.SQ_RAVINE_6, {
                    counts = {2, 1},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_RAVINE_7, Slot.SQ_RAVINE_7, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_RAVINE_8, Slot.SQ_RAVINE_8, {
                    counts = {2},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_RAVINE_9, Slot.SQ_RAVINE_9, {
                    counts = {4},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_RAVINE_10, Slot.SQ_RAVINE_10, {
                    counts = {4, 3},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_RAVINE_11, Slot.SQ_RAVINE_11, {
                    counts = {2, 2},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_RAVINE_12, Slot.SQ_RAVINE_12, {
                    counts = {2, 2},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_COLLAPSE, Slot.SQ_COLLAPSE, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_COLLAPSE_1, Slot.SQ_COLLAPSE_1, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_STRUCTURE, Slot.SQ_STRUCTURE, {
                    counts = {4},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_STRUCTURE_1, Slot.SQ_STRUCTURE_1, {
                    counts = {4, 1},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_STRUCTURE_2, Slot.SQ_STRUCTURE_2, {
                    counts = {4, 3},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_STRUCTURE_3, Slot.SQ_STRUCTURE_3, {
                    counts = {3, 3},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_STRUCTURE_4, Slot.SQ_STRUCTURE_4, {
                    counts = {4},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_STRUCTURE_5, Slot.SQ_STRUCTURE_5, {
                    counts = {3},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_STRUCTURE_SLAGS_1, Slot.SQ_STRUCTURE_SLAGS_1, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_81571311, Slot.SQ_BOSS_81571311, {
                    counts = {1},
                    objective = Slot.OBJ_ENTRANCE,
                    group = mission.TaskGroup.OBJ_ENTRANCE.GROUP_0,
                    member = Slot.SQ_BOSS_CELL_1,
                }),
            },
        },
        -- K1 Communion.
        [168] = {
            -- Absent: CORE_NIGHTMARE_GENERATOR_1_SQ has no generated squad.
            boss = Slot.SQ_CORE_BOSS,
            chest = {Slot.BOSS_CHEST_81572CE7},
            squads = {
                unit(Squad.SQ_LOBBY_FRONT, Slot.SQ_LOBBY_FRONT, {
                    counts = {2, 3},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LOBBY_BACK_A_1, Slot.SQ_LOBBY_BACK_A_1, {
                    counts = {4, 2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LOBBY_BACK_A_2, Slot.SQ_LOBBY_BACK_A_2, {
                    counts = {3, 3},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LOBBY_BACK_A_3, Slot.SQ_LOBBY_BACK_A_3, {
                    counts = {3, 2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LOBBY_BACK_B_1, Slot.SQ_LOBBY_BACK_B_1, {
                    counts = {3, 3},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LOBBY_BACK_B_2, Slot.SQ_LOBBY_BACK_B_2, {
                    counts = {2, 2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LOBBY_BACK_C_1, Slot.SQ_LOBBY_BACK_C_1, {
                    counts = {1, 3},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LOBBY_BACK_C_2, Slot.SQ_LOBBY_BACK_C_2, {
                    counts = {2, 2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CONNECTOR_INTRO, Slot.SQ_CONNECTOR_INTRO, {
                    counts = {4},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CONNECTOR_A_1, Slot.SQ_CONNECTOR_A_1, {
                    counts = {2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CONNECTOR_B_1, Slot.SQ_CONNECTOR_B_1, {
                    counts = {2, 2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LABS_FRONT_1, Slot.SQ_LABS_FRONT_1, {
                    counts = {3, 2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LABS_FRONT_2, Slot.SQ_LABS_FRONT_2, {
                    counts = {2, 4},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LABS_FRONT_3, Slot.SQ_LABS_FRONT_3, {
                    counts = {3},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LABS_A_1, Slot.SQ_LABS_A_1, {
                    counts = {2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LABS_A_2, Slot.SQ_LABS_A_2, {
                    counts = {4},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LABS_A_3, Slot.SQ_LABS_A_3, {
                    counts = {2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LABS_A_4, Slot.SQ_LABS_A_4, {
                    counts = {1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LABS_A_SNIPER, Slot.SQ_LABS_A_SNIPER, {
                    counts = {1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LABS_A_ANCHOR, Slot.SQ_LABS_A_ANCHOR, {
                    counts = {1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LABS_A_MELEE, Slot.SQ_LABS_A_MELEE, {
                    counts = {1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LABS_B_1, Slot.SQ_LABS_B_1, {
                    counts = {3},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LABS_B_2, Slot.SQ_LABS_B_2, {
                    counts = {1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LABS_B_3, Slot.SQ_LABS_B_3, {
                    counts = {2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LABS_C_1, Slot.SQ_LABS_C_1, {
                    counts = {2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LABS_C_2, Slot.SQ_LABS_C_2, {
                    counts = {2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LABS_C_3, Slot.SQ_LABS_C_3, {
                    counts = {3},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LABS_C_4, Slot.SQ_LABS_C_4, {
                    counts = {1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_LABS_C_ANCHOR, Slot.SQ_LABS_C_ANCHOR, {
                    counts = {1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_HALLS_ROOM_1A, Slot.SQ_HALLS_ROOM_1A, {
                    counts = {1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_HALLS_ROOM_1B, Slot.SQ_HALLS_ROOM_1B, {
                    counts = {1, 3},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_HALLS_ROOM_2A, Slot.SQ_HALLS_ROOM_2A, {
                    counts = {4, 1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_HALLS_ROOM_2B, Slot.SQ_HALLS_ROOM_2B, {
                    counts = {3, 1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_HALLS_MELEE, Slot.SQ_HALLS_MELEE, {
                    counts = {1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_INITIAL_1, Slot.SQ_CORE_INITIAL_1, {
                    counts = {3, 1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_INITIAL_2, Slot.SQ_CORE_INITIAL_2, {
                    counts = {3, 3},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_PRE_A_1, Slot.SQ_CORE_PRE_A_1, {
                    counts = {3},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_PRE_A_2, Slot.SQ_CORE_PRE_A_2, {
                    counts = {2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_PRE_A_3, Slot.SQ_CORE_PRE_A_3, {
                    counts = {4},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_PRE_A_4, Slot.SQ_CORE_PRE_A_4, {
                    counts = {2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_PRE_A_5, Slot.SQ_CORE_PRE_A_5, {
                    counts = {2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_PRE_B_1, Slot.SQ_CORE_PRE_B_1, {
                    counts = {2, 2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_PRE_B_2, Slot.SQ_CORE_PRE_B_2, {
                    counts = {2, 1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_PRE_B_3, Slot.SQ_CORE_PRE_B_3, {
                    counts = {4, 1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_PRE_B_4, Slot.SQ_CORE_PRE_B_4, {
                    counts = {4, 2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_PRE_B_5, Slot.SQ_CORE_PRE_B_5, {
                    counts = {4, 2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_PRE_C_1, Slot.SQ_CORE_PRE_C_1, {
                    counts = {1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_PRE_C_2, Slot.SQ_CORE_PRE_C_2, {
                    counts = {2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_PRE_C_3, Slot.SQ_CORE_PRE_C_3, {
                    counts = {1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_BOSS, Slot.SQ_CORE_BOSS, {
                    counts = {1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                    member = Slot.SQ_CORE_BOSS_BOSS,
                }),
                unit(Squad.SQ_CORE_WAVE_A_1, Slot.SQ_CORE_WAVE_A_1, {
                    counts = {3},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_WAVE_A_2, Slot.SQ_CORE_WAVE_A_2, {
                    counts = {1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_WAVE_A_3, Slot.SQ_CORE_WAVE_A_3, {
                    counts = {1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_WAVE_A_4, Slot.SQ_CORE_WAVE_A_4, {
                    counts = {4},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_WAVE_B_1, Slot.SQ_CORE_WAVE_B_1, {
                    counts = {3},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_WAVE_B_2, Slot.SQ_CORE_WAVE_B_2, {
                    counts = {2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_WAVE_B_3, Slot.SQ_CORE_WAVE_B_3, {
                    counts = {2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_WAVE_B_4, Slot.SQ_CORE_WAVE_B_4, {
                    counts = {1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_WAVE_C_1, Slot.SQ_CORE_WAVE_C_1, {
                    counts = {1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_WAVE_C_2, Slot.SQ_CORE_WAVE_C_2, {
                    counts = {3},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_WAVE_C_3, Slot.SQ_CORE_WAVE_C_3, {
                    counts = {2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_WAVE_C_4, Slot.SQ_CORE_WAVE_C_4, {
                    counts = {1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_WAVE_D_1, Slot.SQ_CORE_WAVE_D_1, {
                    counts = {2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_WAVE_D_2, Slot.SQ_CORE_WAVE_D_2, {
                    counts = {1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_WAVE_D_3, Slot.SQ_CORE_WAVE_D_3, {
                    counts = {3},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_WAVE_D_4, Slot.SQ_CORE_WAVE_D_4, {
                    counts = {1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_WAVE_E_1, Slot.SQ_CORE_WAVE_E_1, {
                    counts = {1},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_WAVE_E_2, Slot.SQ_CORE_WAVE_E_2, {
                    counts = {2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_WAVE_E_3, Slot.SQ_CORE_WAVE_E_3, {
                    counts = {4},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_WAVE_E_4, Slot.SQ_CORE_WAVE_E_4, {
                    counts = {3},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
                unit(Squad.SQ_CORE_WAVE_E_5, Slot.SQ_CORE_WAVE_E_5, {
                    counts = {2},
                    objective = Slot.OBJ_LOBBY,
                    group = mission.TaskGroup.OBJ_LOBBY.GROUP_0,
                }),
            },
        },
    }
end
