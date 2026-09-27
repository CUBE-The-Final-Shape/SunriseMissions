local missions = require("missions")
local mission = require(missions.MISSION_COMMANDO)
local lib = require("lib.mission_lib")
local combat = require("lib.combat")
local Slot, Squad, Scene, Directive = mission.Slot, mission.Squad, mission.Scene, mission.Directive
local sensor = mission.Slot.M_DIRECTIVE_SENSOR
local cues = mission.DialogueCue.M_DIALOG_SENSOR

local INTRO_REGION = mission.states.STATE_81538016_0000_0000_8153800E.region_index -- 0
local PLAZA = mission.states.STATE_81538016_0006_0000_81538014.region_index -- 48
local HANGAR = mission.states.STATE_81538016_0005_0000_81538013.region_index -- 40
local TOWER_WATCH = mission.states.STATE_81538016_0007_0000_81538015.region_index -- 56
local PASSAGE = mission.states.STATE_81538016_0003_0000_81538011.region_index -- 24
local VENTILATION = mission.states.STATE_81538016_0002_0000_81538010.region_index -- 16
local VAULT = mission.states.STATE_81538016_0004_0000_81538012.region_index -- 32
local OUTRO_REGION = mission.states.STATE_81538016_0001_0000_8153800F.region_index -- 8

local music_lookup = {
	{trigger = Slot.MPT_MILITARY, section = 4}, -- hanger_combat
	{trigger = Slot.MPT_ITS_A_TRAP, section = 5}, -- its_a_trap
	{trigger = Slot.MPT_LONG_WAY_DOWN, section = 11}, -- long_way_down
	{trigger = Slot.MPT_LWD_END, section = 12}, -- lwd_end
	{trigger = Slot.MPT_VENTS_TO_PUZZLES, section = 13}, -- vents_to_puzzles
	{trigger = Slot.MPT_TO_THE_OUTSIDE, section = 14}, -- to_the_outside
	{trigger = Slot.MPT_VERTIGO, section = 15}, -- vertigo
	{trigger = Slot.MPT_VERTIGO_END, section = 16}, -- vertigo_end
	{trigger = Slot.MPT_THE_FANS, section = 17}, -- the_fans
	{trigger = Slot.MPT_ENTER_STAIRWELL, section = 18}, -- enter_stairwell
	{trigger = Slot.MPT_T_R_E_V_O_R, section = 19}, -- figure_it_out
	{trigger = Slot.MPT_ESCAPE_THE_VENTS, section = 20}, -- escape_the_vents
	{trigger = Slot.MPT_VAULT, section = 21}, -- the_vault
	{trigger = Slot.MPT_VAULT_END, section = 22}, -- vault_end
}

local ARENAS = {
    {
        id = "blvd",
		objective = "OBJ_BLVD",
		clear_music_section = 1, -- first_shield_drop
		enter_sensor = Slot.M_ENGAGEMENT_SENSOR_8153806D,
		clear_sensor = Slot.M_ENGAGEMENT_SENSOR_81538079,
		doors = {Slot.D_EMITTER_BOULEVARD, Slot.D_SHIELD_BOULEVARD},
        squads = {
					{squad = Squad.SQ_A_WAVE_ONE_8153806D, count = 2, default_group = 0}, -- Inconsistent
					{squad = Squad.SQ_B_WAVE_ONE_8153806D, count = 3, default_group = 1},
					{squad = Squad.SQ_C_WAVE_ONE_8153806D, count = 3, default_group = 2},
					{squad = Squad.SQ_D_WAVE_ONE_8153806D, count = 2, default_group = 3},
					{squad = Squad.SQ_E_WAVE_ONE_8153806D, count = 1, default_group = 4},
					{squad = Squad.SQ_F_WAVE_ONE_8153806D, count = 1, default_group = 5}
				},
		squad_slots = {
					Slot.SQ_A_WAVE_ONE_8153806D,
					Slot.SQ_B_WAVE_ONE_8153806D,
					Slot.SQ_C_WAVE_ONE_8153806D,
					Slot.SQ_D_WAVE_ONE_8153806D,
					Slot.SQ_E_WAVE_ONE_8153806D,
					Slot.SQ_F_WAVE_ONE_8153806D,
				},
    },
    {
        id = "plaza",
		objective = "OBJ_PLAZA",
		clear_music_section = 3, -- second_shield_drop
		enter_sensor = Slot.M_ENGAGEMENT_SENSOR_815385C6,
		clear_sensor = Slot.M_ENGAGEMENT_SENSOR_815385D0,
        doors = {Slot.D_EMITTER_PLAZA, Slot.D_SHIELD_PLAZA},
        squads = {
					-- Group 8 and 9 are bad groups that often make squads not report full strength and cleared.
					-- Assigning invalid groups to enemies that are supposed to be stationary seems to fix the problem
					{squad = Squad.SQ_A_WAVE_ONE_815385C6, count = 3, default_group = 0},
					{squad = Squad.SQ_B_WAVE_ONE_815385C6, count = 3, default_group = 1},
					{squad = Squad.SQ_C_WAVE_ONE_815385C6, count = 3, default_group = 2},
					{squad = Squad.SQ_D_WAVE_ONE_815385C6, count = 2, default_group = 3},
					{squad = Squad.SQ_E_WAVE_ONE_815385C6, count = 2, default_group = 4},
					{squad = Squad.SQ_BOSS_A_815385C6, count = 1, default_group = 5},
					{squad = Squad.SQ_BOSS_B_815385C6, count = 1, default_group = 6},
					{squad = Squad.SQ_BOSS_C_815385C6, count = 1, default_group = 7},
					{squad = Squad.SQ_SNIPER_A, count = 1, default_group = 11},
					{squad = Squad.SQ_SNIPER_B, count = 1, default_group = 11},
					{squad = Squad.SQ_SNIPER_C, count = 1, default_group = 10}
				},
		squad_slots = {
					Slot.SQ_A_WAVE_ONE_815385C6,
					Slot.SQ_B_WAVE_ONE_815385C6,
					Slot.SQ_C_WAVE_ONE_815385C6,
					Slot.SQ_D_WAVE_ONE_815385C6,
					Slot.SQ_E_WAVE_ONE_815385C6,
					Slot.SQ_BOSS_A_815385C6,
					Slot.SQ_BOSS_B_815385C6,
					Slot.SQ_BOSS_C_815385C6,
					Slot.SQ_SNIPER_A,
					Slot.SQ_SNIPER_B,
					Slot.SQ_SNIPER_C,
				},
    },
	{
	
		-- 0 Tank
		-- 1 Servitors A,D,
		-- 2 Snipers, Wave_A-C
		-- 3 Servitor B, Wave_E
		-- 4 Servitor C, Wave_D
		-- 5 Catwalk 5
		-- 6 Catwalk 4
		-- 7 Catwalk 3
		-- 8 Catwalk 1
        id = "military_a",
		objective = "OBJ_MILITARY",
		enter_sensor = Slot.M_ENGAGEMENT_SENSOR_8153855C,
		doors = {Slot.D_EMITTER_MILITARY_A, Slot.D_SHIELD_MILITARY_A},
        squads = {
					-- Group 1 and 2 are bad groups that often make squads not report full strength and cleared.
					-- Assigning invalid groups to enemies that are supposed to be stationary seems to fix the problem
					{squad = Squad.SQ_TANK_WAVE_ONE, count = 1, default_group = 9},
					{squad = Squad.SQ_TANK_SERVITOR_A, count = 1, default_group = 9},
					{squad = Squad.SQ_TANK_SERVITOR_B, count = 1, default_group = 3},
					{squad = Squad.SQ_TANK_SERVITOR_C, count = 1, default_group = 4},
					{squad = Squad.SQ_TANK_SERVITOR_D, count = 1, default_group = 9}, 
					{squad = Squad.SQ_A_WAVE_ONE_8153855C, count = 4, default_group = 9}, -- Resilient Solar Shield Shank
					{squad = Squad.SQ_B_WAVE_ONE_8153855C, count = 3, default_group = 9}, -- Resilient Solar Shield Shank
					{squad = Squad.SQ_C_WAVE_ONE_8153855C, count = 3, default_group = 9}, -- Resilient Solar Shield Shank
					{squad = Squad.SQ_D_WAVE_ONE_8153855C, count = 2, default_group = 3}, -- Resilient Marauder
					{squad = Squad.SQ_E_WAVE_ONE_8153855C, count = 2, default_group = 4}, -- Resilient Marauder
					{squad = Squad.SQ_CATWALK_C_WAVE_ONE, count = 2, default_group = 5},
					{squad = Squad.SQ_CATWALK_B_WAVE_ONE, count = 2, default_group = 6},
					{squad = Squad.SQ_CATWALK_A_WAVE_ONE, count = 2, default_group = 7},
					{squad = Squad.SQ_CATWALK_D_WAVE_ONE, count = 2, default_group = 8}, -- Inconsistent reconsider default_group
					{squad = Squad.SQ_SNIPE_A_WAVE_ONE, count = 1, default_group = 9},
					{squad = Squad.SQ_SNIPE_B_WAVE_ONE, count = 1, default_group = 9}
				},
		squad_slots = {
					Slot.SQ_TANK_WAVE_ONE, -- Slot 0
					Slot.SQ_TANK_SERVITOR_A, -- Slot 1
					Slot.SQ_TANK_SERVITOR_B, -- Slot 1
					Slot.SQ_TANK_SERVITOR_C, -- Slot 1
					Slot.SQ_TANK_SERVITOR_D, -- Slot 1
					Slot.SQ_A_WAVE_ONE_8153855C, -- Slot 2
					Slot.SQ_B_WAVE_ONE_8153855C, -- Slot 2
					Slot.SQ_C_WAVE_ONE_8153855C, -- Slot 2
					Slot.SQ_D_WAVE_ONE_8153855C, -- Slot 3
					Slot.SQ_E_WAVE_ONE_8153855C, -- Slot 4
					Slot.SQ_CATWALK_C_WAVE_ONE, -- Slot 5
					Slot.SQ_CATWALK_B_WAVE_ONE, -- Slot 6
					Slot.SQ_CATWALK_A_WAVE_ONE, -- Slot 7
					Slot.SQ_CATWALK_D_WAVE_ONE, -- Slot 8
					Slot.SQ_SNIPE_A_WAVE_ONE, -- Slot 9
					Slot.SQ_SNIPE_B_WAVE_ONE, -- Slot 9
				},
    },
	{
        id = "military_indoor",
		objective = "OBJ_MILITARY_INDOOR",
		clear_music_section = 6, -- hanger_clear
		clear_sensor = Slot.M_ENGAGEMENT_SENSOR_8153856C,
		doors = {Slot.D_EMITTER_MILITARY_B, Slot.D_SHIELD_MILITARY_B},
        squads = {
					{squad = Squad.SQ_A_AMBUSH, count = 2, default_group = 0},
					{squad = Squad.SQ_B_AMBUSH, count = 2, default_group = 0},
					{squad = Squad.SQ_C_AMBUSH, count = 1, default_group = 0},
					{squad = Squad.SQ_A_INDOOR, count = 1, default_group = 1},
					{squad = Squad.SQ_B_INDOOR, count = 1, default_group = 2},
					{squad = Squad.SQ_C_INDOOR, count = 1, default_group = 3},
					{squad = Squad.SQ_D_INDOOR, count = 1, default_group = 4},
					{squad = Squad.SQ_E_INDOOR, count = 1, default_group = 5},
					{squad = Squad.SQ_F_INDOOR, count = 1, default_group = 6},
					{squad = Squad.SQ_HEAVY_INDOOR, count = 1, default_group = 7}
					},
		squad_slots = {
					Slot.SQ_A_AMBUSH,
					Slot.SQ_B_AMBUSH,
					Slot.SQ_C_AMBUSH,
					Slot.SQ_A_INDOOR,
					Slot.SQ_B_INDOOR,
					Slot.SQ_C_INDOOR,
					Slot.SQ_D_INDOOR,
					Slot.SQ_E_INDOOR,
					Slot.SQ_F_INDOOR,
					Slot.SQ_HEAVY_INDOOR,
				},
    },
	{
        id = "underwatch",
		objective = "OBJ_UNDERWATCH",
		clear_music_section = 8, -- rooms_clear
		enter_sensor = Slot.M_ENGAGEMENT_SENSOR_8153862D,
		clear_sensor = Slot.M_ENGAGEMENT_SENSOR_81538637,
		doors = {Slot.D_EMITTER_UNDERWATCH, Slot.D_SHIELD_UNDERWATCH},
        squads = {
					{squad = Squad.SQ_A_HALL, count = 1, default_group = 0}, -- Inconsistent
					{squad = Squad.SQ_D_HALL, count = 1, default_group = 1},
					{squad = Squad.SQ_B_HALL, count = 1, default_group = 2},
					{squad = Squad.SQ_C_HALL, count = 1, default_group = 3},
					{squad = Squad.SQ_A_PVP, count = 1, default_group = 4},
					{squad = Squad.SQ_C_PVP, count = 1, default_group = 5},	
					{squad = Squad.SQ_B_PVP, count = 1, default_group = 6},
					{squad = Squad.SQ_A_RETREAT, count = 2, default_group = 7},
					{squad = Squad.SQ_B_RETREAT, count = 2, default_group = 8},
					{squad = Squad.SQ_C_RETREAT, count = 1, default_group = 9}
					},
		squad_slots = {
					Slot.SQ_A_HALL,
					Slot.SQ_D_HALL,
					Slot.SQ_B_HALL,
					Slot.SQ_C_HALL,
					Slot.SQ_A_PVP,
					Slot.SQ_C_PVP,
					Slot.SQ_B_PVP,
					Slot.SQ_A_RETREAT,
					Slot.SQ_B_RETREAT,
					Slot.SQ_C_RETREAT,
				},
    },
	{
        id = "outro_arena",
		enter_sensor = Slot.M_ENGAGEMENT_SENSOR_81538177,
		actor_squads = {
			{squad = Squad.SQ_BOSS_C_81538177, slot = Slot.SQ_BOSS_C_81538177, count = 1, default_group = 1, actor = Slot.SQ_BOSS_C_ULTRA},
			{squad = Squad.SQ_BOSS_A_81538177, slot = Slot.SQ_BOSS_A_81538177, count = 1, default_group = 0, actor = Slot.SQ_BOSS_A_ULTRA},
			{squad = Squad.SQ_BOSS_B_81538177, slot = Slot.SQ_BOSS_B_81538177, count = 1, default_group = 3, actor = Slot.SQ_BOSS_B_ULTRA},
		},
		--[[
		OBJ_INTRO
		Group 0 left tank vandal
		Group 1 left tank vandal
		Group 2 right tank vandal
		Group 3 right tank vandal
		Group 4 front right of front
		Group 5 front left of front
		Group 6 front, right box
		Group 7 front, left box
		Group 8 front, close left box
		Group 9 front
		Group 10 front
		Group 11 front, close right box
		
		-----
		
		OBJ_ADDS, a.k.a shanks
		Group 0 Flying, front | left
		Group 1 Flying, front | left
		Group 2 Flying, front | right
		Group 3 Flying, front | right
		Group 4 Flying, back
		Group 5 Flying, back
		Group 6 Flying, back
		Group 7 Flying, back
		Group 8 Flying, left
		Group 9 Flying, left
		Group 10 Flying, right
		Group 11 Flying, right
		
		-----
		
		OBJ_BOSS
		Group 0 Hovering in air at front
		Group 1 Slow walk round front
		Group 2 TP left
		Group 3 TP back
		Group 4 TP right
		Group 5 TP tank right
		Group 6 TP tank left
		Group 7 Front of front
		Group 8 Front of front
		Group 9 Front of front
		Group 10 Static back left of front
		Group 11 Static back right of front
		Group 12 No movement
		Group 13 No normal movement, tp's round front
		location order Front = -1 --> Left = 0.95  --> Back = 0.90 --> Right = 0.85 --> Front = 0.80
		]]
		squads = {
			wave_one = {
				{squad = Squad.SQ_VANDAL_A, count = 1, default_objective = "OBJ_INTRO", default_group = 0},
				{squad = Squad.SQ_VANDAL_B, count = 1, default_objective = "OBJ_INTRO", default_group = 1},
				{squad = Squad.SQ_VANDAL_C, count = 1, default_objective = "OBJ_INTRO", default_group = 2},
				{squad = Squad.SQ_VANDAL_D, count = 1, default_objective = "OBJ_INTRO", default_group = 3},
				{squad = Squad.SQ_A_WAVE_ONE_81538177, count = 1, default_objective = "OBJ_INTRO", default_group = 4},
				{squad = Squad.SQ_B_WAVE_ONE_81538177, count = 1, default_objective = "OBJ_INTRO", default_group = 5},
				{squad = Squad.SQ_C_WAVE_ONE_81538177, count = 1, default_objective = "OBJ_INTRO", default_group = 6},
				{squad = Squad.SQ_D_WAVE_ONE_81538177, count = 1, default_objective = "OBJ_INTRO", default_group = 7},
				{squad = Squad.SQ_E_WAVE_ONE_81538177, count = 1, default_objective = "OBJ_INTRO", default_group = 8}, 
				{squad = Squad.SQ_F_WAVE_ONE_81538177, count = 1, default_objective = "OBJ_INTRO", default_group = 9},
				{squad = Squad.SQ_G_WAVE_ONE, count = 1, default_objective = "OBJ_INTRO", default_group = 10},
				{squad = Squad.SQ_H_WAVE_ONE, count = 1, default_objective = "OBJ_INTRO", default_group = 11},
			},
			on_provoked = {
				{squad = Squad.SQ_VOID_SHANK_A, count = 2, default_objective = "OBJ_ADDS", default_group = 0},
				{squad = Squad.SQ_VOID_SHANK_B, count = 2, default_objective = "OBJ_ADDS", default_group = 1},
				{squad = Squad.SQ_VOID_SHANK_C, count = 2, default_objective = "OBJ_ADDS", default_group = 2},
				{squad = Squad.SQ_VOID_SHANK_D, count = 2, default_objective = "OBJ_ADDS", default_group = 3},
			},

			on_tp_left = {
				{squad = Squad.SQ_ARC_SHANK_A, count = 2, default_objective = "OBJ_ADDS", default_group = 8},
				{squad = Squad.SQ_ARC_SHANK_B, count = 2, default_objective = "OBJ_ADDS", default_group = 9},
			},

			on_tp_back = {
				{squad = Squad.SQ_SOLAR_SHANK_A, count = 2, default_objective = "OBJ_ADDS", default_group = 4},
				{squad = Squad.SQ_SOLAR_SHANK_B, count = 2, default_objective = "OBJ_ADDS", default_group = 5},
				{squad = Squad.SQ_SOLAR_SHANK_C, count = 2, default_objective = "OBJ_ADDS", default_group = 6},
				{squad = Squad.SQ_SOLAR_SHANK_D, count = 2, default_objective = "OBJ_ADDS", default_group = 7},
			},

			on_tp_right = {
				{squad = Squad.SQ_ARC_SHANK_C, count = 2, default_objective = "OBJ_ADDS", default_group = 10},
				{squad = Squad.SQ_ARC_SHANK_D, count = 2, default_objective = "OBJ_ADDS", default_group = 11},
			},

			on_tp_front = {
				{squad = Squad.SQ_VANDAL_FINAL_A, count = 1, default_objective = "OBJ_BOSS", default_group = 10},
				{squad = Squad.SQ_VANDAL_FINAL_B, count = 1, default_objective = "OBJ_BOSS", default_group = 11},
				{squad = Squad.SQ_MARAUDER_FINAL_A, count = 1, default_objective = "OBJ_BOSS", default_group = 7},
				{squad = Squad.SQ_MARAUDER_FINAL_B, count = 1, default_objective = "OBJ_BOSS", default_group = 8},
				{squad = Squad.SQ_MARAUDER_FINAL_C, count = 1, default_objective = "OBJ_BOSS", default_group = 9},
				{squad = Squad.SQ_ARC_SHANK_FINAL_A, count = 1, default_objective = "OBJ_BOSS", default_group = 12},
				{squad = Squad.SQ_ARC_SHANK_FINAL_B, count = 1, default_objective = "OBJ_BOSS", default_group = 13},
				{squad = Squad.SQ_TANK_A, count = 1, default_objective = "OBJ_BOSS", default_group = 5},
				{squad = Squad.SQ_TANK_B, count = 1, default_objective = "OBJ_BOSS", default_group = 6},
			},
		},
		squad_slots = {
			wave_one = {
				Slot.SQ_VANDAL_A,
				Slot.SQ_VANDAL_B,
				Slot.SQ_VANDAL_C,
				Slot.SQ_VANDAL_D,
				Slot.SQ_A_WAVE_ONE_81538177,
				Slot.SQ_B_WAVE_ONE_81538177,
				Slot.SQ_C_WAVE_ONE_81538177,
				Slot.SQ_D_WAVE_ONE_81538177,
				Slot.SQ_E_WAVE_ONE_81538177,
				Slot.SQ_F_WAVE_ONE_81538177,
				Slot.SQ_G_WAVE_ONE,
				Slot.SQ_H_WAVE_ONE,
			},
			on_provoked = {
				Slot.SQ_VOID_SHANK_A,
				Slot.SQ_VOID_SHANK_B,
				Slot.SQ_VOID_SHANK_C,
				Slot.SQ_VOID_SHANK_D,
			},

			on_tp_left = {
				Slot.SQ_ARC_SHANK_A,
				Slot.SQ_ARC_SHANK_B,
			},

			on_tp_back = {
				Slot.SQ_SOLAR_SHANK_A,
				Slot.SQ_SOLAR_SHANK_B,
				Slot.SQ_SOLAR_SHANK_C,
				Slot.SQ_SOLAR_SHANK_D,
			},

			on_tp_right = {
				Slot.SQ_ARC_SHANK_C,
				Slot.SQ_ARC_SHANK_D,
			},

			on_tp_front = {
				Slot.SQ_VANDAL_FINAL_A,
				Slot.SQ_VANDAL_FINAL_B,
				Slot.SQ_MARAUDER_FINAL_A,
				Slot.SQ_MARAUDER_FINAL_B,
				Slot.SQ_MARAUDER_FINAL_C,
				Slot.SQ_ARC_SHANK_FINAL_A,
				Slot.SQ_ARC_SHANK_FINAL_B,
				Slot.SQ_TANK_A,
				Slot.SQ_TANK_B,
			},
		},
    },
}

local WAVE_KEYS = {
    "wave_one", "on_provoked", "on_tp_left",
    "on_tp_back", "on_tp_right", "on_tp_front",
}

local toaster_path = { -- I don't think there is a way to read the current elemental singe yet.
					   -- When it's implemented into Sunrise all old vault layouts can be implmented
					{
						id = "arc",
						mode = "normal",
						path = {3,5,6,7,8,10,15,17,18,19,20,21,22,24,29},
					},
					{
						id = "arc",
						mode = "heroic",
						path = {0,5,6,7,8,13,18,20,21,22,23,25},
					},
					{
						id = "void",
						mode = "normal",
						path = {0,5,7,8,9,10,11,12,14,19,20,21,22,23,24,25},
					},
					{
						id = "void",
						mode = "heroic",
						path = {0,5,10,12,13,14,15,17,19,20,21,22,24,29},
					},
					{
						id = "solar",
						mode = "normal",
						path = {2,7,10,11,12,15,20,21,22,23,24,29},
					},
					{
						id = "solar",
						mode = "heroic",
						path = {0,5,6,11,12,13,14,19,21,22,23,24,26},
					},
				}

local function is_heroic(context)
    return context.activity_id == "act/0078/a2caefda"
end

local function vault_puzzle_burn(context, state)
	context:slot(Slot.CRYPTARCH_MAZE_1_D_SECURITY):transition{
		transition = context.sdk.device_transitions.open,
	}
	local var_revision = state:variable("revision")
	context:slot(Slot.CRYPTARCH_MAZE_1_HO_KILL):set_mission_effect{
		filter = context:slot(Slot.CRYPTARCH_MAZE_1_OF_KILL_AREA),
		enabled = true,
		revision = var_revision
	}
	context:set_variable("revision", var_revision + 1)
	context:start_timer("end_burn", 3000)
end

local function set_directive(context, sensor)
	context:slot(Slot.M_DIRECTIVE_SENSOR):set_directive{
			-- Some sdk builders names the directive to ENEMY_TARGET_EXFILTRATION.
			-- The one I've been using names it UNNAMED
			
			-- directive = Directive.ENEMY_TARGET_EXFILTRATION,
			directive = Directive.UNNAMED,
			audience = context:slot(sensor),
	}
end

local function place_squads(context, arena_data)
	-- This function goes through the squads in a given arena.
	-- It prepares them by giveing them an objective and a group slot.
	-- They are spawned once the preparation is done.
	for i, sq in ipairs(arena_data.squads) do
		local squad = context:squad(sq.squad)
		local counts = squad:counts()
		counts:set(1, sq.count)
		context:slot(arena_data.squad_slots[i]):assign_combat_objective{
			objective = context:slot(Slot[arena_data.objective]),
			task_group = mission.TaskGroup[arena_data.objective]["GROUP_" .. sq.default_group]
		}
		squad:place{counts = counts}
	end
end

local function place_boss_squads(context, arena_data, wave) -- wave is a string with the same name as the wave you want to spawn
	-- This is essentially the same as place_squads() but modfied
	-- to work with the unique structure of the outro_arena.
	for i, sq in ipairs(arena_data.squads[wave]) do
		local squad = context:squad(sq.squad) 
		local counts = squad:counts()
		counts:set(1, sq.count)
		context:slot(arena_data.squad_slots[wave][i]):assign_combat_objective{
			objective = context:slot(Slot[sq.default_objective]),
			task_group = mission.TaskGroup[sq.default_objective]["GROUP_" .. sq.default_group]
		}
		squad:place{counts = counts}
	end
end

local function update_boss_c_group(context, id)
	context:slot(Slot.SQ_BOSS_C_81538177):assign_combat_objective{
		objective = context:slot(Slot.OBJ_BOSS),
		task_group = mission.TaskGroup.OBJ_BOSS["GROUP_" .. id],
	}
end

local function update_bosses_defeated(context, state)
	local bosses_defeated = state:variable("bosses_defeated")
	context:set_variable("bosses_defeated", bosses_defeated + 1)
end

local function place_boss_actors(context, arena_data, wave, index)
		-- The bosses in the outro arena have corresponding actor slots. This is an alternative way of spawning enemies
		-- that is needed in this mission in order to make the bosses health values monitorable.
		-- Without this it's impossible to script encounters react to specified health criteria.
		-- The health values can be monitored in on_event_damage_state by watching for events hat the actors send when damaged.
		context:slot(arena_data.actor_squads[index].actor):bind_combatant_to_squad()

		context:slot(arena_data.actor_squads[index].actor):run_atoms{
			atoms = {{kind = "trivial"}},
			spawn = true,
		}

		context:slot(arena_data.actor_squads[index].slot):assign_combat_objective{
			objective = context:slot(Slot.OBJ_BOSS),
			task_group = mission.TaskGroup.OBJ_BOSS["GROUP_" .. arena_data.actor_squads[index].default_group],
		}
end

local function flatten_squad_entries(list, out)
    if list[1] ~= nil then
        -- flat arena.squads array (existing arenas)
        for _, value in ipairs(list) do
            table.insert(out, value)
        end
        return
    end

    -- keyed by wave name (boss arena)
    for _, key in ipairs(WAVE_KEYS) do
        local wave = list[key]
        if wave then
            for _, value in ipairs(wave) do
                table.insert(out, value)
            end
        end
    end
end

local function arena_squad_entries(arena)
    local entries = {}
    flatten_squad_entries(arena.squads, entries)
    return entries
end

local function check_cleared_status(context, arena)
    local entries = arena_squad_entries(arena)
    if #entries == 0 then
        return false
    end

    local squads = {}
    for _, entry in ipairs(entries) do
        table.insert(squads, entry.squad)
    end

    return context:cohort{squads = squads}.cleared
end

local function play_outro_scene(context)
	context:slot(Slot.M_MUSIC_SENSOR):set_music_section{section = 1}
	context:slot(Slot.M_DIRECTIVE_SENSOR):clear_directives()
	context:start_timer("outro_mithrax_spawn_delay", 2000)
	context:start_timer("mission_complete_delay", 6000)
	
	local kinds = context.sdk.atom_kinds
	context:slot(Slot.SQ_SKIFF_PILOT):run_atoms{spawn = true, atoms = {
		{kind = kinds.ability, ability = mission.ActorAbility.SQ_SKIFF_PILOT.GROUP_07EBF354.KEY_052C60A0, target = context:slot(Slot.SKIFF_ENTRY_SEQUENCE)},
		{kind = kinds.sleep, seconds = 2},
		{kind = kinds.ability, ability = mission.ActorAbility.SQ_SKIFF_PILOT.GROUP_07EBF354.KEY_1E35DF11, target = context:slot(Slot.SKIFF_EXIT_SEQUENCE)},
	}}
end

local function update_arena_status(context, state, arena)
	local key = arena.id .. ".arena_cleared"
	local entries = arena_squad_entries(arena)

	-- Debug code that logs if a squad counts as cleared
	for i, entry in ipairs(entries) do
		if context:cohort{squads = {entry.squad}}.cleared then
			context:set_variable(arena.id .. ".dbg." .. i-1, true)
		end
	end

	if not state:variable(key) and check_cleared_status(context, arena) then
		context:set_variable(key, true)
		
		local current_arena = state:variable("active_arena")
		context:set_variable("active_arena", current_arena + 1)
		
		
		-- If all conditions are met this should trigger the outro scene and mission complete.
		if arena.id == "outro_arena" and state:variable("bosses_defeated") == 3 then
			play_outro_scene(context)
		end
		
		-- If the arena has a corresponding door that needs to be opened on it being cleared,
		-- this will handle it.
		if arena.doors then
			for _, door in ipairs(arena.doors) do
				context:slot(door):transition{
					transition = context.sdk.device_transitions.open,
				}
			end
		end
		
		-- Some arenas end the current music segment when cleared, some don't.
		-- This section checks if the arena has a clear_music_section and if it exists, plays it.
		if arena.clear_music_section then
			context:slot(Slot.M_MUSIC_SENSOR):set_music_section{section = arena.clear_music_section}
		end

		-- If the arena has a corresponding engagement sensor that should be set on clear, it gets set here.
		if arena.clear_sensor then
			set_directive(context, arena.clear_sensor)
		end
	end
end


return {
    initial_state = {
        region_index = INTRO_REGION,
        spawn_set_hash = 0x2EA8FB98,
    },

    -- Runs once, when the mission starts for the first time.
    on_start = function(context, state)
        context:set_variable("zero_hour_script", "started")
		context:slot(Slot.HARD_WIPE_GLOBALS):set_darkness_zone{enabled = false}
		context:set_variable("is_heroic", is_heroic(context))
		context:set_variable("active_arena", 1)
    end,

	-- This function is currently used to debug features
    on_load = function(context, state)
        context:set_variable("reloaded", true)
		-- play_outro_scene(context)
		context:set_variable("active_arena", 6)
    end,

    on_event_region_changed = function(context, state, event)
        context:set_variable("last_region", event.region_index)

        if event.region_index == PLAZA then
			if not state:variable("plaza_visited.armed") then
				context:set_variable("plaza_visited.armed", true)
				context:slot(Slot.M_MUSIC_SENSOR):set_music_section{section = 2} -- tower_plaza_combat
				set_directive(context, ARENAS[2].enter_sensor)
				place_squads(context, ARENAS[2])
			end
        end
		
		if event.region_index == HANGAR then
			if not state:variable("hangar_visited.armed") then
				context:set_variable("hangar_visited.armed", true)
				
				--context:slot(Slot.PLAZA_MIL_DANGER):fire_trigger() | Not sure what this is supposed to do. Might be supposed to spawn the enemies
				context:slot(Slot.MPT_MILITARY):fire_trigger()
				context:slot(Slot.MPT_ITS_A_TRAP):fire_trigger()
				
				set_directive(context, ARENAS[3].enter_sensor)
				place_squads(context, ARENAS[3])
				place_squads(context, ARENAS[4])
			end
			
		end
		
		if event.region_index == TOWER_WATCH then
			if not state:variable("tower_watch_visited.armed") then 
				context:set_variable("tower_watch_visited.armed", true)
				set_directive(context, ARENAS[5].enter_sensor)
				place_squads(context, ARENAS[5])
				context:slot(Slot.M_MUSIC_SENSOR):set_music_section{section = 7} -- round_the_corner
			end
			
		end
		
		if event.region_index == PASSAGE then
			if not state:variable("passage_visited.armed") then
				context:set_variable("passage_visited.armed", true)
				
				-- Long zone, has a lot of music triggers. Some are only accessible on heroic and vice versa.
				-- The unique triggers per difficulty could be put into the is_heroic check.
				context:slot(Slot.MPT_A_SHIP):fire_trigger()
				context:slot(Slot.MPT_LONG_WAY_DOWN):fire_trigger()
				context:slot(Slot.MPT_LWD_END):fire_trigger()
				context:slot(Slot.MPT_VENTS_TO_PUZZLES):fire_trigger()
				context:slot(Slot.MPT_TO_THE_OUTSIDE):fire_trigger()
				context:slot(Slot.MPT_VERTIGO):fire_trigger()
				context:slot(Slot.MPT_VERTIGO_END):fire_trigger()
				context:slot(Slot.MPT_THE_FANS):fire_trigger()
				-- context:slot(Slot.NORMAL_SHORT_TOP_VENT):fire_trigger() | Not sure how this trigger is used
				
				set_directive(context, Slot.M_ENGAGEMENT_SENSOR_815381BA)
				
				-- This section spawns different blockades depending on the mission difficulty.
				-- Blockades are handled with objects. true = blocked
				if state:variable("is_heroic") == true then
					context:slot(Slot.O_NORMAL_TOP_BLOCK_A):set_object_active{active = true}
					context:slot(Slot.O_NORMAL_TOP_BLOCK_B):set_object_active{active = true}
					context:slot(Slot.O_NORMAL_FANS_BLOCK):set_object_active{active = true}
				else
					context:slot(Slot.O_HEROIC_TOP_BLOCK):set_object_active{active = true}
					context:slot(Slot.O_HEROIC_FANS_BLOCK):set_object_active{active = true}
				end
			end
		end
		
		if event.region_index == VENTILATION then
			if not state:variable("ventilation_visited.armed") then
				context:set_variable("ventilation_visited.armed", true)
				
				context:slot(Slot.MPT_ENTER_STAIRWELL):fire_trigger()
				context:slot(Slot.MPT_T_R_E_V_O_R):fire_trigger()
				context:slot(Slot.MPT_ESCAPE_THE_VENTS):fire_trigger()
				
				set_directive(context, Slot.M_ENGAGEMENT_SENSOR_8153818A)
			end
		end
		
		if event.region_index == VAULT then
			if not state:variable("vault_visited.armed") then
				context:set_variable("vault_visited.armed", true)
				
				context:slot(Slot.MPT_VAULT):fire_trigger()
				context:slot(Slot.MPT_VAULT_END):fire_trigger()
				
				set_directive(context, Slot.M_ENGAGEMENT_SENSOR_815381D9)
				
				-- These variables are needed for propper vault functionality
				
				context:set_variable("security_disabled", false)
				-- Security disabled allows a player to disable the vault
				-- by flipping a switch on the other side of the maze.
				
				context:set_variable("burn_enabled", false)
				-- Burn enabled ensures that two tiles won't trigger the
				-- burn sequence at the same time.
				
				context:set_variable("revision", 1)
				-- Revision is needed for the hop-on sensor to function.
				-- Every call needs to be +1 from the previous call
				
				-- Enables all player monitors. Filtering signals to enable
				-- a path is done in on_event_trigger_entered
				for i = 0, 29 do
					context:slot(
						Slot["CRYPTARCH_MAZE_1_PM_MAZE_TILES_" .. i]
					):set_occupancy_condition{value = 1}
				end
				
				context:slot(Slot.CRYPTARCH_MAZE_1_O_SECURITY_SWITCH):set_object_active{active = true}
				context:slot(Slot.CRYPTARCH_MAZE_1_O_SECURITY_SWITCH):set_interactable_object{used = true}
				
				context:slot(Slot.CRYPTARCH_MAZE_1_PM_KILL_AREA):set_occupancy_condition{value = 1}
				
				context:slot(Slot.CRYPTARCH_MAZE_1_OF_KILL_AREA):set_object_filter{players = true, inside = context:slot(Slot.CRYPTARCH_MAZE_1_TV_KILL_AREA)}
				-- set_directive(context, Slot.M_ENGAGEMENT_SENSOR_815384B7) | Assumed to Vault puzzle. Might be tied to vault cleared
			end
		end
		
		if event.region_index == OUTRO_REGION then
			if not state:variable("outro_region_visited.armed") then
				context:set_variable("outro_region_visited.armed", true)
				context:set_variable("bosses_defeated", 0)
				
				context:slot(Slot.PT_BOSS_SPAWN):fire_trigger()
				set_directive(context, ARENAS[6].enter_sensor)
				place_boss_squads(context, ARENAS[6], "wave_one")
			end
		end
    end,

    on_event_client_state_changed = function(context, state, event)
        if event.entered == true
            and event.held_region_index == INTRO_REGION
            and not state:variable("intro.sent") then

            context:set_variable("intro.sent", true)

            context:squad(mission.Squad.SQ_DREG_TARGET):place{}
            context:scene(mission.Scene.SCENE_INTRO_FRIENDLY):activate{}

            context:slot(Slot.PT_ENTRY):fire_trigger()
			set_directive(context, ARENAS[1].enter_sensor)
			context:slot(Slot.M_MUSIC_SENSOR):set_music_section{section = 0}
			
			place_squads(context, ARENAS[1])
        end
    end,

    on_event_player_trigger = function(context, state, event)
        if event.slot == nil then return end

        if lib.is_slot(context, event, Slot.PT_ENTRY) then
			context:slot(Slot.PT_ENTRY):disarm_trigger()
            context:squad(mission.Squad.SQ_FRIENDLY_8153806D):place{}
            context:scene(mission.Scene.SCENE_INTRO_FRIENDLY):send_event{key = 0x7d465556}
        end
		
		if lib.is_slot(context, event, Slot.PT_BOSS_SPAWN) then
			context:slot(Slot.PT_BOSS_SPAWN):disarm_trigger()
			context:slot(Slot.M_MUSIC_SENSOR):set_music_section{section = 23} -- final_battle
			place_boss_actors(context, ARENAS[6], "wave_one", 1)
		end
		
		if lib.is_slot(context, event, Slot.MPT_A_SHIP) then
			context:slot(Slot.MPT_A_SHIP):disarm_trigger()
			if state:variable("is_heroic") == true then
				context:slot(Slot.M_MUSIC_SENSOR):set_music_section{section = 10} -- same_ship_different_path
			else
				context:slot(Slot.M_MUSIC_SENSOR):set_music_section{section = 9} -- a_ship
			end
		end
		
		for _, entry in ipairs(music_lookup) do
			if lib.is_slot(context, event, entry.trigger) then
				context:slot(entry.trigger):disarm_trigger()
				context:slot(Slot.M_MUSIC_SENSOR):set_music_section{section = entry.section}
			end
		end
    end,

    on_event_timer_elapsed = function(context, state, event)
		if event.timer_name == "outro_mithrax_spawn_delay" then
			context:scene(mission.Scene.SCENE_OUTRO_FRIENDLY):activate{}
			context:squad(mission.Squad.SQ_FRIENDLY_81538177):place{}
			context:scene(mission.Scene.SCENE_OUTRO_FRIENDLY):send_event{key = 0xdf24c893} -- outro_trigger
		end
		
		if event.timer_name == "mission_complete_delay" then
			context:complete_mission{}
		end
		
		if event.timer_name == "end_burn" then
			context:slot(Slot.CRYPTARCH_MAZE_1_D_SECURITY):transition{
				transition = context.sdk.device_transitions.close,
			}
			local var_revision = state:variable("revision")
			
			context:slot(Slot.CRYPTARCH_MAZE_1_HO_KILL):set_mission_effect{
				enabled = false,
				revision = var_revision
			}
			context:set_variable("revision", var_revision + 1)
			context:set_variable("burn_enabled", false)
		end
    end,
	
	on_event_object_interacted = function(context, state, event)
		if lib.is_slot(context, event, Slot.CRYPTARCH_MAZE_1_O_SECURITY_SWITCH) then
			if not state:variable("object_spawn.trigger") then
				-- Without this security_disabled is set to true as soon as the object
				-- is spawned in since objects fire once on their initial spawn.
				context:set_variable("object_spawn.trigger", true)
			else
			context:set_variable("security_disabled", true)
			context:slot(Slot.CRYPTARCH_MAZE_1_D_SECURITY):transition{
				transition = context.sdk.device_transitions.close,
			}
			end
		end
	end,

	on_event_damage_state = function(context, state, event)
		-- This is a mess. Do something about it...
		-- Not sure if it's possible to do anything with it.
		if lib.is_slot(context, event, Slot.SQ_BOSS_C_ULTRA) then
			if event.health ~= -1 and not state:variable("on_provoked.spawned") then
				context:set_variable("on_provoked.spawned", true)
				place_boss_squads(context, ARENAS[6], "on_provoked")
				place_boss_actors(context, ARENAS[6], "on_provoked", 2)
			elseif state:variable("on_provoked.spawned") then
				if event.health <= 0.95 and not state:variable("on_tp_left.spawned") then
					context:set_variable("on_tp_left.spawned", true)
					update_boss_c_group(context, 2)
					place_boss_squads(context, ARENAS[6], "on_tp_left")
					
				elseif event.health <= 0.90 and not state:variable("on_tp_back.spawned") then
					context:set_variable("on_tp_back.spawned", true)
					update_boss_c_group(context, 3)
					place_boss_squads(context, ARENAS[6], "on_tp_back")
					place_boss_actors(context, ARENAS[6], "on_tp_back", 3)
					
				elseif event.health <= 0.85 and not state:variable("on_tp_right.spawned") then
					context:set_variable("on_tp_right.spawned", true)
					update_boss_c_group(context, 4)
					place_boss_squads(context, ARENAS[6], "on_tp_right")
					
				elseif event.health <= 0.80 and not state:variable("on_tp_front.spawned") then
					context:set_variable("on_tp_front.spawned", true)
					update_boss_c_group(context, 1)
					place_boss_squads(context, ARENAS[6], "on_tp_front")
					context:slot(Slot.M_MUSIC_SENSOR):set_music_section{section = 24}
					
				elseif event.health <= 0.50 and not state:variable("music_shift.triggered") then
					context:set_variable("music_shift.triggered", true)
					context:slot(Slot.M_MUSIC_SENSOR):set_music_section{section = 25}
					
				elseif event.health <= 0 and not state:variable("boss_c.cleared") then
					context:set_variable("boss_c.cleared", true)
					update_bosses_defeated(context, state)
					update_arena_status(context, state, ARENAS[6])
				end
			end
		end
		
		if lib.is_slot(context, event, Slot.SQ_BOSS_A_ULTRA) then
			if event.health ~= -1 and not state:variable("boss_a.provoked") then
				context:set_variable("boss_a.provoked", true)
			elseif state:variable("boss_a.provoked") then
				if event.health <= 0 and not state:variable("boss_a.cleared") then
					context:set_variable("boss_a.cleared", true)
					update_bosses_defeated(context, state)
					update_arena_status(context, state, ARENAS[6])
				end
			end
		end
		
		if lib.is_slot(context, event, Slot.SQ_BOSS_B_ULTRA) then
			if event.health ~= -1 and not state:variable("boss_b.provoked") then
				context:set_variable("boss_b.provoked", true)
			elseif state:variable("boss_b.provoked") then
				if event.health <= 0 and not state:variable("boss_b.cleared") then
					context:set_variable("boss_b.cleared", true)
					update_bosses_defeated(context, state)
					update_arena_status(context, state, ARENAS[6])
				end
			end
		end
	end,
	
	on_event_squad_state = function(context, state, event)
		-- Checks on every squad state update if the arena is cleared or not
		-- and perform the relevant actions tied to the arena
		update_arena_status(context, state, ARENAS[state:variable("active_arena")])
	end,
	
	on_event_trigger_entered = function(context, state, event)
		local maze_pattern

		-- Decides the maze path. Currently set to arc patterns
		if state:variable("is_heroic") == true then
			maze_pattern = toaster_path[2].path
		else
			maze_pattern = toaster_path[1].path
		end
		
		-- If a trigger is entered, check which one.
		-- If it's safe, do nothing.
		-- If it isn't safe and burn is off, enable burn.
		
		-- Note: hop-ons with the current implementation have
		-- a bug making them temporarily unable to update their state
		-- if a player dies inside of them. This makes tiles "safe" until
		-- you've entered and exited that tile after death.
		for i = 0, 29 do
			if lib.is_slot(
				context,
				event,
				Slot["CRYPTARCH_MAZE_1_PM_MAZE_TILES_" .. i]
			) then

				local is_safe = false

				for _, safe_tile in ipairs(maze_pattern) do
					if i == safe_tile then
						is_safe = true
						break
					end
				end

				if not is_safe
					and state:variable("burn_enabled") == false
					and state:variable("security_disabled") == false then
					context:set_variable("burn_enabled", true)
					
					vault_puzzle_burn(context, state)
					return
				end
			end
		end
	end,
}