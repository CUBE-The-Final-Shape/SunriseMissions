-- scripts/mission_bacon/rasputin.lua
local lib = require("lib.mission_lib")

return function(mission)
	local Slot = mission.Slot
	return {
		line_sensor_19 = lib.one(mission.DialogueCue.M_DIALOG_SENSOR_80F6A396.CUE_19, "sensor line 19"),
		line_sensor_20 = lib.one(mission.DialogueCue.M_DIALOG_SENSOR_80F6A396.CUE_20, "sensor line 20"),
		line_sensor_21 = lib.one(mission.DialogueCue.M_DIALOG_SENSOR_80F6A396.CUE_21, "sensor line 21"),
		line_sensor_22 = lib.one(mission.DialogueCue.M_DIALOG_SENSOR_80F6A396.CUE_22, "sensor line 22"),
		line_sensor_23 = lib.one(mission.DialogueCue.M_DIALOG_SENSOR_80F6A396.CUE_23, "sensor line 23"),
		line_sensor_24 = lib.one(mission.DialogueCue.M_DIALOG_SENSOR_80F6A396.CUE_24, "sensor line 24"),

		at_spawn_lower_encounters = lib.one(Slot.PT_SPAWN_LOWER_ENCOUNTERS, "spawn lower encounters trigger"),
		at_mus_hive_attack = lib.one(Slot.PT_MUS_HIVE_ATTACK, "hive attack music trigger"),
		at_elevator_seed_props = lib.one(Slot.PT_ELEVATOR_SEED_PROPS, "elevator seed props trigger"),
		at_elevator_spawn_wizards = lib.one(Slot.PT_ELEVATOR_SPAWN_WIZARDS, "elevator spawn wizards trigger"),
		at_elevator_spawn_melee = lib.one(Slot.PT_ELEVATOR_SPAWN_MELEE, "elevator spawn melee trigger"),
		at_ascension_elevator = lib.one(Slot.PT_ASCENSION_ELEVATOR, "ascension elevator trigger"),
		at_spawn_overrides_off = lib.one(Slot.PT_SPAWN_OVERRIDES_OFF, "spawn overrides off trigger"),
		at_pipes_spawn_back = lib.one(Slot.PT_PIPES_SPAWN_BACK, "pipes spawn back trigger"),
		at_spawn_overrides_on = lib.one(Slot.PT_SPAWN_OVERRIDES_ON, "spawn overrides on trigger"),
		at_hive_music_end = lib.one(Slot.PT_HIVE_MUSIC_END, "hive music end trigger"),
		at_ascension_cable = lib.one(Slot.PT_ASCENSION_CABLE, "ascension cable trigger"),
		at_ascension_cable_2 = lib.one(Slot.PT_ASCENSION_CABLE_2, "ascension cable 2 trigger"),
		at_spawn_spear_intro = lib.one(Slot.PT_SPAWN_SPEAR_INTRO, "spawn spear intro trigger"),
		at_left_hive_music_end = lib.one(Slot.PT_LEFT_HIVE_MUSIC_END, "left hive music end trigger"),
		at_left_ascension_cable = lib.one(Slot.PT_LEFT_ASCENSION_CABLE, "left ascension cable trigger"),
		at_left_ascension_cable_2 = lib.one(Slot.PT_LEFT_ASCENSION_CABLE_2, "left ascension cable 2 trigger"),
		at_spawn_spear_intro_alt = lib.one(Slot.PT_SPAWN_SPEAR_INTRO_ALT, "spawn spear intro alt trigger"),
		at_hook_trooper_fallback = lib.one(Slot.PT_HOOK_TROOPER_FALLBACK, "hook trooper fallback trigger"),
		at_hook_spawn_thrall = lib.one(Slot.PT_HOOK_SPAWN_THRALL, "hook spawn thrall trigger"),
		at_hook_spawn_thrall_1 = lib.one(Slot.PT_HOOK_SPAWN_THRALL_1, "hook spawn thrall 1 trigger"),
		at_throne_spawn_encounter = lib.one(Slot.PT_THRONE_SPAWN_ENCOUNTER, "throne spawn encounter trigger"),
		at_spawn_lower_enemies_gate = lib.one(Slot.PT_SPAWN_LOWER_ENEMIES_GATE, "spawn lower enemies gate trigger"),
		at_ascension_left = lib.one(Slot.PT_ASCENSION_LEFT, "ascension left trigger"),
		at_throne_wake_combatants = lib.one(Slot.PT_THRONE_WAKE_COMBATANTS, "throne wake combatants trigger"),
		at_machine_god = lib.one(Slot.PT_MACHINE_GOD, "machine god trigger"),

		o_javelin_hint = lib.one(Slot.O_JAVELIN_HINT, "javelin hint"),
		o_javelin_spawner_landing = lib.one(Slot.O_JAVELIN_SPAWNER_LANDING, "javelin spawner landing"),
		o_javelin_vfx = lib.one(Slot.O_JAVELIN_VFX, "javelin vfx"),
		o_javelin_spawner_lower = lib.one(Slot.O_JAVELIN_SPAWNER_LOWER, "javelin spawner lower"),
		o_javelin_spawner_upper = lib.one(Slot.O_JAVELIN_SPAWNER_UPPER, "javelin spawner upper"),

		d_javelin_door = lib.one(Slot.D_JAVELIN_DOOR, "javelin door"),
		d_door_1 = lib.one(Slot.D_DOOR_1_80F6A334, "door 1"),
		
		arena_elevator = {
			objective = "MAIN_OBJECTIVE_80F6A334",
			WAVE_KEYS = {
				"lower_encounter", "elevator_melee", "elevator_wizards",
			},
			squads = {
				lower_encounter = {
					{squad = "ENTRANCE_TROOPER_SQUAD_A", count = 1, default_group = 0},
					{squad = "ENTRANCE_TROOPER_SQUAD_B", count = 1, default_group = 0},
					{squad = "ELEVATOR_TROOPER_SQUAD_1", count = 1, default_group = 2},
					{squad = "ELEVATOR_TROOPER_SQUAD_2", count = 3, default_group = 3},
					{squad = "ELEVATOR_TROOPER_SQUAD_3", count = 1, default_group = 4},
				},
				elevator_melee = {
					{squad = "ELEVATOR_THRALL_SQUAD_A", count = 1, default_group = 5},
					{squad = "ELEVATOR_THRALL_SQUAD_B", count = 1, default_group = 5},
					{squad = "ELEVATOR_THRALL_SQUAD_C", count = 1, default_group = 5},
				},
				elevator_wizards = {
					{squad = "ELEVATOR_WIZARD_SQUAD_1", count = 1, default_group = 1},
					{squad = "ELEVATOR_WIZARD_SQUAD_2", count = 1, default_group = 1},
				},
			},
		},
		arena_pipes = {
			objective = "MAIN_OBJECTIVE_80F6A334",
			WAVE_KEYS = {
				"pipes_front", "pipes_back",
			},
			squads = {
				pipes_front = {
					{squad = "PIPES_TROOPER_SQUAD_A", count = 2, default_group = 6},
					{squad = "PIPES_TROOPER_SQUAD_B", count = 2, default_group = 7},
				},
				pipes_back = {
					{squad = "PIPES_KNIGHT_SQUAD_A", count = 2, default_group = 8},
					{squad = "PIPES_KNIGHT_SQUAD_B", count = 1, default_group = 9},
				},
			},
		},
		arena_spear_intro = {
			objective = "MAIN_OBJECTIVE_80F6A334",
			squads = {
				{squad = "SPEAR_INTRO_SQUAD_A", count = 1, default_group = 10}, -- Knight
				{squad = "SPEAR_INTRO_SQUAD_B", count = 2, default_group = 11}, -- Acolyte
				{squad = "SPEAR_INTRO_SQUAD_C", count = 1, default_group = 12}, -- Ogre
				{squad = "SPEAR_INTRO_SQUAD_D", count = 1, default_group = 11}, -- Acolyte
				{squad = "SPEAR_INTRO_SQUAD_E", count = 1, default_group = 14}, -- Acolyte, jumps
			},
		},
		arena_lower_gate = {
			objective = "MAIN_OBJECTIVE_80F6A334",
			squads = {
				{squad = "HOOK_TROOPER_A_SQUAD", count = 1, default_group = 15},
				{squad = "HOOK_TROOPER_B_SQUAD", count = 4, default_group = 16},
				{squad = "HOOK_TROOPER_C_SQUAD", count = 3, default_group = 19},
				{squad = "HOOK_TROOPER_D_SQUAD", count = 3, default_group = 18},
			},
		},
		arena_throne = {
			objective = "FINALE_OBJECTIVE",
			WAVE_KEYS = {
				"assault_trooper", "assault_crusader", "assault_thrall",
				"assault_ultra", "assault_sniper", "assault_boomer",
			},
			squads = {
				--[[
				Group
					0 sniper left
					1 sniper right
					2 middle platform
					3 upper platform
					4 lower platform
					5 middle platform
					6 roaming all three platforms
					7 middle platform
					8 lower platform
					9 lower platform
					10 middle platform front right
					11 lower platform
					12 middle platform
					13 upper platform
					14 roaming middle and upper platform
					15 roaming middle and upper platform
					16 roaming middle and upper platform
				]]
				assault_trooper = {
					{squad = "THRONE_ASSAULT_TROOPER_SQUAD_A", count = 1, default_group = 0},
					{squad = "THRONE_ASSAULT_TROOPER_SQUAD_B", count = 1, default_group = 0},
					{squad = "THRONE_ASSAULT_TROOPER_SQUAD_C", count = 1, default_group = 0},
					{squad = "THRONE_ASSAULT_TROOPER_SQUAD_D", count = 1, default_group = 0},
				},
				assault_crusader = {
					{squad = "THRONE_ASSAULT_CRUSADER_SQUAD_A", count = 1, default_group = 0},
					{squad = "THRONE_ASSAULT_CRUSADER_SQUAD_B", count = 1, default_group = 0},
					{squad = "THRONE_ASSAULT_CRUSADER_SQUAD_C", count = 1, default_group = 0},
					{squad = "THRONE_ASSAULT_CRUSADER_SQUAD_D", count = 1, default_group = 0},
				},
				assault_thrall = {
					{squad = "THRONE_ASSAULT_THRALL_SQUAD_A1", count = 1, default_group = 6},
					{squad = "THRONE_ASSAULT_THRALL_SQUAD_A2", count = 1, default_group = 6},
				},
				assault_ultra = {
					{squad = "THRONE_ASSAULT_ULTRA_SQUAD_A", count = 1, default_group = 13},
					{squad = "THRONE_ASSAULT_ULTRA_SQUAD_B", count = 1, default_group = 13},
				},
				assault_sniper = {
					{squad = "THRONE_ASSAULT_SNIPER_SQUAD_A", count = 1, default_group = 0},
					{squad = "THRONE_ASSAULT_SNIPER_SQUAD_B", count = 1, default_group = 1},
				},
				assault_boomer = {
					{squad = "THRONE_ASSAULT_BOOMER_SQUAD_A", count = 2, default_group = 2},
					{squad = "THRONE_ASSAULT_BOOMER_SQUAD_B", count = 2, default_group = 3},
				},
			},
		},
	}
end