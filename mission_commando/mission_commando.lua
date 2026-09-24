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

local ARENAS = {
    {
        id = "blvd",
		objective = "OBJ_BLVD",
		enter_sensor = Slot.M_ENGAGEMENT_SENSOR_8153806D,
		clear_sensor = Slot.M_ENGAGEMENT_SENSOR_81538079,
		doors = {Slot.D_EMITTER_BOULEVARD, Slot.D_SHIELD_BOULEVARD},
        squads = {
					{squad = Squad.SQ_A_WAVE_ONE_8153806D, count = 2, default_group = 0},
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
		groups = lib.list(
					mission.TaskGroup.OBJ_BLVD.GROUP_0,
					mission.TaskGroup.OBJ_BLVD.GROUP_1,
					mission.TaskGroup.OBJ_BLVD.GROUP_2,
					mission.TaskGroup.OBJ_BLVD.GROUP_3,
					mission.TaskGroup.OBJ_BLVD.GROUP_4,
					mission.TaskGroup.OBJ_BLVD.GROUP_5
				),
    },
    {
        id = "plaza",
		objective = "OBJ_PLAZA",
		enter_sensor = Slot.M_ENGAGEMENT_SENSOR_815385C6,
		clear_sensor = Slot.M_ENGAGEMENT_SENSOR_815385D0,
        doors = {Slot.D_EMITTER_PLAZA, Slot.D_SHIELD_PLAZA},
        squads = {
					{squad = Squad.SQ_A_WAVE_ONE_815385C6, count = 3, default_group = 0},
					{squad = Squad.SQ_B_WAVE_ONE_815385C6, count = 3, default_group = 1},
					{squad = Squad.SQ_C_WAVE_ONE_815385C6, count = 3, default_group = 2},
					{squad = Squad.SQ_SNIPER_A, count = 1, default_group = 8},
					{squad = Squad.SQ_SNIPER_C, count = 1, default_group = 9},
					{squad = Squad.SQ_BOSS_A_815385C6, count = 1, default_group = 5},
					{squad = Squad.SQ_BOSS_B_815385C6, count = 1, default_group = 6},
					{squad = Squad.SQ_BOSS_C_815385C6, count = 1, default_group = 4},
					{squad = Squad.SQ_D_WAVE_ONE_815385C6, count = 1, default_group = 3},
					{squad = Squad.SQ_E_WAVE_ONE_815385C6, count = 2, default_group = 7},
					{squad = Squad.SQ_SNIPER_B, count = 1, default_group = 10}
				},
		squad_slots = {
					Slot.SQ_A_WAVE_ONE_815385C6,
					Slot.SQ_B_WAVE_ONE_815385C6,
					Slot.SQ_C_WAVE_ONE_815385C6,
					Slot.SQ_SNIPER_A,
					Slot.SQ_SNIPER_C,
					Slot.SQ_BOSS_A_815385C6,
					Slot.SQ_BOSS_B_815385C6,
					Slot.SQ_BOSS_C_815385C6,
					Slot.SQ_D_WAVE_ONE_815385C6,
					Slot.SQ_E_WAVE_ONE_815385C6,
					Slot.SQ_SNIPER_B,
				},
		groups = lib.list(
					mission.TaskGroup.OBJ_PLAZA.GROUP_0,
					mission.TaskGroup.OBJ_PLAZA.GROUP_1,
					mission.TaskGroup.OBJ_PLAZA.GROUP_2,
					mission.TaskGroup.OBJ_PLAZA.GROUP_3,
					mission.TaskGroup.OBJ_PLAZA.GROUP_4,
					mission.TaskGroup.OBJ_PLAZA.GROUP_5,
					mission.TaskGroup.OBJ_PLAZA.GROUP_6,
					mission.TaskGroup.OBJ_PLAZA.GROUP_7,
					mission.TaskGroup.OBJ_PLAZA.GROUP_8,
					mission.TaskGroup.OBJ_PLAZA.GROUP_9,
					mission.TaskGroup.OBJ_PLAZA.GROUP_10
				),
    },
	{
        id = "military_a",
		objective = "OBJ_MILITARY",
		enter_sensor = Slot.M_ENGAGEMENT_SENSOR_8153855C,
		doors = {Slot.D_EMITTER_MILITARY_A, Slot.D_SHIELD_MILITARY_A},
        squads = {
					{squad = Squad.SQ_TANK_WAVE_ONE, count = 1, default_group = 0},
					{squad = Squad.SQ_TANK_SERVITOR_A, count = 1, default_group = 1},
					{squad = Squad.SQ_TANK_SERVITOR_D, count = 1, default_group = 1},
					{squad = Squad.SQ_A_WAVE_ONE_8153855C, count = 2, default_group = 2}, -- Shank
					{squad = Squad.SQ_SNIPE_A_WAVE_ONE, count = 1, default_group = 2},
					{squad = Squad.SQ_SNIPE_B_WAVE_ONE, count = 1, default_group = 2},
					{squad = Squad.SQ_TANK_SERVITOR_B, count = 1, default_group = 3},
					{squad = Squad.SQ_B_WAVE_ONE_8153855C, count = 3, default_group = 3}, -- Shank
					{squad = Squad.SQ_D_WAVE_ONE_8153855C, count = 2, default_group = 3}, -- Marauder
					{squad = Squad.SQ_TANK_SERVITOR_C, count = 1, default_group = 4},
					{squad = Squad.SQ_C_WAVE_ONE_8153855C, count = 4, default_group = 4}, -- Shank
					{squad = Squad.SQ_E_WAVE_ONE_8153855C, count = 2, default_group = 4}, -- Marauder
					{squad = Squad.SQ_CATWALK_C_WAVE_ONE, count = 2, default_group = 5},
					{squad = Squad.SQ_CATWALK_B_WAVE_ONE, count = 2, default_group = 6},
					{squad = Squad.SQ_CATWALK_A_WAVE_ONE, count = 2, default_group = 7},
					{squad = Squad.SQ_CATWALK_D_WAVE_ONE, count = 2, default_group = 8}
				},
		squad_slots = {
					Slot.SQ_TANK_WAVE_ONE, -- Slot 0
					Slot.SQ_TANK_SERVITOR_A, -- Slot 1
					Slot.SQ_TANK_SERVITOR_D, -- Slot 1
					Slot.SQ_A_WAVE_ONE_8153855C, -- Slot 2 Resilient Solar Shield Shank x 2
					Slot.SQ_SNIPE_A_WAVE_ONE, -- Slot 2
					Slot.SQ_SNIPE_B_WAVE_ONE, -- Slot 2
					Slot.SQ_TANK_SERVITOR_B, -- Slot 3
					Slot.SQ_B_WAVE_ONE_8153855C, -- Slot 3 Resilient Solar Shield Shank x 4
					Slot.SQ_D_WAVE_ONE_8153855C, -- Slot 3 Resilient Marauder x 3
					Slot.SQ_TANK_SERVITOR_C, -- Slot 4
					Slot.SQ_C_WAVE_ONE_8153855C, -- Slot 4 Resilient Solar Shield Shank x 4
					Slot.SQ_E_WAVE_ONE_8153855C, -- Slot 4 Resilient Marauder x 2
					Slot.SQ_CATWALK_C_WAVE_ONE, -- Slot 5
					Slot.SQ_CATWALK_B_WAVE_ONE, -- Slot 6
					Slot.SQ_CATWALK_A_WAVE_ONE, -- Slot 7
					Slot.SQ_CATWALK_D_WAVE_ONE, -- Slot 8
				},
		groups = lib.list(
					mission.TaskGroup.OBJ_MILITARY.GROUP_0,
					mission.TaskGroup.OBJ_MILITARY.GROUP_1,
					mission.TaskGroup.OBJ_MILITARY.GROUP_2,
					mission.TaskGroup.OBJ_MILITARY.GROUP_3,
					mission.TaskGroup.OBJ_MILITARY.GROUP_4,
					mission.TaskGroup.OBJ_MILITARY.GROUP_5,
					mission.TaskGroup.OBJ_MILITARY.GROUP_6,
					mission.TaskGroup.OBJ_MILITARY.GROUP_7,
					mission.TaskGroup.OBJ_MILITARY.GROUP_8
				),
    },
	{
        id = "military_indoor",
		objective = "OBJ_MILITARY_INDOOR",
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
					{squad = Squad.SQ_HEAVY_INDOOR, count = 1}
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
		groups = lib.list(
					mission.TaskGroup.OBJ_MILITARY_INDOOR.GROUP_0,
					mission.TaskGroup.OBJ_MILITARY_INDOOR.GROUP_1,
					mission.TaskGroup.OBJ_MILITARY_INDOOR.GROUP_2,
					mission.TaskGroup.OBJ_MILITARY_INDOOR.GROUP_3,
					mission.TaskGroup.OBJ_MILITARY_INDOOR.GROUP_4,
					mission.TaskGroup.OBJ_MILITARY_INDOOR.GROUP_5,
					mission.TaskGroup.OBJ_MILITARY_INDOOR.GROUP_6,
					mission.TaskGroup.OBJ_MILITARY_INDOOR.GROUP_7
					),
    },
	{
        id = "underwatch",
		objective = "OBJ_UNDERWATCH",
		enter_sensor = Slot.M_ENGAGEMENT_SENSOR_8153862D,
		clear_sensor = Slot.M_ENGAGEMENT_SENSOR_81538637,
		doors = {Slot.D_EMITTER_UNDERWATCH, Slot.D_SHIELD_UNDERWATCH},
        squads = {
					{squad = Squad.SQ_A_HALL, count = 1, default_group = 0},
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
		groups = lib.list(
					mission.TaskGroup.OBJ_UNDERWATCH.GROUP_0,
					mission.TaskGroup.OBJ_UNDERWATCH.GROUP_1,
					mission.TaskGroup.OBJ_UNDERWATCH.GROUP_2,
					mission.TaskGroup.OBJ_UNDERWATCH.GROUP_3,
					mission.TaskGroup.OBJ_UNDERWATCH.GROUP_4,
					mission.TaskGroup.OBJ_UNDERWATCH.GROUP_5,
					mission.TaskGroup.OBJ_UNDERWATCH.GROUP_6,
					mission.TaskGroup.OBJ_UNDERWATCH.GROUP_7,
					mission.TaskGroup.OBJ_UNDERWATCH.GROUP_8,
					mission.TaskGroup.OBJ_UNDERWATCH.GROUP_9
					),
    },
	{
        id = "outro_arena",
		intro_objective = "OBJ_INTRO",
		adds_objective = "OBJ_ADDS",
		boss_objective = "OBJ_BOSS",
		enter_sensor = Slot.M_ENGAGEMENT_SENSOR_81538177,
        squads = {
					{squad = Squad.SQ_A_HALL, count = 1},
				},
    },
}

local toaster_path = {
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
					
local function set_maze_pattern(context)
	for i = 0, 29 do
		context:slot(Slot["CRYPTARCH_MAZE_1_PM_MAZE_TILES_" .. i]):set_occupancy_condition{value = 1}
	end
end

local function is_heroic(context)
    return context.activity_id == "act/0078/a2caefda"
end

local function vault_puzzle_burn(context, state)
	if state:variable("security_disabled") ~= true then
		context:slot(Slot.CRYPTARCH_MAZE_1_D_SECURITY):transition{
			transition = context.sdk.device_transitions.open,
		}
		context:start_timer("end_burn", 5000)
	end
end

local function set_directive(context, sensor)
	context:slot(Slot.M_DIRECTIVE_SENSOR):set_directive{
			directive = Directive.ENEMY_TARGET_EXFILTRATION,
			audience = context:slot(sensor),
	}
end

local function place_squads(context, arena_data)
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

local function place_boss_squads(context, arena_data)
--[[
	for i, sq in ipairs(arena_data.squads) do
		local squad = context:squad(sq.squad) 
		local counts = squad:counts()
		counts:set(1, sq.count)
		context:slot(arena_data.squad_slots[i]):assign_combat_objective{
		objective = context:slot(arena_data.objective),
		}
		squad:place{counts = counts}
	end
]]
end

local function update_task_groups(context, state, event)
	for _, arena_data in ipairs(ARENAS) do
		for _, squad_slot in ipairs(arena_data.squad_slots) do
			if not lib.is_slot(context, event, squad_slot) or event.alive_count <= 0 then
				return
			end
			local objective = context:slot(Slot[arena_data.objective])
			local current, assigned = event:task_group{objective = objective}
			if not assigned then return end
			local best, known = combat.lowest_cost(event, arena_data.groups, current)
			if known and not combat.same_group(best, current) then
				event.slot:assign_combat_objective{objective = objective, task_group = best}
			end
		end
	end
end

local function arena_cleared(context, arena)
    local squads = {}

    for _, entry in ipairs(arena.squads) do
        table.insert(squads, entry.squad)
    end

    return context:cohort{squads = squads}.cleared
end

local function check_arena_doors(context, state)
    for _, arena in ipairs(ARENAS) do
        local key = arena.id .. ".arena_cleared"
		
		-- Debug code that logs if a squad counts as cleared
		for i, sq in ipairs(arena.squads) do
			if context:cohort{squads = {sq.squad}}.cleared then
				context:set_variable(arena.id .. ".dbg." .. i-1, true)
			end
		end
		
        if not state:variable(key) and arena_cleared(context, arena) then
            context:set_variable(key, true)
			
			if arena.id == outro_arena then
				context:complete_mission{}
			end
            
			if arena.doors then
				for _, door in ipairs(arena.doors) do
					context:slot(door):transition{
						transition = context.sdk.device_transitions.open,
					}
				end
			end
			
			if arena.clear_sensor then
				set_directive(context, arena.clear_sensor)
			end		
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
    end,

    on_load = function(context, state)
        context:set_variable("reloaded", true)
		-- This function is currently used to debug features
		
		--[[
		context:slot(Slot.SQ_A_HALL):assign_combat_objective{
			objective = context:slot(Slot.OBJ_UNDERWATCH),
			task_group = mission.TaskGroup.OBJ_UNDERWATCH.GROUP_8,
		}
				
		local squad = context:squad(Squad.SQ_A_HALL)
		local counts = squad:counts()
		counts:set(1, 1)
		squad:place{counts = counts}
		]]
		context:slot(Slot.MPT_MILITARY):fire_trigger()
    end,

    on_event_region_changed = function(context, state, event)
        context:set_variable("last_region", event.region_index)

        if event.region_index == PLAZA then
			if not state:variable("plaza_visited.armed") then
				context:set_variable("plaza_visited.armed", true)
				set_directive(context, ARENAS[2].enter_sensor)
				place_squads(context, ARENAS[2])
			end
        end
		
		if event.region_index == HANGAR then
			if not state:variable("hangar_visited.armed") then
				context:set_variable("hangar_visited.armed", true)
				
				--context:slot(Slot.PLAZA_MIL_DANGER):fire_trigger()
				--context:slot(Slot.MPT_MILITARY):fire_trigger()
				--context:slot(Slot.MPT_ITS_A_TRAP):fire_trigger()
				
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
			end
			
		end
		
		if event.region_index == PASSAGE then
			if not state:variable("passage_visited.armed") then
				context:set_variable("passage_visited.armed", true)
				
				-- context:slot(Slot.MPT_A_SHIP):fire_trigger()
				-- context:slot(Slot.MPT_LONG_WAY_DOWN):fire_trigger()
				-- context:slot(Slot.MPT_LWD_END):fire_trigger()
				-- context:slot(Slot.MPT_VENTS_TO_PUZZLES):fire_trigger()
				-- context:slot(Slot.MPT_TO_THE_OUTSIDE):fire_trigger()
				-- context:slot(Slot.MPT_VERTIGO):fire_trigger()
				-- context:slot(Slot.MPT_VERTIGO_END):fire_trigger()
				-- context:slot(Slot.MPT_THE_FANS):fire_trigger()
				-- context:slot(Slot.NORMAL_SHORT_TOP_VENT):fire_trigger()
				
				set_directive(context, Slot.M_ENGAGEMENT_SENSOR_815381BA)
				
				-- Passage: Spawns different blockades depending on the mission difficulty
				if is_heroic(context) then
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
				
				--context:slot(Slot.MPT_ENTER_STAIRWELL):fire_trigger()
				--context:slot(Slot.MPT_T_R_E_V_O_R):fire_trigger()
				--context:slot(Slot.MPT_ESCAPE_THE_VENTS):fire_trigger()
				
				set_directive(context, Slot.M_ENGAGEMENT_SENSOR_8153818A)
			end
		end
		
		if event.region_index == VAULT then
			if not state:variable("vault_visited.armed") then
				context:set_variable("vault_visited.armed", true)
				
				--context:slot(Slot.MPT_VAULT):fire_trigger()
				--context:slot(Slot.MPT_VAULT_END):fire_trigger()
				
				set_directive(context, Slot.M_ENGAGEMENT_SENSOR_815381D9)
				context:set_variable("security_disabled", false)
				
				for i = 0, 29 do
					context:slot(Slot["CRYPTARCH_MAZE_1_PM_MAZE_TILES_" .. i]):set_occupancy_condition{value = 1}
				end
				
				-- Vault: Spawns switch that toggles security and makes it interactable. (No functionality has been assigned for now)
				context:slot(Slot.CRYPTARCH_MAZE_1_O_SECURITY_SWITCH):set_object_active{active = true}
				context:slot(Slot.CRYPTARCH_MAZE_1_O_SECURITY_SWITCH):set_interactable_object{used = true}
				context:slot(Slot.CRYPTARCH_MAZE_1_PM_KILL_AREA):set_occupancy_condition{value = 1, filter = context:slot(Slot.CRYPTARCH_MAZE_1_OF_KILL_AREA)}
				
				-- set_directive(context, Slot.M_ENGAGEMENT_SENSOR_815384B7) | Presumed Vault cleared. Might be tied to the puzzle
			end
		end
		
		if event.region_index == OUTRO_REGION then
			if not state:variable("outro_region_visited.armed") then
				context:set_variable("outro_region_visited.armed", true)
				
				-- context:slot(Slot.PT_BOSS_SPAWN):fire_trigger()
				
				-- context:complete_mission{}
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
        end
    end,

    on_event_player_trigger = function(context, state, event)
        if event.slot == nil then return end

        if lib.is_slot(context, event, Slot.PT_ENTRY) then
			context:slot(Slot.PT_ENTRY):disarm_trigger()
		
            context:squad(mission.Squad.SQ_FRIENDLY_8153806D):place{}
            context:scene(mission.Scene.SCENE_INTRO_FRIENDLY):send_event{key = 0x7d465556}
			
			place_squads(context, ARENAS[1])
			context:start_timer("arena_checker", 2000)
        end
		
		if lib.is_slot(context, event, Slot.MPT_MILITARY) then
			context:slot(Slot.MPT_MILITARY):disarm_trigger()
			context:slot(Slot.M_MUSIC_SENSOR):set_music_section{section = 1}
		end
		
		if lib.is_slot(context, event, Slot.MPT_ITS_A_TRAP) then
			context:slot(Slot.MPT_ITS_A_TRAP):disarm_trigger()
			context:slot(Slot.M_MUSIC_SENSOR):set_music_section{section = 2}
		end
		
		if lib.is_slot(context, event, Slot.PT_BOSS_SPAWN) then
			context:slot(Slot.PT_BOSS_SPAWN):disarm_trigger()
			place_boss_squads(context, ARENAS[6])
		end
    end,

    on_event_timer_elapsed = function(context, state, event)
		if event.timer_name == "arena_checker" then
			--check_arena_doors(context, state)
			context:start_timer("arena_checker", 2000)
		end
		
		if event.timer_name == "end_burn" then
			context:slot(Slot.CRYPTARCH_MAZE_1_D_SECURITY):transition{
				transition = context.sdk.device_transitions.close,
			}
		end
    end,
	
	on_event_squad_state = function(context, state, event)
		update_task_groups(context, state, event, ARENAS)
		check_arena_doors(context, state)
    end,
	
	on_event_object_interacted = function(context, state, event)
		if lib.is_slot(context, event, Slot.CRYPTARCH_MAZE_1_O_SECURITY_SWITCH) then
			context:set_variable("security_disabled", true)
			-- This enables burn mode. No damage, Evil switch >:)
			--[[
			context:slot(Slot.CRYPTARCH_MAZE_1_D_SECURITY):transition{
				transition = context.sdk.device_transitions.close,
			}]]
		end
	end,
	
	on_event_trigger_entered = function(context, state, event)
		if lib.is_slot(context, event, Slot.CRYPTARCH_MAZE_1_PM_KILL_AREA) then
			-- event.member_count, event.all_inside
		end
		
		if lib.is_slot(context, event, Slot.CRYPTARCH_MAZE_1_PM_MAZE_TILES_2) then
			-- event.member_count, event.all_inside
			context:set_variable("tile2.tile_entered", true)
			vault_puzzle_burn(context, state)
		end
	end,
	
	on_event_trigger_exited = function(context, state, event)
		if lib.is_slot(context, event, Slot.CRYPTARCH_MAZE_1_PM_MAZE_TILES_2) then
			-- Placeholder
		end
	end,
}