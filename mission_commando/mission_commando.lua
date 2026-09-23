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

--[[
			Engagement sensor info
			M_ENGAGEMENT_SENSOR_8153806D -- Connected to INTRO region, probably on mission load
			M_ENGAGEMENT_SENSOR_81538079 -- Seems to be part of EMITTER/SHIELD _BOULEVARD
			
			M_ENGAGEMENT_SENSOR_815385C6 -- Connected to PLAZA region, probably on entry
			M_ENGAGEMENT_SENSOR_815385D0 -- Connected to PLAZA region, probably EMITTER/SHIELD _PLAZA
			
			M_ENGAGEMENT_SENSOR_8153855C -- Connected to HANGAR region, probably on entry
			M_ENGAGEMENT_SENSOR_8153856C -- Connected to HANGAR region, probably EMITTER/SHIELD MILITARY_A/B
			
			M_ENGAGEMENT_SENSOR_8153862D -- Connected to UNDERWATCH region, probably on entry
			M_ENGAGEMENT_SENSOR_81538637 -- Connected to UNDERWATCH_region, probably EMITTER/SHIELD_UNDERWATCH
			
			M_ENGAGEMENT_SENSOR_815381BA -- Connected to PASSAGE region, probably on entry
			
			M_ENGAGEMENT_SENSOR_8153818A -- Connected to VENTILATION region, probably on entry
			
			M_ENGAGEMENT_SENSOR_815381D9 -- Connected to VAULT region, probably on entry
			
			M_ENGAGEMENT_SENSOR_815384B7 -- Connected to VAULT region, either on toaster disarmed or on exit
			
			M_ENGAGEMENT_SENSOR_81538177 -- Connected to OUTRO_REGION, probably on entry/post fight
		]]
local ENGAGEMENT_SENSORS = {
							{
							id = "blvd_entered",
							sensor = Slot.M_ENGAGEMENT_SENSOR_8153806D,
							},
							{
							id = "blvd_cleared",
							sensor = Slot.M_ENGAGEMENT_SENSOR_81538079,
							},
							
							{
							id = "plaza_entered",
							sensor = Slot.M_ENGAGEMENT_SENSOR_815385C6,
							},
							{
							id = "plaza_cleared",
							sensor = Slot.M_ENGAGEMENT_SENSOR_815385D0,
							},
							
							{
							id = "hangar_entered",
							sensor = Slot.M_ENGAGEMENT_SENSOR_8153855C,
							},
							{
							id = "hangar_cleared",
							sensor = Slot.M_ENGAGEMENT_SENSOR_8153856C,
							},
							
							{
							id = "uw_entered",
							sensor = Slot.M_ENGAGEMENT_SENSOR_8153862D,
							},
							{
							id = "uw_cleared",
							sensor = Slot.M_ENGAGEMENT_SENSOR_81538637,
							},
							
							{
							id = "passage_entered",
							sensor = Slot.M_ENGAGEMENT_SENSOR_815381BA,
							},
							
							{
							id = "ventilation_entered",
							sensor = Slot.M_ENGAGEMENT_SENSOR_8153818A,
							},
							
							{
							id = "vault_entered",
							sensor = Slot.M_ENGAGEMENT_SENSOR_815381D9,
							},
							{
							id = "vault_cleared",
							sensor = Slot.M_ENGAGEMENT_SENSOR_815384B7,
							},
							
							{
							id = "outro_entered",
							sensor = Slot.M_ENGAGEMENT_SENSOR_81538177,
							},
							}


local BLVD_ARENA = {
					{squad = Squad.SQ_A_WAVE_ONE_8153806D, count = 2},
					{squad = Squad.SQ_B_WAVE_ONE_8153806D, count = 3},
					{squad = Squad.SQ_C_WAVE_ONE_8153806D, count = 3},
					{squad = Squad.SQ_D_WAVE_ONE_8153806D, count = 2},
					{squad = Squad.SQ_E_WAVE_ONE_8153806D, count = 1},
					{squad = Squad.SQ_F_WAVE_ONE_8153806D, count = 1}
					}
--[[
local PLAZA_ARENA_WAVE_ONE = {
							{squad = Squad.SQ_D_WAVE_ONE_815385C6, count = 2},
							{squad = Squad.SQ_E_WAVE_ONE_815385C6, count = 2},
							{squad = Squad.SQ_SNIPER_B, count = 1}
							}]]

local PLAZA_ARENA = {
					{squad = Squad.SQ_A_WAVE_ONE_815385C6, count = 3},
					{squad = Squad.SQ_B_WAVE_ONE_815385C6, count = 3},
					{squad = Squad.SQ_C_WAVE_ONE_815385C6, count = 3},
					{squad = Squad.SQ_SNIPER_A, count = 1},
					{squad = Squad.SQ_SNIPER_C, count = 1},
					{squad = Squad.SQ_BOSS_A_815385C6, count = 1},
					{squad = Squad.SQ_BOSS_B_815385C6, count = 1},
					{squad = Squad.SQ_BOSS_C_815385C6, count = 1},
					{squad = Squad.SQ_D_WAVE_ONE_815385C6, count = 1},
					{squad = Squad.SQ_E_WAVE_ONE_815385C6, count = 2},
					{squad = Squad.SQ_SNIPER_B, count = 1}
					}
--[[					
local MILITARY_A_ARENA_WAVE_ONE = {
					{squad = Squad.SQ_A_WAVE_ONE_8153855C, count = 2}, 
					{squad = Squad.SQ_B_WAVE_ONE_8153855C, count = 4},
					{squad = Squad.SQ_C_WAVE_ONE_8153855C, count = 2},
					{squad = Squad.SQ_D_WAVE_ONE_8153855C, count = 2},
					{squad = Squad.SQ_E_WAVE_ONE_8153855C, count = 1}
					}]]
	
local MILITARY_A_ARENA = {
					{squad = Squad.SQ_A_WAVE_ONE_8153855C, count = 2}, 
					{squad = Squad.SQ_B_WAVE_ONE_8153855C, count = 3},
					{squad = Squad.SQ_C_WAVE_ONE_8153855C, count = 3},
					{squad = Squad.SQ_D_WAVE_ONE_8153855C, count = 2},
					{squad = Squad.SQ_E_WAVE_ONE_8153855C, count = 2},
					{squad = Squad.SQ_SNIPE_A_WAVE_ONE, count = 1},
					{squad = Squad.SQ_SNIPE_B_WAVE_ONE, count = 1},
					{squad = Squad.SQ_CATWALK_A_WAVE_ONE, count = 2},
					{squad = Squad.SQ_CATWALK_B_WAVE_ONE, count = 2},
					{squad = Squad.SQ_CATWALK_C_WAVE_ONE, count = 2},
					{squad = Squad.SQ_CATWALK_D_WAVE_ONE, count = 2},
					{squad = Squad.SQ_TANK_WAVE_ONE, count = 1},
					{squad = Squad.SQ_TANK_SERVITOR_A, count = 1},
					{squad = Squad.SQ_TANK_SERVITOR_B, count = 1},
					{squad = Squad.SQ_TANK_SERVITOR_C, count = 1},
					{squad = Squad.SQ_TANK_SERVITOR_D, count = 1}
					}
					
local MILITARY_INDOOR_ARENA = {
					{squad = Squad.SQ_A_AMBUSH, count = 2},
					{squad = Squad.SQ_B_AMBUSH, count = 2},
					{squad = Squad.SQ_C_AMBUSH, count = 1},
					{squad = Squad.SQ_A_INDOOR, count = 1},
					{squad = Squad.SQ_B_INDOOR, count = 1},
					{squad = Squad.SQ_C_INDOOR, count = 1},
					{squad = Squad.SQ_D_INDOOR, count = 1},
					{squad = Squad.SQ_E_INDOOR, count = 1},
					{squad = Squad.SQ_F_INDOOR, count = 1},
					{squad = Squad.SQ_HEAVY_INDOOR, count = 1}
					}
					
local UNDERWATCH_ARENA = {
					{squad = Squad.SQ_A_HALL, count = 1},
					{squad = Squad.SQ_D_HALL, count = 1},
					{squad = Squad.SQ_B_HALL, count = 1},
					{squad = Squad.SQ_C_HALL, count = 1},
					{squad = Squad.SQ_A_PVP, count = 1},
					{squad = Squad.SQ_C_PVP, count = 1},
					{squad = Squad.SQ_B_PVP, count = 1},
					{squad = Squad.SQ_A_RETREAT, count = 2},
					{squad = Squad.SQ_B_RETREAT, count = 2},
					{squad = Squad.SQ_C_RETREAT, count = 1}
					}

-- local OUTRO_ARENA = {}

local ARENAS = {
    {
        id = "blvd",
        squads = BLVD_ARENA,
        doors = {Slot.D_EMITTER_BOULEVARD, Slot.D_SHIELD_BOULEVARD},
		sensor_id = "blvd_cleared",
    },
    {
        id = "plaza",
        squads = PLAZA_ARENA,
        doors = {Slot.D_EMITTER_PLAZA, Slot.D_SHIELD_PLAZA},
		sensor_id = "plaza_cleared",
    },
	{
        id = "military_a",
        squads = MILITARY_A_ARENA,
        doors = {Slot.D_EMITTER_MILITARY_A, Slot.D_SHIELD_MILITARY_A},
    },
	{
        id = "military_indoor",
        squads = MILITARY_INDOOR_ARENA,
        doors = {Slot.D_EMITTER_MILITARY_B, Slot.D_SHIELD_MILITARY_B},
		sensor_id = "hangar_cleared",
    },
	{
        id = "underwatch",
        squads = UNDERWATCH_ARENA,
        doors = {Slot.D_EMITTER_UNDERWATCH, Slot.D_SHIELD_UNDERWATCH},
		sensor_id = "uw_cleared",
    },
	{
        id = "outro_arena",
        squads = PLAZA_ARENA,
		doors = {Slot.D_EMITTER_UNDERWATCH, Slot.D_SHIELD_UNDERWATCH},
		sensor_id = "outro_entered",
    },
}

local function is_heroic(context)
    return context.activity_id == "act/0078/a2caefda"
end

local function set_directive(context, sensor_id)
	for _, sensor_obj in ipairs(ENGAGEMENT_SENSORS) do
		if sensor_obj.id == sensor_id then
			context:set_variable("current_engage_sensor", sensor_obj.id)
			context:slot(Slot.M_DIRECTIVE_SENSOR):set_directive{
					directive = Directive.UNNAMED,
					audience = context:slot(sensor_obj.sensor),
			}
		end
	end
end

local function place_squads(context, arena_squads)
	for _, sq in ipairs(arena_squads) do
		local squad = context:squad(sq.squad) 
		local counts = squad:counts()
		counts:set(1, sq.count) 
		squad:place{counts = counts}
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
		
        if not state:variable(key) and arena_cleared(context, arena) then
            context:set_variable(key, true)
            
            for _, door in ipairs(arena.doors) do
                context:slot(door):transition{
                    transition = context.sdk.device_transitions.open,
                }
            end
			
			if arena.sensor_id then
				set_directive(context, arena.sensor_id)
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
		context:start_timer("arena_checker", 2000)
		
		-- Passage: Spawns different blockades depending on the mission difficulty
		if is_heroic(context) then
			context:slot(Slot.O_NORMAL_TOP_BLOCK_A):set_object_active{active = true}
			context:slot(Slot.O_NORMAL_TOP_BLOCK_B):set_object_active{active = true}
			context:slot(Slot.O_NORMAL_FANS_BLOCK):set_object_active{active = true}
		else
			context:slot(Slot.O_HEROIC_TOP_BLOCK):set_object_active{active = true}
			context:slot(Slot.O_HEROIC_FANS_BLOCK):set_object_active{active = true}
		end
		
		-- Vault: Spawns switch that toggles security and makes it interactable. (No functionality has been assigned for now)
		context:slot(Slot.CRYPTARCH_MAZE_1_O_SECURITY_SWITCH):set_object_active{active = true}
		context:slot(Slot.CRYPTARCH_MAZE_1_O_SECURITY_SWITCH):set_interactable_object{used = true}
		
		context:slot(Slot.HARD_WIPE_GLOBALS):set_darkness_zone{enabled = false}
    end,

    on_load = function(context, state)
        context:set_variable("reloaded", true)
		-- This function is currently used to debug features
		
		-- OUTRO_REGION: Some things for SCENE_OUTRO_FRIENDLY. outro_trigger seems to be the relevant key to trigger the scene.
		-- 				 Skiff isn't friendly but that matches videos from season of the drifter.
		--				 Mithrax only turns around if the Skiff is spawned in.
		--				 There are mission.Slot entries for SKIFF_ENTRY_SEQUENCE and SKIFF_EXIT_SEQUENCE. Unsure of how they should be used.
		
		--				 Current mission reference (https ://youtu.be/RyyXORKqp3c).
		
		--				 Some enemy squads should have a higher spawn count. I.e Squad.SQ_A_WAVE_ONE_815385C6 should probably have 3. Will fix that later.
		--				 Largest blockade, doors. Squads seem to not always report the fact that they died. Causing the arena_cleared call in check_arena_doors to report false.
		--				 check_arena_doors is called from on_event_squad_state
		
		--[[
			context:scene(mission.Scene.SCENE_OUTRO_FRIENDLY):activate{}
			context:squad(mission.Squad.SQ_FRIENDLY_81538177):place{}
			context:squad(mission.Squad.SQ_SKIFF):place{}
			context:squad(mission.Squad.SQ_SKIFF_PILOT):place{}
			context:scene(mission.Scene.SCENE_INTRO_FRIENDLY):send_event{key = 0xdf24c893}
			0xa703a771 despawn
			0xdf24c893 outro_trigger
			0xCF0F2A72 2.combat_1.fa_shanks_boss_rush
			place_squads(context, BLVD_ARENA)
		]]
		
		local military_squad_slots = {
					Slot.SQ_TANK_WAVE_ONE, -- Slot 0
					Slot.SQ_SNIPE_A_WAVE_ONE, -- Slot 1
					Slot.SQ_SNIPE_B_WAVE_ONE, -- Slot 1
					Slot.SQ_TANK_SERVITOR_A, -- Slot 2
					Slot.SQ_TANK_SERVITOR_D, -- Slot 2
					Slot.SQ_A_WAVE_ONE_8153855C, -- Slot 2 -- Resilient Solar Shield Shank x 2
					Slot.SQ_TANK_SERVITOR_B, -- Slot 3
					Slot.SQ_B_WAVE_ONE_8153855C, -- Slot 3 Resilient Solar Shield Shank x 4
					Slot.SQ_D_WAVE_ONE_8153855C, -- Slot 3 Resilient Marauder x 2
					Slot.SQ_TANK_SERVITOR_C, -- Slot 4
					Slot.SQ_C_WAVE_ONE_8153855C, -- Slot 4 Resilient Solar Shield Shank x 4
					Slot.SQ_E_WAVE_ONE_8153855C, -- Slot 4 Resilient Marauder x 2
					Slot.SQ_CATWALK_C_WAVE_ONE, -- Slot 5
					Slot.SQ_CATWALK_B_WAVE_ONE, -- Slot 6
					Slot.SQ_CATWALK_A_WAVE_ONE, -- Slot 7
					Slot.SQ_CATWALK_D_WAVE_ONE, -- Slot 8
				}
				for i, squad_slots in ipairs(military_squad_slots) do
					if i <= 3 then
						group = 0
					elseif i <= 5 then
						group = 1
					elseif i <= 6 then
						group = 2
					elseif i <= 9 then
						group = 3
					elseif i <= 12 then
						group = 4
					else
						group = i - 8
					end
					
					context:slot(squad_slots):assign_combat_objective{
						objective = context:slot(Slot.OBJ_MILITARY),
						task_group = mission.TaskGroup.OBJ_MILITARY["GROUP_" .. group],
					}
				end
				
				place_squads(context, MILITARY_A_ARENA_WAVE_ONE)
				place_squads(context, MILITARY_A_ARENA)
				
    end,

    on_event_region_changed = function(context, state, event)
        context:set_variable("last_region", event.region_index)

        if event.region_index == PLAZA then

			if not state:variable("plaza_visited.armed") then
				context:set_variable("plaza_visited.armed", true)
				set_directive(context, "plaza_entered")
				local squad_slots = {
					Slot.SQ_A_WAVE_ONE_815385C6,
					Slot.SQ_B_WAVE_ONE_815385C6,
					Slot.SQ_C_WAVE_ONE_815385C6,
					Slot.SQ_D_WAVE_ONE_815385C6,
					Slot.SQ_BOSS_C_815385C6,
					Slot.SQ_BOSS_A_815385C6,
					Slot.SQ_BOSS_B_815385C6,
					Slot.SQ_E_WAVE_ONE_815385C6,
					Slot.SQ_SNIPER_A,
					Slot.SQ_SNIPER_B,
					Slot.SQ_SNIPER_C,
				}
				
				-- group 0 SQ_A_WAVE_ONE_815385C6 position
				-- group 1 SQ_B_WAVE_ONE_815385C6 position
				-- group 2 SQ_C_WAVE_ONE_815385C6 position
				-- group 3 SQ_D_WAVE_ONE_815385C6 position
				-- group 4 SQ_BOSS_C_815385C6 position
				-- group 5 SQ_BOSS_A_815385C6 position
				-- group 6 SQ_BOSS_B_815385C6 position
				-- group 7 SQ_E_WAVE_ONE_815385C6 position
				-- group 8 most likley snipers (stationary)
				-- group 9 most likley snipers (stationary)

				for i, squad_slot in ipairs(squad_slots) do
					context:slot(squad_slot):assign_combat_objective{
						objective = context:slot(Slot.OBJ_PLAZA),
						task_group = mission.TaskGroup.OBJ_PLAZA["GROUP_" .. (i - 1)],
					}
				end
				
				--place_squads(context, PLAZA_ARENA_WAVE_ONE)
				place_squads(context, PLAZA_ARENA)
			end
        end
		
		if event.region_index == HANGAR then
			
			if not state:variable("hangar_visited.armed") then
				context:set_variable("hangar_visited.armed", true)
				
				--context:slot(Slot.PLAZA_MIL_DANGER):fire_trigger()
				--context:slot(Slot.MPT_MILITARY):fire_trigger()
				--context:slot(Slot.MPT_ITS_A_TRAP):fire_trigger()
				
				set_directive(context, "hangar_entered")
				
				-- 9 slots total to work with
				
				-- group 0 SQ_TANK_WAVE_ONE, SQ_TANK_SERVITOR_A, SQ_TANK_SERVITOR_D
				-- group 1 SQ_SNIPE_A_WAVE_ONE, SQ_SNIPE_B_WAVE_ONE
				-- group 2 SQ_A_WAVE_ONE_8153855C x2
				-- group 3 SQ_TANK_SERVITOR_B, SQ_B_WAVE_ONE_8153855C x4, SQ_D_WAVE_ONE_8153855C x2
				-- group 4 SQ_TANK_SERVITOR_C position, SQ_C_WAVE_ONE_8153855C x2, SQ_E_WAVE_ONE_8153855C
				-- group 5 SQ_CATWALK_C_WAVE_ONE x2
				-- group 6 SQ_CATWALK_B_WAVE_ONE x2
				-- group 7 SQ_CATWALK_A_WAVE_ONE x2
				-- group 8 SQ_CATWALK_D_WAVE_ONE x2
				
				local military_squad_slots = {
					Slot.SQ_TANK_WAVE_ONE, -- Slot 0
					Slot.SQ_SNIPE_A_WAVE_ONE, -- Slot 1
					Slot.SQ_SNIPE_B_WAVE_ONE, -- Slot 1
					Slot.SQ_TANK_SERVITOR_A, -- Slot 2
					Slot.SQ_TANK_SERVITOR_D, -- Slot 2
					Slot.SQ_A_WAVE_ONE_8153855C, -- Slot 2 -- Resilient Solar Shield Shank
					Slot.SQ_TANK_SERVITOR_B, -- Slot 3
					Slot.SQ_B_WAVE_ONE_8153855C, -- Slot 3 Resilient Solar Shield Shank x 3
					Slot.SQ_D_WAVE_ONE_8153855C, -- Slot 3 Resilient Marauder x 1
					Slot.SQ_TANK_SERVITOR_C, -- Slot 4
					Slot.SQ_C_WAVE_ONE_8153855C, -- Slot 4 Resilient Solar Shield Shank x 4
					Slot.SQ_E_WAVE_ONE_8153855C, -- Slot 4 Resilient Marauder x 2
					Slot.SQ_CATWALK_C_WAVE_ONE, -- Slot 5
					Slot.SQ_CATWALK_B_WAVE_ONE, -- Slot 6
					Slot.SQ_CATWALK_A_WAVE_ONE, -- Slot 7
					Slot.SQ_CATWALK_D_WAVE_ONE, -- Slot 8
				}
				for i, squad_slots in ipairs(military_squad_slots) do
					if i <= 1 then
						group = 0
					elseif i <= 3 then
						group = 1
					elseif i <= 6 then
						group = 2
					elseif i <= 9 then
						group = 3
					elseif i <= 12 then
						group = 4
					else
						group = i - 8
					end
					
					context:slot(squad_slots):assign_combat_objective{
						objective = context:slot(Slot.OBJ_MILITARY),
						task_group = mission.TaskGroup.OBJ_MILITARY["GROUP_" .. group],
					}
				end
				
				local military_indoors_squad_slots = {
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
				}
				
				for i, squad_slots in ipairs(military_indoors_squad_slots) do
					local group

					if i <= 3 then
						group = 0
					else
						group = i - 3
					end
				
					context:slot(squad_slots):assign_combat_objective{
						objective = context:slot(Slot.OBJ_MILITARY_INDOOR),
						task_group = mission.TaskGroup.OBJ_MILITARY_INDOOR["GROUP_" .. group],
					}
				end
				
				--place_squads(context, MILITARY_A_ARENA_WAVE_ONE)
				place_squads(context, MILITARY_A_ARENA)
				place_squads(context, MILITARY_INDOOR_ARENA)
			end
			
		end
		
		if event.region_index == TOWER_WATCH then
		
			if not state:variable("tower_watch_visited.armed") then 
				context:set_variable("tower_watch_visited.armed", true)
				
				set_directive(context, "uw_entered")
				
				local underwatch_squad_slots = {
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
				}

				for i, squad_slot in ipairs(underwatch_squad_slots) do
					context:slot(squad_slot):assign_combat_objective{
						objective = context:slot(Slot.OBJ_UNDERWATCH),
						task_group = mission.TaskGroup.OBJ_UNDERWATCH["GROUP_" .. (i - 1)],
					}
				end
				
				place_squads(context, UNDERWATCH_ARENA)
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
				
				set_directive(context, "passage_entered")
			end
		end
		
		if event.region_index == VENTILATION then

			if not state:variable("ventilation_visited.armed") then
				context:set_variable("ventilation_visited.armed", true)
				
				--context:slot(Slot.MPT_ENTER_STAIRWELL):fire_trigger()
				--context:slot(Slot.MPT_T_R_E_V_O_R):fire_trigger()
				--context:slot(Slot.MPT_ESCAPE_THE_VENTS):fire_trigger()
				
				set_directive(context, "ventilation_entered")
			end
		end
		
		if event.region_index == VAULT then

			for i = 0, 29 do
				context:slot(Slot["CRYPTARCH_MAZE_1_PM_MAZE_TILES_" .. i]):set_occupancy_condition{value = 1}
			end
			
			if not state:variable("vault_visited.armed") then
				context:set_variable("vault_visited.armed", true)
				
				--context:slot(Slot.MPT_VAULT):fire_trigger()
				--context:slot(Slot.MPT_VAULT_END):fire_trigger()
				
				set_directive(context, "vault_entered")
				
				context:slot(Slot.CRYPTARCH_MAZE_1_PM_KILL_AREA):set_occupancy_condition{value = 1, filter = context:slot(Slot.CRYPTARCH_MAZE_1_OF_KILL_AREA)}
			end
		end
		
		if event.region_index == OUTRO_REGION then
		
			if not state:variable("outro_region_visited.armed") then
				context:set_variable("outro_region_visited.armed", true)
				
				context:slot(Slot.PT_BOSS_SPAWN):fire_trigger()
				
				set_directive(context, "outro_entered")
				
				-- Enemy OBJ for outro fight
				-- OBJ_BOSS, OBJ_ADDS, OBJ_INTRO
				
				-- context:complete_mission{}
			end
		end
    end,

    on_event_client_state_changed = function(context, state, event)
        if event.entered == true
            and event.held_region_index == INTRO_REGION
            and not state:variable("intro.sent") then

            context:set_variable("intro.sent", true)
            set_directive(context, "blvd_entered")

            context:squad(mission.Squad.SQ_DREG_TARGET):place{}
            context:scene(mission.Scene.SCENE_INTRO_FRIENDLY):activate{}

            context:slot(Slot.PT_ENTRY):fire_trigger()
			
			local squad_slots = {
				Slot.SQ_A_WAVE_ONE_8153806D,
				Slot.SQ_B_WAVE_ONE_8153806D,
				Slot.SQ_C_WAVE_ONE_8153806D,
				Slot.SQ_D_WAVE_ONE_8153806D,
				Slot.SQ_E_WAVE_ONE_8153806D,
				Slot.SQ_F_WAVE_ONE_8153806D,
			}

			for i, squad_slot in ipairs(squad_slots) do
				context:slot(squad_slot):assign_combat_objective{
					objective = context:slot(Slot.OBJ_BLVD),
					task_group = mission.TaskGroup.OBJ_BLVD["GROUP_" .. (i - 1)],
				}
			end
        end
    end,

    on_event_player_trigger = function(context, state, event)
        if event.slot == nil then return end

        if lib.is_slot(context, event, Slot.PT_ENTRY) then
			context:slot(Slot.PT_ENTRY):disarm_trigger()
		
            context:squad(mission.Squad.SQ_FRIENDLY_8153806D):place{}
            context:scene(mission.Scene.SCENE_INTRO_FRIENDLY):send_event{key = 0x7d465556}
			
			place_squads(context, BLVD_ARENA)
        end
		
		if lib.is_slot(context, event, Slot.MPT_MILITARY) then
			context:slot(Slot.MPT_MILITARY):disarm_trigger()
		end
		
		if lib.is_slot(context, event, Slot.MPT_ITS_A_TRAP) then
			context:slot(Slot.MPT_ITS_A_TRAP):disarm_trigger()
		end
    end,

    on_event_timer_elapsed = function(context, state, event)
		if event.timer_name == "arena_checker" then
			check_arena_doors(context, state)
			context:start_timer("arena_checker", 2000)
		end
    end,
	
	on_event_squad_state = function(context, state, event)
		for i, sq in ipairs(BLVD_ARENA) do
			if context:cohort{squads = {sq.squad}}.cleared then
				context:set_variable("blvd.dbg." .. i-1, true)
			end
		end

		for i, sq in ipairs(PLAZA_ARENA) do
			if context:cohort{squads = {sq.squad}}.cleared then
				context:set_variable("plaza.dbg." .. i-1, true)
			end
		end

		--[[
		for i, sq in ipairs(MILITARY_A_ARENA_WAVE_ONE) do
			if context:cohort{squads = {sq.squad}}.cleared then
				context:set_variable("mili_a_w_1.dbg." .. i-1, true)
			end
		end]]

		for i, sq in ipairs(MILITARY_A_ARENA) do
			if context:cohort{squads = {sq.squad}}.cleared then
				context:set_variable("mili_a.dbg." .. i-1, true)
			end
		end

		for i, sq in ipairs(MILITARY_INDOOR_ARENA) do
			if context:cohort{squads = {sq.squad}}.cleared then
				context:set_variable("mili_indoor.dbg." .. i-1, true)
			end
		end

		for i, sq in ipairs(UNDERWATCH_ARENA) do
			if context:cohort{squads = {sq.squad}}.cleared then
				context:set_variable("underwatch.dbg." .. i-1, true)
			end
		end
	
		check_arena_doors(context, state)
    end,
	
	on_event_object_interacted = function(context, state, event)
		if lib.is_slot(context, event, Slot.CRYPTARCH_MAZE_1_O_SECURITY_SWITCH) then
			context:set_variable("security_disabled", true)
			-- This enables burn mode. No damage, Evil switch >:)
			context:slot(Slot.CRYPTARCH_MAZE_1_D_SECURITY):transition{
				transition = context.sdk.device_transitions.open,
			}
		end
	end,
	
	on_event_trigger_entered = function(context, state, event)
		if lib.is_slot(context, event, Slot.CRYPTARCH_MAZE_1_PM_KILL_AREA) then
			-- event.member_count, event.all_inside
		end
	end,
}