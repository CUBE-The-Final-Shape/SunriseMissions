-- Lost Sector encounter choices; live parity remains unverified.
return function(mission, freeroam)
    local Slot, Squad = mission.Slot, mission.Squad
    local unit = freeroam.unit
    return {
        -- Trapper's Cave.
        [64] = {
            boss = Slot.SQ_DUNGEON_MINIBOSS_1,
            chest = {Slot.REGION_CHEST_MAJOR1_80FD5D26},
            squads = {
                unit(Squad.SQ_HALLWAY_INITIAL_1, Slot.SQ_HALLWAY_INITIAL_1, {
                    counts = {2},
                    objective = Slot.OBJ_AMBIENT_HALLWAY,
                    group = mission.TaskGroup.OBJ_AMBIENT_HALLWAY.GROUP_0,
                }),
                unit(Squad.SQ_HALLWAY_INITIAL_2, Slot.SQ_HALLWAY_INITIAL_2, {
                    counts = {2, 1},
                    objective = Slot.OBJ_AMBIENT_HALLWAY,
                    group = mission.TaskGroup.OBJ_AMBIENT_HALLWAY.GROUP_0,
                }),
                unit(Squad.SQ_HALLWAY_PHALANX_1, Slot.SQ_HALLWAY_PHALANX_1, {
                    counts = {1},
                    objective = Slot.OBJ_AMBIENT_HALLWAY,
                    group = mission.TaskGroup.OBJ_AMBIENT_HALLWAY.GROUP_0,
                }),
                unit(Squad.SQ_HALLWAY_PHALANX_2, Slot.SQ_HALLWAY_PHALANX_2, {
                    counts = {1},
                    objective = Slot.OBJ_AMBIENT_HALLWAY,
                    group = mission.TaskGroup.OBJ_AMBIENT_HALLWAY.GROUP_0,
                }),
                unit(Squad.SQ_HALLWAY_DOGS_1, Slot.SQ_HALLWAY_DOGS_1, {
                    counts = {1},
                    objective = Slot.OBJ_AMBIENT_HALLWAY,
                    group = mission.TaskGroup.OBJ_AMBIENT_HALLWAY.GROUP_0,
                }),
                unit(Squad.SQ_HALLWAY_DOGS_2, Slot.SQ_HALLWAY_DOGS_2, {
                    counts = {1},
                    objective = Slot.OBJ_AMBIENT_HALLWAY,
                    group = mission.TaskGroup.OBJ_AMBIENT_HALLWAY.GROUP_0,
                }),
                unit(Squad.SQ_SLEEPING_DOG_1, Slot.SQ_SLEEPING_DOG_1, {
                    counts = {1},
                    objective = Slot.OBJ_AMBIENT_POND,
                    group = mission.TaskGroup.OBJ_AMBIENT_POND.GROUP_0,
                }),
                unit(Squad.SQ_SLEEPING_DOG_2, Slot.SQ_SLEEPING_DOG_2, {
                    counts = {1},
                    objective = Slot.OBJ_AMBIENT_POND,
                    group = mission.TaskGroup.OBJ_AMBIENT_POND.GROUP_0,
                }),
                unit(Squad.SQ_RUSH_DOG_1, Slot.SQ_RUSH_DOG_1, {
                    counts = {1},
                    objective = Slot.OBJ_AMBIENT_POND,
                    group = mission.TaskGroup.OBJ_AMBIENT_POND.GROUP_0,
                }),
                unit(Squad.SQ_RUSH_DOG_2, Slot.SQ_RUSH_DOG_2, {
                    counts = {1},
                    objective = Slot.OBJ_AMBIENT_POND,
                    group = mission.TaskGroup.OBJ_AMBIENT_POND.GROUP_0,
                }),
                unit(Squad.SQ_RUSH_SNIPER_1, Slot.SQ_RUSH_SNIPER_1, {
                    counts = {2},
                    objective = Slot.OBJ_AMBIENT_POND,
                    group = mission.TaskGroup.OBJ_AMBIENT_POND.GROUP_0,
                }),
                unit(Squad.SQ_RUSH_SNIPER_2, Slot.SQ_RUSH_SNIPER_2, {
                    counts = {1},
                    objective = Slot.OBJ_AMBIENT_POND,
                    group = mission.TaskGroup.OBJ_AMBIENT_POND.GROUP_0,
                }),
                unit(Squad.SQ_WATERFALL_AMBUSH_1, Slot.SQ_WATERFALL_AMBUSH_1, {
                    counts = {1, 2},
                    objective = Slot.OBJ_AMBIENT_POND,
                    group = mission.TaskGroup.OBJ_AMBIENT_POND.GROUP_0,
                }),
                unit(Squad.SQ_WATERFALL_AMBUSH_2, Slot.SQ_WATERFALL_AMBUSH_2, {
                    counts = {1, 2},
                    objective = Slot.OBJ_AMBIENT_POND,
                    group = mission.TaskGroup.OBJ_AMBIENT_POND.GROUP_0,
                }),
                unit(Squad.SQ_WATERFALL_DEFEND_1, Slot.SQ_WATERFALL_DEFEND_1, {
                    counts = {1, 2},
                    objective = Slot.OBJ_AMBIENT_POND,
                    group = mission.TaskGroup.OBJ_AMBIENT_POND.GROUP_0,
                }),
                unit(Squad.SQ_WATERFALL_DEFEND_2, Slot.SQ_WATERFALL_DEFEND_2, {
                    counts = {1, 2},
                    objective = Slot.OBJ_AMBIENT_POND,
                    group = mission.TaskGroup.OBJ_AMBIENT_POND.GROUP_0,
                }),
                unit(Squad.SQ_WATERFALL_DEFEND_3, Slot.SQ_WATERFALL_DEFEND_3, {
                    counts = {1},
                    objective = Slot.OBJ_AMBIENT_POND,
                    group = mission.TaskGroup.OBJ_AMBIENT_POND.GROUP_0,
                }),
                unit(Squad.SQ_FINALE_INITIAL_1, Slot.SQ_FINALE_INITIAL_1, {
                    counts = {1, 2},
                    objective = Slot.OBJ_AMBIENT_FINALE,
                    group = mission.TaskGroup.OBJ_AMBIENT_FINALE.GROUP_0,
                }),
                unit(Squad.SQ_FINALE_INITIAL_2, Slot.SQ_FINALE_INITIAL_2, {
                    counts = {1},
                    objective = Slot.OBJ_AMBIENT_FINALE,
                    group = mission.TaskGroup.OBJ_AMBIENT_FINALE.GROUP_0,
                }),
                unit(Squad.SQ_FINALE_INITIAL_3, Slot.SQ_FINALE_INITIAL_3, {
                    counts = {1, 2},
                    objective = Slot.OBJ_AMBIENT_FINALE,
                    group = mission.TaskGroup.OBJ_AMBIENT_FINALE.GROUP_0,
                }),
                unit(Squad.SQ_DUNGEON_MINIBOSS_1, Slot.SQ_DUNGEON_MINIBOSS_1, {
                    counts = {1},
                    objective = Slot.OBJ_AMBIENT_FINALE,
                    group = mission.TaskGroup.OBJ_AMBIENT_FINALE.GROUP_0,
                }),
            },
        },
        -- Wolfship Turbine.
        [80] = {
            boss = Slot.SQ_OGRE_80FD85BF,
            chest = {Slot.REGION_CHEST_MAJOR1_80FD85CC},
            squads = {
                unit(Squad.SQ_ENTRANCE_THRALLS, Slot.SQ_ENTRANCE_THRALLS, {
                    counts = {6},
                    objective = Slot.LOWER_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.LOWER_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_MIDBOSS, Slot.SQ_MIDBOSS, {
                    counts = {1},
                    objective = Slot.LOWER_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.LOWER_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_ACOLYTE_LOW_1, Slot.SQ_ACOLYTE_LOW_1, {
                    counts = {1},
                    objective = Slot.LOWER_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.LOWER_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_ACOLYTE_LOW_2, Slot.SQ_ACOLYTE_LOW_2, {
                    counts = {1},
                    objective = Slot.LOWER_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.LOWER_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_ACOLYTE_LOW_3, Slot.SQ_ACOLYTE_LOW_3, {
                    counts = {1},
                    objective = Slot.LOWER_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.LOWER_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_ACOLYTE_HIGH, Slot.SQ_ACOLYTE_HIGH, {
                    counts = {1},
                    objective = Slot.LOWER_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.LOWER_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_MIDDLE_PLATFORM, Slot.SQ_MIDDLE_PLATFORM, {
                    counts = {1},
                    objective = Slot.LOWER_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.LOWER_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_THRALL_0, Slot.SQ_THRALL_0, {
                    counts = {5},
                    objective = Slot.UPPER_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.UPPER_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_THRALL_1, Slot.SQ_THRALL_1, {
                    counts = {5},
                    objective = Slot.UPPER_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.UPPER_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_THRALL_2, Slot.SQ_THRALL_2, {
                    counts = {7},
                    objective = Slot.UPPER_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.UPPER_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_ACOLYTE_0, Slot.SQ_ACOLYTE_0, {
                    counts = {1},
                    objective = Slot.UPPER_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.UPPER_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_ACOLYTE_1_80FD85BF, Slot.SQ_ACOLYTE_1_80FD85BF, {
                    counts = {1},
                    objective = Slot.UPPER_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.UPPER_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_ACOLYTE_2_80FD85BF, Slot.SQ_ACOLYTE_2_80FD85BF, {
                    counts = {1},
                    objective = Slot.UPPER_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.UPPER_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_EXPLODER_0, Slot.SQ_EXPLODER_0, {
                    counts = {2},
                    objective = Slot.UPPER_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.UPPER_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_EXPLODER_1_80FD85BF, Slot.SQ_EXPLODER_1_80FD85BF, {
                    counts = {1},
                    objective = Slot.UPPER_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.UPPER_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_OGRE_80FD85BF, Slot.SQ_OGRE_80FD85BF, {
                    counts = {1},
                    objective = Slot.UPPER_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.UPPER_FIGHT_OBJECTIVE.GROUP_0,
                }),
            },
        },
        -- Kingship Dock.
        [120] = {
            boss = Slot.SQ_BOSS_80FD9694,
            chest = {Slot.REGION_CHEST_MAJOR1_80FD96A1},
            squads = {
                unit(Squad.SQ_FRONT_RANGED_1, Slot.SQ_FRONT_RANGED_1, {
                    counts = {4},
                    objective = Slot.OBJ_PORTDUNA,
                    group = mission.TaskGroup.OBJ_PORTDUNA.GROUP_0,
                }),
                unit(Squad.SQ_FRONT_RANGED_2, Slot.SQ_FRONT_RANGED_2, {
                    counts = {4},
                    objective = Slot.OBJ_PORTDUNA,
                    group = mission.TaskGroup.OBJ_PORTDUNA.GROUP_0,
                }),
                unit(Squad.SQ_FRONT_RANGED_3, Slot.SQ_FRONT_RANGED_3, {
                    counts = {3},
                    objective = Slot.OBJ_PORTDUNA,
                    group = mission.TaskGroup.OBJ_PORTDUNA.GROUP_0,
                }),
                unit(Squad.SQ_REINFORCEMENT_1, Slot.SQ_REINFORCEMENT_1, {
                    counts = {1},
                    objective = Slot.OBJ_PORTDUNA,
                    group = mission.TaskGroup.OBJ_PORTDUNA.GROUP_0,
                }),
                unit(Squad.SQ_REINFORCEMENT_2, Slot.SQ_REINFORCEMENT_2, {
                    counts = {3},
                    objective = Slot.OBJ_PORTDUNA,
                    group = mission.TaskGroup.OBJ_PORTDUNA.GROUP_0,
                }),
                unit(Squad.SQ_REINFORCEMENT_3, Slot.SQ_REINFORCEMENT_3, {
                    counts = {3},
                    objective = Slot.OBJ_PORTDUNA,
                    group = mission.TaskGroup.OBJ_PORTDUNA.GROUP_0,
                }),
                unit(Squad.SQ_REINFORCEMENT_4, Slot.SQ_REINFORCEMENT_4, {
                    counts = {3},
                    objective = Slot.OBJ_PORTDUNA,
                    group = mission.TaskGroup.OBJ_PORTDUNA.GROUP_0,
                }),
                unit(Squad.SQ_SNIPER_1_80FD9694, Slot.SQ_SNIPER_1_80FD9694, {
                    counts = {3},
                    objective = Slot.OBJ_PORTDUNA,
                    group = mission.TaskGroup.OBJ_PORTDUNA.GROUP_0,
                }),
                unit(Squad.SQ_SNIPER_2, Slot.SQ_SNIPER_2, {
                    counts = {2},
                    objective = Slot.OBJ_PORTDUNA,
                    group = mission.TaskGroup.OBJ_PORTDUNA.GROUP_0,
                }),
                unit(Squad.SQ_MELEE_80FD9694, Slot.SQ_MELEE_80FD9694, {
                    counts = {1},
                    objective = Slot.OBJ_PORTDUNA,
                    group = mission.TaskGroup.OBJ_PORTDUNA.GROUP_0,
                }),
                unit(Squad.SQ_MAURADER, Slot.SQ_MAURADER, {
                    counts = {1},
                    objective = Slot.OBJ_PORTDUNA,
                    group = mission.TaskGroup.OBJ_PORTDUNA.GROUP_0,
                }),
                unit(Squad.SQ_BOSS_80FD9694, Slot.SQ_BOSS_80FD9694, {
                    counts = {1},
                    objective = Slot.OBJ_PORTDUNA,
                    group = mission.TaskGroup.OBJ_PORTDUNA.GROUP_0,
                }),
            },
        },
        -- The Empty Tank.
        [128] = {
            boss = Slot.SQ_FALLEN_BOSS_1,
            chest = {Slot.TREASURE_CHEST_DUNGEON},
            squads = {
                unit(Squad.SQ_FALLEN_BARTENDER_1, Slot.SQ_FALLEN_BARTENDER_1, {
                    counts = {1},
                    objective = Slot.OBJ_BAR,
                    group = mission.TaskGroup.OBJ_BAR.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_FODDER_1, Slot.SQ_FALLEN_FODDER_1, {
                    counts = {2},
                    objective = Slot.OBJ_BAR,
                    group = mission.TaskGroup.OBJ_BAR.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_FODDER_2, Slot.SQ_FALLEN_FODDER_2, {
                    counts = {2},
                    objective = Slot.OBJ_BAR,
                    group = mission.TaskGroup.OBJ_BAR.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_FODDER_3, Slot.SQ_FALLEN_FODDER_3, {
                    counts = {2},
                    objective = Slot.OBJ_BAR,
                    group = mission.TaskGroup.OBJ_BAR.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_SPECIAL_1, Slot.SQ_FALLEN_SPECIAL_1, {
                    counts = {2},
                    objective = Slot.OBJ_BAR,
                    group = mission.TaskGroup.OBJ_BAR.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_SPECIAL_2, Slot.SQ_FALLEN_SPECIAL_2, {
                    counts = {2},
                    objective = Slot.OBJ_BAR,
                    group = mission.TaskGroup.OBJ_BAR.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_SPECIAL_3, Slot.SQ_FALLEN_SPECIAL_3, {
                    counts = {2},
                    objective = Slot.OBJ_BAR,
                    group = mission.TaskGroup.OBJ_BAR.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_FODDER_4, Slot.SQ_FALLEN_FODDER_4, {
                    counts = {2},
                    objective = Slot.OBJ_BAR,
                    group = mission.TaskGroup.OBJ_BAR.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_FODDER_5, Slot.SQ_FALLEN_FODDER_5, {
                    counts = {2},
                    objective = Slot.OBJ_BAR,
                    group = mission.TaskGroup.OBJ_BAR.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_SPECIAL_4, Slot.SQ_FALLEN_SPECIAL_4, {
                    counts = {2},
                    objective = Slot.OBJ_BAR,
                    group = mission.TaskGroup.OBJ_BAR.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_SPECIAL_5, Slot.SQ_FALLEN_SPECIAL_5, {
                    counts = {2},
                    objective = Slot.OBJ_BAR,
                    group = mission.TaskGroup.OBJ_BAR.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_ANCHOR_1, Slot.SQ_FALLEN_ANCHOR_1, {
                    counts = {1},
                    objective = Slot.OBJ_BAR,
                    group = mission.TaskGroup.OBJ_BAR.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_BOUNCER_1, Slot.SQ_FALLEN_BOUNCER_1, {
                    counts = {1},
                    objective = Slot.OBJ_BAR,
                    group = mission.TaskGroup.OBJ_BAR.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_DJ_1, Slot.SQ_FALLEN_DJ_1, {
                    counts = {1},
                    objective = Slot.OBJ_BAR,
                    group = mission.TaskGroup.OBJ_BAR.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_CUPHOLDER_1, Slot.SQ_FALLEN_CUPHOLDER_1, {
                    counts = {1},
                    objective = Slot.OBJ_BAR,
                    group = mission.TaskGroup.OBJ_BAR.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_CUPHOLDER_2, Slot.SQ_FALLEN_CUPHOLDER_2, {
                    counts = {1},
                    objective = Slot.OBJ_BAR,
                    group = mission.TaskGroup.OBJ_BAR.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_FISTICUFFS_1, Slot.SQ_FALLEN_FISTICUFFS_1, {
                    counts = {2},
                    objective = Slot.OBJ_BAR,
                    group = mission.TaskGroup.OBJ_BAR.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_FISTICUFFS_2, Slot.SQ_FALLEN_FISTICUFFS_2, {
                    counts = {2},
                    objective = Slot.OBJ_BAR,
                    group = mission.TaskGroup.OBJ_BAR.GROUP_0,
                }),
                unit(Squad.SQ_HIVE_RUSHER_1, Slot.SQ_HIVE_RUSHER_1, {
                    counts = {7, 7, 7},
                }),
                unit(Squad.SQ_HIVE_RUSHER_2, Slot.SQ_HIVE_RUSHER_2, {
                    counts = {3},
                }),
                unit(Squad.SQ_HIVE_RUSHER_3, Slot.SQ_HIVE_RUSHER_3, {
                    counts = {3},
                }),
                unit(Squad.SQ_HIVE_RUSHER_4, Slot.SQ_HIVE_RUSHER_4, {
                    counts = {5, 7, 7},
                }),
                unit(Squad.SQ_CABAL_RUSHER_1, Slot.SQ_CABAL_RUSHER_1, {
                    counts = {1, 1, 1, 1, 1},
                }),
                unit(Squad.SQ_CABAL_RUSHER_2, Slot.SQ_CABAL_RUSHER_2, {
                    counts = {1, 1, 1},
                }),
                unit(Squad.SQ_CABAL_RUSHER_3, Slot.SQ_CABAL_RUSHER_3, {
                    counts = {1},
                }),
                unit(Squad.SQ_FORSAKEN_RUSHER_1, Slot.SQ_FORSAKEN_RUSHER_1, {
                    counts = {1, 1, 1},
                }),
                unit(Squad.SQ_FALLEN_EXPLOSIVE_1, Slot.SQ_FALLEN_EXPLOSIVE_1, {
                    counts = {1},
                    objective = Slot.OBJ_ARENA,
                    group = mission.TaskGroup.OBJ_ARENA.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_MELEE_1, Slot.SQ_FALLEN_MELEE_1, {
                    counts = {1},
                    objective = Slot.OBJ_ARENA,
                    group = mission.TaskGroup.OBJ_ARENA.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_MELEE_2, Slot.SQ_FALLEN_MELEE_2, {
                    counts = {1, 1},
                    objective = Slot.OBJ_ARENA,
                    group = mission.TaskGroup.OBJ_ARENA.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_MELEE_3, Slot.SQ_FALLEN_MELEE_3, {
                    counts = {1, 1},
                    objective = Slot.OBJ_ARENA,
                    group = mission.TaskGroup.OBJ_ARENA.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_MELEE_4, Slot.SQ_FALLEN_MELEE_4, {
                    counts = {1},
                    objective = Slot.OBJ_ARENA,
                    group = mission.TaskGroup.OBJ_ARENA.GROUP_0,
                }),
                unit(Squad.SQ_CABAL_RUSHER_4, Slot.SQ_CABAL_RUSHER_4, {
                    counts = {1},
                    objective = Slot.OBJ_ARENA,
                    group = mission.TaskGroup.OBJ_ARENA.GROUP_0,
                }),
                unit(Squad.SQ_CABAL_RUSHER_5, Slot.SQ_CABAL_RUSHER_5, {
                    counts = {1},
                    objective = Slot.OBJ_ARENA,
                    group = mission.TaskGroup.OBJ_ARENA.GROUP_0,
                }),
                unit(Squad.SQ_CABAL_RUSHER_6, Slot.SQ_CABAL_RUSHER_6, {
                    counts = {1},
                    objective = Slot.OBJ_ARENA,
                    group = mission.TaskGroup.OBJ_ARENA.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_SHANK_1, Slot.SQ_FALLEN_SHANK_1, {
                    counts = {1},
                    objective = Slot.OBJ_ARENA,
                    group = mission.TaskGroup.OBJ_ARENA.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_SHANK_2, Slot.SQ_FALLEN_SHANK_2, {
                    counts = {1},
                    objective = Slot.OBJ_ARENA,
                    group = mission.TaskGroup.OBJ_ARENA.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_SPECIAL_6, Slot.SQ_FALLEN_SPECIAL_6, {
                    counts = {1},
                    objective = Slot.OBJ_ARENA,
                    group = mission.TaskGroup.OBJ_ARENA.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_SPECIAL_7, Slot.SQ_FALLEN_SPECIAL_7, {
                    counts = {1},
                    objective = Slot.OBJ_ARENA,
                    group = mission.TaskGroup.OBJ_ARENA.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_SPECIAL_8, Slot.SQ_FALLEN_SPECIAL_8, {
                    counts = {1},
                    objective = Slot.OBJ_ARENA,
                    group = mission.TaskGroup.OBJ_ARENA.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_SPECIAL_9, Slot.SQ_FALLEN_SPECIAL_9, {
                    counts = {1},
                    objective = Slot.OBJ_ARENA,
                    group = mission.TaskGroup.OBJ_ARENA.GROUP_0,
                }),
                unit(Squad.SQ_FALLEN_BOSS_1, Slot.SQ_FALLEN_BOSS_1, {
                    counts = {1},
                    objective = Slot.OBJ_ARENA,
                    group = mission.TaskGroup.OBJ_ARENA.GROUP_0,
                }),
            },
        },
        -- Shipyard AWO-43.
        [152] = {
            boss = Slot.BOSS_SQUAD,
            chest = {Slot.O_DUNGEON_CHEST},
            squads = {
                unit(Squad.SNIPER_1_SQUAD, Slot.SNIPER_1_SQUAD, {
                    counts = {2},
                    objective = Slot.WEBS_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.WEBS_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SNIPER_2_SQUAD, Slot.SNIPER_2_SQUAD, {
                    counts = {1},
                    objective = Slot.WEBS_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.WEBS_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.RANGED_FRONT_SQUAD_1, Slot.RANGED_FRONT_SQUAD_1, {
                    counts = {3},
                    objective = Slot.WEBS_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.WEBS_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.RANGED_FRONT_SQUAD_2, Slot.RANGED_FRONT_SQUAD_2, {
                    counts = {3},
                    objective = Slot.WEBS_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.WEBS_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.RANGED_FRONT_SQUAD_3, Slot.RANGED_FRONT_SQUAD_3, {
                    counts = {1},
                    objective = Slot.WEBS_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.WEBS_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.RANGED_BACK_SQUAD_1, Slot.RANGED_BACK_SQUAD_1, {
                    counts = {1},
                    objective = Slot.WEBS_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.WEBS_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.RANGED_BACK_SQUAD_2, Slot.RANGED_BACK_SQUAD_2, {
                    counts = {3},
                    objective = Slot.WEBS_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.WEBS_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.RANGED_FRONT_SQUAD, Slot.RANGED_FRONT_SQUAD, {
                    counts = {4},
                    objective = Slot.CAVE_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.CAVE_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.RANGED_BACK_SQUAD, Slot.RANGED_BACK_SQUAD, {
                    counts = {4},
                    objective = Slot.CAVE_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.CAVE_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.EXPLODERS_SQUAD, Slot.EXPLODERS_SQUAD, {
                    counts = {2},
                    objective = Slot.CAVE_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.CAVE_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SNIPER_SQUAD, Slot.SNIPER_SQUAD, {
                    counts = {1},
                    objective = Slot.CAVE_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.CAVE_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_SKIFF_1, Slot.SQ_SKIFF_1, {
                    counts = {1},
                    objective = Slot.CAVE_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.CAVE_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SQ_SKIFF_2, Slot.SQ_SKIFF_2, {
                    counts = {1},
                    objective = Slot.CAVE_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.CAVE_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.RANGED_SQUAD_1, Slot.RANGED_SQUAD_1, {
                    counts = {3},
                    objective = Slot.SHIP_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.SHIP_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.RANGED_SQUAD_2, Slot.RANGED_SQUAD_2, {
                    counts = {3},
                    objective = Slot.SHIP_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.SHIP_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.RANGED_SQUAD_3, Slot.RANGED_SQUAD_3, {
                    counts = {3},
                    objective = Slot.SHIP_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.SHIP_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.RANGED_SQUAD_4, Slot.RANGED_SQUAD_4, {
                    counts = {2},
                    objective = Slot.SHIP_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.SHIP_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SNIPER_SQUAD_1_80FDC3A6, Slot.SNIPER_SQUAD_1_80FDC3A6, {
                    counts = {2},
                    objective = Slot.SHIP_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.SHIP_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.SNIPER_SQUAD_2_80FDC3A6, Slot.SNIPER_SQUAD_2_80FDC3A6, {
                    counts = {1},
                    objective = Slot.SHIP_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.SHIP_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.MELEE_SQUAD_80FDC3A6, Slot.MELEE_SQUAD_80FDC3A6, {
                    counts = {1},
                    objective = Slot.SHIP_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.SHIP_FIGHT_OBJECTIVE.GROUP_0,
                }),
                unit(Squad.BOSS_SQUAD, Slot.BOSS_SQUAD, {
                    counts = {1},
                    objective = Slot.SHIP_FIGHT_OBJECTIVE,
                    group = mission.TaskGroup.SHIP_FIGHT_OBJECTIVE.GROUP_0,
                }),
            },
        },
    }
end
