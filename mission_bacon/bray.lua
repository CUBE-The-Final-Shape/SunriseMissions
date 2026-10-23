-- scripts/mission_bacon/bray.lua
local lib = require("lib.mission_lib")

return function(mission)
	local Slot = mission.Slot
	return {
		line_sensor_14 = lib.one(mission.DialogueCue.M_DIALOG_SENSOR_80F6A396.CUE_14, "sensor line 14"),

		scene_ana_power_up = lib.one(mission.Scene.SCN_ANA_POWER_UP_BRAY, "ana power up bray scene"),
		scene_ana_squad = lib.one(mission.Squad.SQ_ANA_VIGNETTE, "squad ana scene"),
		scene_ana_power_up_key = 0x8803483C,

		np_goto_bray_168 = lib.one(Slot.NP_GOTO_BRAY_80F6A168, "goto bray navpoint 80F6A168"),
		np_goto_bray_179 = lib.one(Slot.NP_GOTO_BRAY_80F6A179, "goto bray navpoint 80F6A179"),
		np_slot_0015 = lib.one(Slot.SLOT_0015_80F6A179, "slot 0015 navpoint"),
		np_activate_console = lib.one(Slot.NP_ACTIVATE_CONSOLE, "activate console navpoint"),
		np_slot_0014 = lib.one(Slot.SLOT_0014_80F6A179, "slot 0014 navpoint"),

		at_seed_props = lib.one(Slot.PT_SEED_PROPS, "seed props trigger"),
		at_bypass_right = lib.one(Slot.PT_BYPASS_RIGHT, "bypass right trigger"),
		at_bypassed_left = lib.one(Slot.PT_BYPASSED_LEFT, "bypassed left trigger"),
		at_activate_boss_waypoint = lib.one(Slot.PT_ACTIVATE_BOSS_WAYPOINT, "activate boss waypoint trigger"),
		at_start_balcony_monitor = lib.one(Slot.PT_START_BALCONY_MONITOR, "start balcony monitor trigger"),
		at_signal_ana = lib.one(Slot.PT_SIGNAL_ANA, "signal ana trigger"),
		at_end_phase = lib.one(Slot.PT_END_PHASE_80F6A179, "end phase trigger"),

		o_mini_ras_door = lib.one(Slot.O_MINI_RAS_DOOR, "mini ras door"),
		o_seraph_tower_0 = lib.one(Slot.O_SERAPH_TOWER0_80F739EA, "seraph tower 0"),
		o_seraph_tower_1 = lib.one(Slot.O_SERAPH_TOWER1_80F739EA, "seraph tower 1"),
		o_seraph_tower_2 = lib.one(Slot.O_SERAPH_TOWER2_80F739EA, "seraph tower 2"),
		o_seraph_tower_3 = lib.one(Slot.O_SERAPH_TOWER3_80F739EA, "seraph tower 3"),
		o_seraph_tower_4 = lib.one(Slot.O_SERAPH_TOWER4_80F739EA, "seraph tower 4"),
		o_avoidance_0 = lib.one(Slot.O_AVOIDANCE_0_80F739EA, "avoidance 0"),
		o_avoidance_1 = lib.one(Slot.O_AVOIDANCE_1_80F739EA, "avoidance 1"),
		o_avoidance_2 = lib.one(Slot.O_AVOIDANCE_2_80F739EA, "avoidance 2"),
		o_avoidance_3 = lib.one(Slot.O_AVOIDANCE_3_80F739EA, "avoidance 3"),
		o_avoidance_4 = lib.one(Slot.O_AVOIDANCE_4_80F739EA, "avoidance 4"),
		o_start_vignette = lib.one(Slot.O_START_VIGNETTE, "start vignette"),
		o_large_nutblocker = lib.one(Slot.O_LARGE_NUTBLOCKER, "large nutblocker"),
		o_large_nutblocker_2 = lib.one(Slot.O_LARGE_NUTBLOCKER_2, "large nutblocker 2"),
		o_small_nutblocker = lib.one(Slot.O_SMALL_NUTBLOCKER, "small nutblocker"),
		o_small_nutblocker_2 = lib.one(Slot.O_SMALL_NUTBLOCKER_2, "small nutblocker 2"),
		
		o_javelin_floor0_80F739EA = lib.one(Slot.O_JAVELIN_FLOOR0_80F739EA, "javelin floor 0"),
		o_javelin_floor1_80F739EA = lib.one(Slot.O_JAVELIN_FLOOR1_80F739EA, "javelin floor 1"),
		o_javelin_floor2_80F739EA = lib.one(Slot.O_JAVELIN_FLOOR2_80F739EA, "javelin floor 2"),
		o_javelin_floor3_80F739EA = lib.one(Slot.O_JAVELIN_FLOOR3_80F739EA, "javelin floor 3"),
		o_javelin_floor4_80F739EA = lib.one(Slot.O_JAVELIN_FLOOR4_80F739EA, "javelin floor 4"),


		d_door_lights = lib.one(Slot.D_DOOR_LIGHTS, "door lights"),

		d_screen_bank_1_0 = lib.one(Slot.D_SCREEN_BANK_1_0, "screen bank 1-0"),
		d_screen_bank_1_1 = lib.one(Slot.D_SCREEN_BANK_1_1, "screen bank 1-1"),
		d_screen_bank_1_2 = lib.one(Slot.D_SCREEN_BANK_1_2, "screen bank 1-2"),
		d_screen_bank_1_3 = lib.one(Slot.D_SCREEN_BANK_1_3, "screen bank 1-3"),
		d_screen_bank_1_4 = lib.one(Slot.D_SCREEN_BANK_1_4, "screen bank 1-4"),
		d_screen_bank_1_5 = lib.one(Slot.D_SCREEN_BANK_1_5, "screen bank 1-5"),
		d_screen_bank_1_6 = lib.one(Slot.D_SCREEN_BANK_1_6, "screen bank 1-6"),
		d_screen_bank_1_7 = lib.one(Slot.D_SCREEN_BANK_1_7, "screen bank 1-7"),
		d_screen_bank_1_8 = lib.one(Slot.D_SCREEN_BANK_1_8, "screen bank 1-8"),
		d_screen_bank_1_9 = lib.one(Slot.D_SCREEN_BANK_1_9, "screen bank 1-9"),

		d_screen_bank_2_0 = lib.one(Slot.D_SCREEN_BANK_2_0, "screen bank 2-0"),
		d_screen_bank_2_1 = lib.one(Slot.D_SCREEN_BANK_2_1, "screen bank 2-1"),
		d_screen_bank_2_2 = lib.one(Slot.D_SCREEN_BANK_2_2, "screen bank 2-2"),
		d_screen_bank_2_3 = lib.one(Slot.D_SCREEN_BANK_2_3, "screen bank 2-3"),
		d_screen_bank_2_4 = lib.one(Slot.D_SCREEN_BANK_2_4, "screen bank 2-4"),
		d_screen_bank_2_5 = lib.one(Slot.D_SCREEN_BANK_2_5, "screen bank 2-5"),
		d_screen_bank_2_6 = lib.one(Slot.D_SCREEN_BANK_2_6, "screen bank 2-6"),
		d_screen_bank_2_7 = lib.one(Slot.D_SCREEN_BANK_2_7, "screen bank 2-7"),
		d_screen_bank_2_8 = lib.one(Slot.D_SCREEN_BANK_2_8, "screen bank 2-8"),
		
		d_ana_terminal = lib.one(Slot.D_ANA_TERMINAL, "ana terminal"),
		
		d_rasputin_door = lib.one(Slot.D_RASPUTIN_DOOR, "rasputin door"),
		
		arena_court = {
			WAVE_KEYS = {
				"squad_intro", "squad_a",
				"squad_b", "squad_c",
			},
			squads = {
				squad_intro = {
					{squad = "INTRO_SQUAD_A", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 6}, -- Intro guys that jump
					{squad = "INTRO_SQUAD_B", count = 2, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 4}, -- Psion
					{squad = "INTRO_SQUAD_C", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 10}, -- Psion
					{squad = "INTRO_SQUAD_D", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 11}, -- Psion
				},
				squad_a = {
					{squad = "COURTYARD_SQUAD_A", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 13}, -- Legionary
					{squad = "COURTYARD_SQUAD_A_1", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 13}, -- Phalanx
					{squad = "COURTYARD_SQUAD_A_2", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 13}, -- Legionary
				},
				squad_b = {
					{squad = "COURTYARD_SQUAD_B", count = 2, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 13}, -- Legionary
					{squad = "COURTYARD_SQUAD_B_1", count = 2, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 3}, -- Legionary
				},
				squad_c = {
					{squad = "COURTYARD_SQUAD_C", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 15}, -- Incendior
					{squad = "COURTYARD_SQUAD_C_1", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 18}, -- Incendior
				},
			},
		},
		arena_reinforce = {
			WAVE_KEYS = {
				"squad_reinforce_a1", "squad_reinforce_a1_alt",
				"squad_reinforce_a2",
				"squad_reinforce_b", "squad_reinforce_b_alt",
				"squad_reinforce_c", "squad_reinforce_c_alt",
			},
			squads = {
				squad_reinforce_a1 = {
					{squad = "REINFORCE_SQUAD_A_1", count = 2, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 0}, -- count = 2
				},
				squad_reinforce_a1_alt = {
					{squad = "REINFORCE_SQUAD_A_1_ALT", count = 2, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 0},
				},
				squad_reinforce_a2 = {
					{squad = "REINFORCE_SQUAD_A_2", count = 2, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 3},
				},
				squad_reinforce_b = {
					{squad = "REINFORCE_SQUAD_B", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 17},
				},
				squad_reinforce_b_alt = {
					{squad = "REINFORCE_SQUAD_B_ALT", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 17},
				},
				squad_reinforce_c = {
					{squad = "REINFORCE_SQUAD_C", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 19},
				},
				squad_reinforce_c_alt = {
					{squad = "REINFORCE_SQUAD_C_ALT", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 19},
				},
			},
		},
	arena_boss = {
			squads = {
				{squad = "INTERIOR_SQUAD_BOSS", count = 1, default_objective = "BOSS_OBJECTIVE", default_group = 10}, -- boss
				{squad = "INTERIOR_SQUAD_A", count = 1, default_objective = "BOSS_OBJECTIVE", default_group = 0}, -- legionary
				{squad = "INTERIOR_SQUAD_B", count = 1, default_objective = "BOSS_OBJECTIVE", default_group = 1}, -- incendior
				{squad = "INTERIOR_SQUAD_C", count = 1, default_objective = "BOSS_OBJECTIVE", default_group = 5}, -- legionary, phalanx
				{squad = "INTERIOR_SQUAD_D", count = 1, default_objective = "BOSS_OBJECTIVE", default_group = 7}, -- psion
				{squad = "INTERIOR_SQUAD_E", count = 1, default_objective = "BOSS_OBJECTIVE", default_group = 6}, -- legionary, psion
			},
		},
		
	}
end
--[[
MAIN_OBJECTIVE_80F6A0E6
Group:
	0: Can chase player, prefers to wait inside futurescapes
	1: Only futurescapes lobby
	2: Courtyard, right side near stairs
	3: Courtyard and back of bridge
	4: Middle of bridge and left of intro group
	
	5: Platform left of intro group
	6: Intro squad front
	7: Intro squad back
	8: Courtyard, towards futurescapes lobby
	9: Platform left of intro group
	
	10: Left of intro group
	11: Front of platform left of intro group
	12: Middle of courtyard
	13: Middle of bridge
	14: Only futurescapes lobby
	
	15: Courtyard, towards futurescapes lobby
	16: Courtyard, right side near stairs
	17: Middle of courtyard
	18: Courtyard, towards futurescapes lobby
	19: Middle of courtyard
]]