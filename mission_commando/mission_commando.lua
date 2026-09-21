local missions = require("missions")
local mission = require(missions.MISSION_COMMANDO)
local lib = require("lib.mission_lib")
local combat = require("lib.combat")
local Slot, Squad, Scene, Directive = mission.Slot, mission.Squad, mission.Scene, mission.Directive
local sensor = mission.Slot.M_DIRECTIVE_SENSOR
local cues = mission.DialogueCue.M_DIALOG_SENSOR

local HEROIC = false

local INTRO_REGION = mission.states.STATE_81538016_0000_0000_8153800E.region_index -- 
local PLAZA = mission.states.STATE_81538016_0006_0000_81538014.region_index -- 48
local HANGAR = mission.states.STATE_81538016_0005_0000_81538013.region_index -- 40
local TOWER_WATCH = mission.states.STATE_81538016_0007_0000_81538015.region_index -- 56
local PASSAGE = mission.states.STATE_81538016_0003_0000_81538011.region_index -- 24
local VENTILATION = mission.states.STATE_81538016_0002_0000_81538010.region_index -- 16
local VAULT = mission.states.STATE_81538016_0004_0000_81538012.region_index -- 32
local OUTRO_REGION = mission.states.STATE_81538016_0001_0000_8153800F.region_index -- 8

local BLVD_ARENA = {Squad.SQ_A_WAVE_ONE_8153806D, Squad.SQ_B_WAVE_ONE_8153806D, Squad.SQ_C_WAVE_ONE_8153806D, Squad.SQ_D_WAVE_ONE_8153806D, Squad.SQ_E_WAVE_ONE_8153806D, Squad.SQ_F_WAVE_ONE_8153806D}
local PLAZA_ARENA = {Squad.SQ_A_WAVE_ONE_815385C6, Squad.SQ_B_WAVE_ONE_815385C6, Squad.SQ_C_WAVE_ONE_815385C6, Squad.SQ_D_WAVE_ONE_815385C6, Squad.SQ_E_WAVE_ONE_815385C6, Squad.SQ_SNIPER_A, Squad.SQ_SNIPER_B, Squad.SQ_BOSS_C_815385C6, Squad.SQ_BOSS_A_815385C6, Squad.SQ_BOSS_B_815385C6, Squad.SQ_SNIPER_C}
local MILITARY_A_ARENA_WAVE_ONE = {Squad.SQ_A_WAVE_ONE_8153855C, Squad.SQ_B_WAVE_ONE_8153855C, Squad.SQ_C_WAVE_ONE_8153855C, Squad.SQ_D_WAVE_ONE_8153855C, Squad.SQ_E_WAVE_ONE_8153855C}
local MILITARY_A_ARENA = {Squad.SQ_SNIPE_A_WAVE_ONE, Squad.SQ_SNIPE_B_WAVE_ONE, Squad.SQ_CATWALK_A_WAVE_ONE, Squad.SQ_CATWALK_B_WAVE_ONE, Squad.SQ_CATWALK_C_WAVE_ONE, Squad.SQ_CATWALK_D_WAVE_ONE, Squad.SQ_TANK_WAVE_ONE, Squad.SQ_TANK_SERVITOR_A, Squad.SQ_TANK_SERVITOR_B, Squad.SQ_TANK_SERVITOR_C, Squad.SQ_TANK_SERVITOR_D}
local MILITARY_INDOOR_ARENA = {Squad.SQ_A_AMBUSH, Squad.SQ_B_AMBUSH, Squad.SQ_C_AMBUSH, Squad.SQ_A_INDOOR, Squad.SQ_B_INDOOR, Squad.SQ_C_INDOOR, Squad.SQ_D_INDOOR, Squad.SQ_E_INDOOR, Squad.SQ_F_INDOOR, Squad.SQ_HEAVY_INDOOR}
local UNDERWATCH_ARENA = {Squad.SQ_A_HALL, Squad.SQ_D_HALL, Squad.SQ_B_HALL, Squad.SQ_C_HALL, Squad.SQ_A_PVP, Squad.SQ_B_PVP, Squad.SQ_C_PVP, Squad.SQ_A_RETREAT, Squad.SQ_B_RETREAT, Squad.SQ_C_RETREAT}

-- local OUTRO_ARENA = {}

-- Squads that share a spawn rule (and anchor) with another squad. Placing both
-- in the same tick seems to make one of them fail sometimes, so the later
-- squad is placed only after its twin has reported in:
--   when = "alive"   -> as soon as the twin is seen alive (both end up in play)
--   when = "cleared" -> once the twin is cleared
-- `after` is the variable that says the arena has started.
local LATE = {
    {id = "blvd_c",         after = "intro.sent",          when = "alive",
        twin = Squad.SQ_B_WAVE_ONE_8153806D, twin_slot = Slot.SQ_B_WAVE_ONE_8153806D,
        squad = Squad.SQ_C_WAVE_ONE_8153806D},
    {id = "plaza_boss_a",   after = "plaza_visited.armed", when = "cleared",
        twin = Squad.SQ_D_WAVE_ONE_815385C6, twin_slot = Slot.SQ_D_WAVE_ONE_815385C6,
        squad = Squad.SQ_BOSS_A_815385C6},
    {id = "plaza_boss_b",   after = "plaza_visited.armed", when = "cleared",
        twin = Squad.SQ_E_WAVE_ONE_815385C6, twin_slot = Slot.SQ_E_WAVE_ONE_815385C6,
        squad = Squad.SQ_BOSS_B_815385C6},
    {id = "plaza_sniper_b", after = "plaza_visited.armed", when = "alive",
        twin = Squad.SQ_SNIPER_A, twin_slot = Slot.SQ_SNIPER_A,
        squad = Squad.SQ_SNIPER_B},
}

-- Shared-rule groups with more than two squads (or in other arenas) are held
-- back as a chain: each squad is placed once the one before it is seen alive.
local function chain(id, after, names)
	for i = 2, #names do
		assert(Squad[names[i - 1]] and Squad[names[i]], "unknown squad in chain " .. id)
		LATE[#LATE + 1] = {
			id = id .. "_" .. names[i], after = after, when = "alive",
			twin = Squad[names[i - 1]], twin_slot = Slot[names[i - 1]],
			squad = Squad[names[i]],
		}
	end
end

chain("mil_wave", "hangar_visited.armed", {"SQ_A_WAVE_ONE_8153855C", "SQ_B_WAVE_ONE_8153855C", "SQ_C_WAVE_ONE_8153855C", "SQ_D_WAVE_ONE_8153855C", "SQ_E_WAVE_ONE_8153855C"})
chain("mil_snipe", "hangar_visited.armed", {"SQ_SNIPE_A_WAVE_ONE", "SQ_SNIPE_B_WAVE_ONE"})
chain("mil_catwalk", "hangar_visited.armed", {"SQ_CATWALK_A_WAVE_ONE", "SQ_CATWALK_B_WAVE_ONE", "SQ_CATWALK_C_WAVE_ONE", "SQ_CATWALK_D_WAVE_ONE"})
chain("mil_ambush", "hangar_visited.armed", {"SQ_A_AMBUSH", "SQ_B_AMBUSH", "SQ_C_AMBUSH"})
chain("mil_indoor", "hangar_visited.armed", {"SQ_A_INDOOR", "SQ_B_INDOOR", "SQ_C_INDOOR", "SQ_D_INDOOR", "SQ_E_INDOOR", "SQ_F_INDOOR"})
chain("hall", "tower_watch_visited.armed", {"SQ_A_HALL", "SQ_D_HALL"})
chain("pvp", "tower_watch_visited.armed", {"SQ_A_PVP", "SQ_C_PVP"})

local LATE_SQUADS = {}
local LATE_BY_SQUAD = {}
for _, late in ipairs(LATE) do
	LATE_SQUADS[late.squad] = true
	LATE_BY_SQUAD[late.squad] = late
end

-- A squad waiting on a twin that never reports in is placed anyway after this
-- many ticks of the arena_checker timer (2 s each). Only for when = "alive".
local LATE_TIMEOUT_TICKS = 5

-- True once the squad this one waits on has itself been placed.
local function twin_placed(state, late)
	local prior = LATE_BY_SQUAD[late.twin]
	return prior == nil or state:variable("late_placed." .. prior.id)
end

-- Place every squad in the list except the ones held back in LATE.
local function place_now(context, arena_squads)
	for _, sq in ipairs(arena_squads) do
		if not LATE_SQUADS[sq] then
			context:squad(sq):place{}
		end
	end
end

local ARENAS = {
    {
        id = "blvd",
        squads = BLVD_ARENA,
        doors = {Slot.D_EMITTER_BOULEVARD, Slot.D_SHIELD_BOULEVARD},
    },
    {
        id = "plaza",
        squads = PLAZA_ARENA,
        doors = {Slot.D_EMITTER_PLAZA, Slot.D_SHIELD_PLAZA},
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
    },
	{
        id = "underwatch",
        squads = UNDERWATCH_ARENA,
        doors = {Slot.D_EMITTER_UNDERWATCH, Slot.D_SHIELD_UNDERWATCH},
    },
	{
        id = "outro_arena",
        squads = PLAZA_ARENA,
    },
}

local function arena_cleared(context, arena)
    return context:cohort{squads = arena.squads}.cleared
end

local function place_squads(context, arena_squads)
	for i, sq in ipairs(arena_squads) do
		context:squad(sq):place{}
	end
end

return {
    initial_state = {
        region_index = INTRO_REGION,
        spawn_set_hash = 0x2EA8FB98,
    },

    -- Runs once, when the mission starts for the first time.
    on_start = function(context, state)
        context:set_variable("mission_zero_hour_script", "started")
		context:start_timer("arena_checker", 2000)
    end,

    on_load = function(context, state)
        context:set_variable("reloaded", true)
    end,

    on_event_region_changed = function(context, state, event)
        context:set_variable("last_region", event.region_index)
        local seen = state:variable("regions_seen") or 0
        context:set_variable("regions_seen", seen + 1)

        if event.region_index == PLAZA then
			if not state:variable("plaza_visited.armed") then
				context:set_variable("plaza_visited.armed", true)
				local squad_slots = {
					Slot.SQ_A_WAVE_ONE_815385C6,
					Slot.SQ_B_WAVE_ONE_815385C6,
					Slot.SQ_C_WAVE_ONE_815385C6,
					Slot.SQ_D_WAVE_ONE_815385C6,
					Slot.SQ_E_WAVE_ONE_815385C6,
					Slot.SQ_SNIPER_A,
					Slot.SQ_SNIPER_B, -- Missing in arena report nr.6
					Slot.SQ_BOSS_C_815385C6,
					Slot.SQ_BOSS_A_815385C6, -- Missing in arena report nr.8
					Slot.SQ_BOSS_B_815385C6, -- Missing in arena report nr.9
					Slot.SQ_SNIPER_C,
				}

				for i, squad_slot in ipairs(squad_slots) do
					context:slot(squad_slot):assign_combat_objective{
						objective = context:slot(Slot.OBJ_PLAZA),
						task_group = mission.TaskGroup.OBJ_PLAZA["GROUP_" .. (i - 1)],
					}
				end
				
				place_now(context, PLAZA_ARENA)
			end
        end
		
		if event.region_index == HANGAR then
			if not state:variable("hangar_visited.armed") then
				--context:slot(Slot.PLAZA_MIL_DANGER):fire_trigger()
				--context:slot(Slot.MPT_MILITARY):fire_trigger()
				--context:slot(Slot.MPT_ITS_A_TRAP):fire_trigger()
				context:set_variable("hangar_visited.armed", true)
				local military_squad_slots = {
					Slot.SQ_A_WAVE_ONE_8153855C,
					Slot.SQ_B_WAVE_ONE_8153855C,
					Slot.SQ_C_WAVE_ONE_8153855C,
					Slot.SQ_D_WAVE_ONE_8153855C,
					Slot.SQ_E_WAVE_ONE_8153855C,
					Slot.SQ_SNIPE_A_WAVE_ONE,
					Slot.SQ_SNIPE_B_WAVE_ONE,
					Slot.SQ_CATWALK_A_WAVE_ONE,
					Slot.SQ_CATWALK_B_WAVE_ONE,
					Slot.SQ_CATWALK_C_WAVE_ONE,
					Slot.SQ_CATWALK_D_WAVE_ONE,
					Slot.SQ_TANK_WAVE_ONE,
					Slot.SQ_TANK_SERVITOR_A,
					Slot.SQ_TANK_SERVITOR_B,
					Slot.SQ_TANK_SERVITOR_C,
					Slot.SQ_TANK_SERVITOR_D,
				}

				for i, squad_slots in ipairs(military_squad_slots) do
					local group

					if i <= 5 then
						group = 1
					elseif i <= 7 then
						group = 2
					else
						group = i - 5
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
				
				for i, squad_slots in ipairs(military_squad_slots) do
					local group

					if i <= 3 then
						group = 0
					else
						group = i - 3
					end

					context:slot(squad_slots):assign_combat_objective{
						objective = context:slot(Slot.OBJ_MILITARY),
						task_group = mission.TaskGroup.OBJ_MILITARY["GROUP_" .. group],
					}
				end
				
				place_now(context, MILITARY_A_ARENA_WAVE_ONE)
				place_now(context, MILITARY_A_ARENA)
				place_now(context, MILITARY_INDOOR_ARENA)
			end
			
		end
		
		if event.region_index == TOWER_WATCH then
			if not state:variable("tower_watch_visited.armed") then 
				context:set_variable("tower_watch_visited.armed", true)
				local underwatch_squad_slots = {
					Slot.SQ_A_HALL,
					Slot.SQ_D_HALL,
					Slot.SQ_B_HALL,
					Slot.SQ_C_HALL,
					Slot.SQ_A_PVP,
					Slot.SQ_B_PVP,
					Slot.SQ_C_PVP,
					Slot.SQ_A_RETREAT,
					Slot.SQ_B_RETREAT,
					Slot.SQ_C_RETREAT,
				}

				for i, squad_slot in ipairs(underwatch_squad_slots) do
					local group

					if i <= 2 then
						group = 1
					else
						group = i - 1
					end

					context:slot(squad_slot):assign_combat_objective{
						objective = context:slot(Slot.OBJ_UNDERWATCH),
						task_group = mission.TaskGroup.OBJ_UNDERWATCH["GROUP_" .. group],
					}
				end
				
				place_now(context, UNDERWATCH_ARENA)
			end
			
		end
		
		if event.region_index == PASSAGE then
			if HEROIC then
				context:slot(Slot.O_NORMAL_TOP_BLOCK_A):set_object_active{active = true}
				context:slot(Slot.O_NORMAL_TOP_BLOCK_B):set_object_active{active = true}
				context:slot(Slot.O_NORMAL_FANS_BLOCK):set_object_active{active = true}
			else
				context:slot(Slot.O_HEROIC_TOP_BLOCK):set_object_active{active = true}
				context:slot(Slot.O_HEROIC_FANS_BLOCK):set_object_active{active = true}
			end
			if not state:variable("passage_visited.armed") then
				context:set_variable("passage_visited.armed", true)
				-- context:slot(Slot.MPT_A_SHIP):fire_trigger()
				-- context:slot(Slot.NORMAL_SHORT_TOP_VENT):fire_trigger()
				-- context:slot(Slot.MPT_LONG_WAY_DOWN):fire_trigger()
				-- context:slot(Slot.MPT_LWD_END):fire_trigger()
				-- context:slot(Slot.MPT_THE_FANS):fire_trigger()
			end
		end
		
		if event.region_index == VENTILATION then
			if not state:variable("ventilation_visited.armed") then
				context:set_variable("ventilation_visited.armed", true)
				--context:slot(Slot.MPT_ENTER_STAIRWELL):fire_trigger()
				--context:slot(Slot.MPT_T_R_E_V_O_R):fire_trigger()
			end
		end
		
		if event.region_index == VAULT then
			for i = 0, 29 do
				context:slot(Slot["CRYPTARCH_MAZE_1_PM_MAZE_TILES_" .. i]):set_occupancy_condition{value = 1}
			end
			
			-- Spawns switch that toggles security and makes it interactable
			context:slot(Slot.CRYPTARCH_MAZE_1_O_SECURITY_SWITCH):set_object_active{active = true}
			context:slot(Slot.CRYPTARCH_MAZE_1_O_SECURITY_SWITCH):set_interactable_object{used = true}
			
			if not not state:variable("vault_visited.armed") then
				context:set_variable("vault_visited.armed", true)
				--context:slot(Slot.MPT_VAULT):fire_trigger()
				--context:slot(Slot.MPT_VAULT_END):fire_trigger()
			end
		end
		
		if event.region_index == OUTRO_REGION then
			if not state:variable("outro_region_visited.armed") then
				context:set_variable("outro_region_visited.armed", true)
				context:slot(Slot.PT_BOSS_SPAWN):fire_trigger()
			end
		end
    end,

    on_event_client_state_changed = function(context, state, event)
        if event.entered == true
            and event.held_region_index == INTRO_REGION
            and not state:variable("intro.sent") then

            context:set_variable("intro.sent", true)
            context:slot(Slot.M_DIRECTIVE_SENSOR):set_directive{
                directive = Directive.ENEMY_TARGET_EXFILTRATION,
            }

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
			
			place_now(context, BLVD_ARENA)
        end
    end,

    on_event_player_trigger = function(context, state, event)
        if event.slot == nil then return end

        if lib.is_slot(context, event, Slot.PT_ENTRY) then
			context:slot(Slot.PT_ENTRY):disarm_trigger()
		
            context:squad(mission.Squad.SQ_FRIENDLY_8153806D):place{}
            context:scene(mission.Scene.SCENE_INTRO_FRIENDLY):send_event{key = 0x7d465556}
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
			for _, arena in ipairs(ARENAS) do
					local key = arena.id .. ".arena_cleared"

					if not state:variable(key) and arena_cleared(context, arena) then
						context:set_variable(key, true)
						
						if arena.doors then
							for _, door in ipairs(arena.doors) do
								context:slot(door):transition{
									transition = context.sdk.device_transitions.open,
								}
							end
						end
					end
			end
			-- Fallback for chains stuck on a twin that never reported in.
			for _, late in ipairs(LATE) do
				local key = "late_placed." .. late.id
				if late.when == "alive" and state:variable(late.after)
					and not state:variable(key) and twin_placed(state, late) then
					local wkey = "late_wait." .. late.id
					local waited = (state:variable(wkey) or 0) + 1
					context:set_variable(wkey, waited)
					if waited >= LATE_TIMEOUT_TICKS then
						context:set_variable(key, true)
						context:squad(late.squad):place{}
					end
				end
			end

			context:start_timer("arena_checker", 2000)
		end
    end,
	
    on_event_squad_state = function(context, state, event)
		for _, late in ipairs(LATE) do
			local key = "late_placed." .. late.id
			if state:variable(late.after) and not state:variable(key) then
				local ready = context:cohort{squads = {late.twin}}.cleared
				if late.when == "alive" and lib.is_slot(context, event, late.twin_slot)
					and event.alive_count > 0 then
					ready = true
				end
				if ready then
					context:set_variable(key, true)
					context:squad(late.squad):place{}
				end
			end
		end

		for i, sq in ipairs(BLVD_ARENA) do
			if context:cohort{squads = {sq}}.cleared then
				context:set_variable("blvd.dbg." .. i-1, true)
			end
		end
			
		for i, sq in ipairs(PLAZA_ARENA) do
			if context:cohort{squads = {sq}}.cleared then
				context:set_variable("plaza.dbg." .. i-1, true)
			end
		end
			
		for i, sq in ipairs(MILITARY_A_ARENA_WAVE_ONE) do
			if context:cohort{squads = {sq}}.cleared then
				context:set_variable("mili_a_w_1.dbg." .. i-1, true)
			end
		end
			
		for i, sq in ipairs(MILITARY_A_ARENA) do
			if context:cohort{squads = {sq}}.cleared then
				context:set_variable("mili_a.dbg." .. i-1, true)
			end
		end
			
		for i, sq in ipairs(MILITARY_INDOOR_ARENA) do
			if context:cohort{squads = {sq}}.cleared then
				context:set_variable("mili_indoor.dbg." .. i-1, true)
			end
		end
		
		for i, sq in ipairs(UNDERWATCH_ARENA) do
			if context:cohort{squads = {sq}}.cleared then
				context:set_variable("underwatch.dbg." .. i-1, true)
			end
		end
    end,
	
	on_event_object_interacted = function(context, state, event)
    if lib.is_slot(context, event, Slot.CRYPTARCH_MAZE_1_O_SECURITY_SWITCH) then
        context:set_variable("security_disabled", true)
    end
end,
}

--[[
MPT triggers are music triggers

This enables burn mode. No damage
context:slot(Slot.CRYPTARCH_MAZE_1_D_SECURITY):transition{
	transition = context.sdk.device_transitions.open,
}
]]