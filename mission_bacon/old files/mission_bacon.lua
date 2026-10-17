local missions = require("missions")
local mission = require(missions.MISSION_BACON)
local lib = require("lib.mission_lib")
local Slot, Directive, Squad, Scene = mission.Slot, mission.Directive, mission.Squad, mission.Scene
local dialog_sensor = mission.Slot.M_DIALOG_SENSOR_80F6A396
local cues = mission.DialogueCue.M_DIALOG_SENSOR_80F6A396

local INTRO_REGION = mission.states.STATE_80F6A028_0005_0000_80F6A984.region_index  -- 40 | Glacial drift
local DYNAMO_APPROACH = mission.states.STATE_80F6A028_0008_0000_80F6A99B.region_index -- 64
local BRAYTECH_FUTURESCAPES = mission.states.STATE_80F6A028_0001_0000_80F6A01C.region_index -- 8
local AURORA_REACH = mission.states.STATE_80F6A028_0009_0000_80F6A99C.region_index -- 72
local MINDLAB_RASPUTIN = mission.states.STATE_80F6A028_000A_0000_80F6A9A8.region_index -- 80

local triggers = {
	intro = {
		Slot.PT_INTRO_DIRECTIVE,
		Slot.PT_ENDPHASE,
		Slot.PT_ENDPHASE_ALT,
		Slot.PT_SPAWN_DROPSHIPS_RIGHT,
		Slot.PT_SPAWN_DROPSHIPS_LEFT,
		Slot.PT_GOTO_BRAY_RIGHT,
		Slot.PT_GOTO_BRAY_LEFT,
	},
	futurescapes_onload = {
		Slot.PT_SPAWN_DROPSHIPS_RIGHT,
		Slot.PT_SPAWN_DROPSHIPS_LEFT,
		Slot.PT_GOTO_BRAY_RIGHT,
		Slot.PT_GOTO_BRAY_LEFT,
		Slot.PT_SEED_PROPS,
		Slot.PT_BYPASS_RIGHT,
		Slot.PT_BYPASSED_LEFT,
		Slot.PT_ACTIVATE_BOSS_WAYPOINT,
		Slot.PT_START_BALCONY_MONITOR,
	},
	aurora_reach = {
		Slot.PT_LOCATE_ENTRANCE,
		Slot.PT_END_PHASE_80F6A1DD,
	},
	mindlab_onload = {
		Slot.PT_SPAWN_LOWER_ENCOUNTERS,
		Slot.PT_MUS_HIVE_ATTACK,
		Slot.PT_ELEVATOR_SEED_PROPS,
		Slot.PT_ELEVATOR_SPAWN_WIZARDS,
		Slot.PT_ELEVATOR_SPAWN_MELEE,
		Slot.PT_ASCENSION_ELEVATOR,
		Slot.PT_SPAWN_OVERRIDES_OFF,
		Slot.PT_PIPES_SPAWN_BACK,
		Slot.PT_SPAWN_OVERRIDES_ON,
		Slot.PT_HIVE_MUSIC_END,
		Slot.PT_ASCENSION_CABLE,
		Slot.PT_ASCENSION_CABLE_2,
		Slot.PT_SPAWN_SPEAR_INTRO,
		Slot.PT_LEFT_HIVE_MUSIC_END,
		Slot.PT_LEFT_ASCENSION_CABLE,
		Slot.PT_LEFT_ASCENSION_CABLE_2,
		Slot.PT_SPAWN_SPEAR_INTRO_ALT,
	},
	mindlab_onjavelin = {
		Slot.PT_HOOK_TROOPER_FALLBACK,
		Slot.PT_HOOK_SPAWN_THRALL,
		Slot.PT_HOOK_SPAWN_THRALL_1,
		Slot.PT_THRONE_SPAWN_ENCOUNTER,
		Slot.PT_SPAWN_LOWER_ENEMIES_GATE,
		Slot.PT_ASCENSION_LEFT,
		Slot.PT_THRONE_WAKE_COMBATANTS,
		Slot.PT_MACHINE_GOD,
	},
}

local ARENAS = {
	{
        id = "bray_futurescapes",
		trigger = Slot.PT_SIGNAL_ANA,
		directive = Directive.CLEAR_A_PATH_TO_CLOVIS_BRAY,
		navpoint = Slot.NP_ACTIVATE_CONSOLE,
		WAVE_KEYS = {
			"squad_intro",
			"squad_a", "squad_reinforce_a1", "squad_reinforce_a1_alt", "squad_reinforce_a2",
			"squad_b", "squad_reinforce_b", "squad_reinforce_b_alt",
			"squad_c", "squad_reinforce_c", "squad_reinforce_c_alt",
			"squad_boss",
		},
		squads = {
			squad_intro = {
				{squad = "INTRO_SQUAD_A", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 0},
				{squad = "INTRO_SQUAD_B", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 0},
				{squad = "INTRO_SQUAD_C", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 0},
				{squad = "INTRO_SQUAD_D", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 0},
			},
			squad_a = {
				{squad = "COURTYARD_SQUAD_A", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 3},
				{squad = "COURTYARD_SQUAD_A_1", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 3},
				{squad = "COURTYARD_SQUAD_A_2", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 3},
			},
			squad_b = {
				{squad = "COURTYARD_SQUAD_B", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 1},
				{squad = "COURTYARD_SQUAD_B_1", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 1},
			},
			squad_c = {
				{squad = "COURTYARD_SQUAD_C", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 2},
				{squad = "COURTYARD_SQUAD_C_1", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 2},
			},
			squad_boss = {
				{squad = "INTERIOR_SQUAD_BOSS", count = 1, default_objective = "BOSS_OBJECTIVE", default_group = 0},
				{squad = "INTERIOR_SQUAD_A", count = 1, default_objective = "BOSS_OBJECTIVE", default_group = 1},
				{squad = "INTERIOR_SQUAD_B", count = 1, default_objective = "BOSS_OBJECTIVE", default_group = 2},
				{squad = "INTERIOR_SQUAD_C", count = 1, default_objective = "BOSS_OBJECTIVE", default_group = 3},
				{squad = "INTERIOR_SQUAD_D", count = 1, default_objective = "BOSS_OBJECTIVE", default_group = 4},
				{squad = "INTERIOR_SQUAD_E", count = 1, default_objective = "BOSS_OBJECTIVE", default_group = 5},
			},
		},
    },
	{
        id = "elevator",
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
	{
        id = "pipes",
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
	{
        id = "spear_intro",
		objective = "MAIN_OBJECTIVE_80F6A334",
        squads = {
			{squad = "SPEAR_INTRO_SQUAD_A", count = 1, default_group = 10}, -- Knight
			{squad = "SPEAR_INTRO_SQUAD_B", count = 2, default_group = 11}, -- Acolyte
			{squad = "SPEAR_INTRO_SQUAD_C", count = 1, default_group = 12}, -- Ogre
			{squad = "SPEAR_INTRO_SQUAD_D", count = 1, default_group = 11}, -- Acolyte
			{squad = "SPEAR_INTRO_SQUAD_E", count = 1, default_group = 14}, -- Acolyte, jumps
		},
    },
	{
        id = "lower_gate",
		objective = "MAIN_OBJECTIVE_80F6A334",
        squads = {
			{squad = "HOOK_TROOPER_A_SQUAD", count = 1, default_group = 15},
			{squad = "HOOK_TROOPER_B_SQUAD", count = 4, default_group = 16},
			{squad = "HOOK_TROOPER_C_SQUAD", count = 3, default_group = 19},
			{squad = "HOOK_TROOPER_D_SQUAD", count = 3, default_group = 18},
		},
    },
	{
        id = "throne",
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
	{
		id = "futurescapes_reinforce",
		WAVE_KEYS = {
			"squad_reinforce_a1", "squad_reinforce_a1_alt",
			"squad_reinforce_a2",
			"squad_reinforce_b", "squad_reinforce_b_alt",
			"squad_reinforce_c", "squad_reinforce_c_alt",
		},
		squads = {
			squad_reinforce_a1 = {
				{squad = "REINFORCE_SQUAD_A_1", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 3},
			},
			squad_reinforce_a1_alt = {
				{squad = "REINFORCE_SQUAD_A_1_ALT", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 3},
			},
			squad_reinforce_a2 = {
				{squad = "REINFORCE_SQUAD_A_2", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 3},
			},
			squad_reinforce_b = {
				{squad = "REINFORCE_SQUAD_B", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 1},
			},
			squad_reinforce_b_alt = {
				{squad = "REINFORCE_SQUAD_B_ALT", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 1},
			},
			squad_reinforce_c = {
				{squad = "REINFORCE_SQUAD_C", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 2},
			},
			squad_reinforce_c_alt = {
				{squad = "REINFORCE_SQUAD_C_ALT", count = 1, default_objective = "MAIN_OBJECTIVE_80F6A0E6", default_group = 2},
			},
		},
	},
}

local function arm_triggers(context, trigger_array)
	for _, entry in ipairs(trigger_array) do
		context:slot(entry):fire_trigger()
	end
end

local function set_directive(context, directive, navpoint)
	context:slot(Slot.M_DIRECTIVE_SENSOR_80F6A396):set_directive{
			directive = directive,
			navpoint = context:slot(navpoint),
	}
end

local function place_squads(context, arena_data, wave)
	local squad_data = wave and arena_data.squads[wave] or arena_data.squads
	for _, sq in ipairs(squad_data) do
		local squad = context:squad(Squad[sq.squad])
		local counts = squad:counts()
		local default_objective = sq.default_objective or arena_data.objective
		counts:set(1, sq.count)
		context:slot(Slot[sq.squad]):assign_combat_objective{
			objective = context:slot(Slot[default_objective]),
			task_group = mission.TaskGroup[default_objective]["GROUP_" .. sq.default_group]
		}
		squad:place{counts = counts}
	end
end

local function spawn_courtyard(context)
	place_squads(context, ARENAS[1], "squad_b")
	place_squads(context, ARENAS[1], "squad_c")
	context:start_timer("dropship_a_delay", 1500)
	place_squads(context, ARENAS[1], "squad_boss")
end

local function flatten_squad_entries(list, out, state)
    if list[1] ~= nil then
        -- flat arena.squads array (existing arenas)
        for _, value in ipairs(list) do
            table.insert(out, value)
        end
        return
    end

    -- keyed by wave name (boss arena)
    for _, key in ipairs(ARENAS[state:variable("active_arena")].WAVE_KEYS) do
        local wave = list[key]
        if wave then
            for _, value in ipairs(wave) do
                table.insert(out, value)
            end
        end
    end
end

local function arena_squad_entries(arena, state)
    local entries = {}
    flatten_squad_entries(arena.squads, entries, state)
    return entries
end

local function check_cleared_status(context, arena, state)
    local entries = arena_squad_entries(arena, state)
    if #entries == 0 then
        return false
    end

    local squads = {}
    for _, entry in ipairs(entries) do
        table.insert(squads, Squad[entry.squad])
    end

    return context:cohort{squads = squads}.cleared
end

local function update_arena_status(context, state, arena)
	local key = arena.id .. ".arena_cleared"
	local entries = arena_squad_entries(arena, state)
	
	-- Debug code that logs if a squad counts as cleared
	for i, entry in ipairs(entries) do
		if context:cohort{squads = {Squad[entry.squad]}}.cleared then
			context:set_variable(arena.id .. ".cleared.dbg." .. i-1, true)
		end
	end

	if not state:variable(key) and check_cleared_status(context, arena, state) then
		-- If the arena has a corresponding engagement sensor that should be set on clear, it gets set here.
		if arena.clear_sensor then
			set_directive(context, arena.clear_sensor)
		end
		
		if arena.trigger then
			context:slot(arena.trigger):fire_trigger()
		end
		
		if arena.directive and arena.navpoint then
			set_directive(context, arena.directive, arena.navpoint)
		end
		
		-- Some arenas end the current music segment when cleared, some don't.
		-- This section checks if the arena has a clear_music_section and if it exists, plays it.
		if arena.clear_music_section then
			context:slot(Slot.M_MUSIC_SENSOR_80F6A396):set_music_section{section = arena.clear_music_section}
		end
		
		-- Handles the opening of doors blocking progression. Doors open when the corresponding arena is cleared
		if arena.doors then
			for _, door in ipairs(arena.doors) do
				context:slot(door):transition{
					transition = context.sdk.device_transitions.open,
				}
			end
		end
	
		local current_arena = state:variable("active_arena")
		context:set_variable("active_arena", current_arena + 1)
		context:set_variable(key, true)
	end
end

return {
    initial_state = {
        region_index = INTRO_REGION,
        spawn_set_hash = 0x09E1FC45,
    },

    -- Runs once, when the mission starts for the first time.
    on_start = function(context, state)
        context:set_variable("mission_bacon", "started")
		context:set_variable("active_arena", 1)
    end,

    on_load = function(context, state)
        context:set_variable("reloaded", true)
		context:slot(Slot.PT_SIGNAL_ANA):fire_trigger()
	end,
	
	--[[
	NP_GOTO_BRAY_80F6A1AB | glacier

	NP_GOTO_BRAY_80F6A168 | bray courtyard
	NP_GOTO_BRAY_80F6A179 | bray courtyard
	SLOT_0015_80F6A179 | bray inside futurescapes
	NP_ACTIVATE_CONSOLE | bray
	SLOT_0014_80F6A179 | bray aurora reach transision

	AP_RASPUTIN_ALARM_SOURCE | miniras
	NP_GOTO_RASPUTIN | miniras
	SLOT_0009_80F6A1DD | miniras

	ACTIVITYPOINT_HIVE_ANNOUNCE | rasputin
	SLOT_00B6_80F6A334 | rasputin
	NP_ASCENSION | rasputin
	SLOT_0019_80F6A373d | rasputin
	NP_THRONE_ASSAULT | rasputin
	AP_MACHINE_DOOR | rasputin
	]]

    -- Runs each time the player moves into another region.
    on_event_region_changed = function(context, state, event)
		if event.region_index == INTRO_REGION then
			context:set_variable("current_region", INTRO_REGION)
		end
        if event.region_index == BRAYTECH_FUTURESCAPES then
			context:set_variable("current_region", BRAYTECH_FUTURESCAPES)
            if not state:variable("braytech_visited.armed") then
                context:set_variable("braytech_visited.armed", true)
				local bray_objects = {
					Slot.O_MINI_RAS_DOOR,
					Slot.O_SERAPH_TOWER0_80F739EA,
					Slot.O_SERAPH_TOWER1_80F739EA,
					Slot.O_SERAPH_TOWER2_80F739EA,
					Slot.O_SERAPH_TOWER3_80F739EA,
					Slot.O_SERAPH_TOWER4_80F739EA,
					Slot.O_AVOIDANCE_0_80F739EA,
					Slot.O_AVOIDANCE_1_80F739EA,
					Slot.O_AVOIDANCE_2_80F739EA,
					Slot.O_AVOIDANCE_3_80F739EA,
					Slot.O_AVOIDANCE_4_80F739EA,
				}
				
				arm_triggers(context, triggers["futurescapes_onload"])
				
				for _, entry in ipairs(bray_objects) do
					context:slot(entry):set_object_active{active = true}
				end
				
				context:slot(Slot.D_DOOR_LIGHTS):transition{
					transition = context.sdk.device_transitions.power_off,
				}
						
				for i = 0, 9 do
					if i <= 8 then
						context:slot(Slot["D_SCREEN_BANK_2_" .. i]):transition{
							transition = context.sdk.device_transitions.power_off,
						}
					end
					context:slot(Slot["D_SCREEN_BANK_1_" .. i]):transition{
							transition = context.sdk.device_transitions.power_off,
					}
				end
				set_directive(context, Directive.CLEAR_A_PATH_TO_CLOVIS_BRAY, Slot.NP_GOTO_BRAY_80F6A168)
            end
        end
		
		if event.region_index == AURORA_REACH then
			context:set_variable("current_region", AURORA_REACH)
			if not state:variable("aurora_visited.armed") then
				context:set_variable("aurora_visited.armed", true)
				arm_triggers(context, triggers["aurora_reach"])
				
				context:slot(Slot.DOOR_DEVICE):transition{
					transition = context.sdk.device_transitions.open,
				}
				set_directive(context, Directive.CLEAR_A_PATH_TO_CLOVIS_BRAY, Slot.AP_RASPUTIN_ALARM_SOURCE)
			end
		end
		
		if event.region_index == MINDLAB_RASPUTIN then
			context:set_variable("current_region", MINDLAB_RASPUTIN)
			if not state:variable("mindlab_visited.armed") then
				context:set_variable("mindlab_visited.armed", true)
				arm_triggers(context, triggers["mindlab_onload"])
			end
		end
    end,

    -- Fires the intro dialogue and directive once the client actually holds the start region.
    on_event_client_state_changed = function(context, state, event)
        if event.entered == true
            and event.held_region_index == INTRO_REGION
            and not state:variable("intro.sent") then
            context:set_variable("intro.sent", true)
			arm_triggers(context, triggers["intro"])
			context:slot(Slot.M_MUSIC_SENSOR_80F6A396):set_music_section{section = 0}
			context:slot(dialog_sensor):play_dialogue_cue{cue = cues.CUE_1}
			context:start_timer("directive_delay", 3500)
        end
    end,
	
	on_event_timer_elapsed = function(context, state, event)
		if event.timer_name == "directive_delay" then
			set_directive(context, Directive.CLEAR_A_PATH_TO_CLOVIS_BRAY, Slot.NP_GOTO_BRAY_80F6A1AB)

			context:slot(dialog_sensor):play_dialogue_cue{cue = cues.CUE_2}
		end
		
		if event.timer_name == "dropship_a_delay" then
			place_squads(context, ARENAS[1], "squad_a")
		end
		
		if event.timer_name == "ana_terminal_delay" then
			context:slot(Slot.D_ANA_TERMINAL):transition{
				transition = context.sdk.device_transitions.open,
			}
		end
		
		if event.timer_name == "bray_poweron_delay" then
			context:slot(Slot.D_DOOR_LIGHTS):transition{
				transition = context.sdk.device_transitions.power_on,
			}
					
			for i = 0, 9 do
				if i <= 8 then
					context:slot(Slot["D_SCREEN_BANK_2_" .. i]):transition{
						transition = context.sdk.device_transitions.power_on,
					}
				end
				context:slot(Slot["D_SCREEN_BANK_1_" .. i]):transition{
						transition = context.sdk.device_transitions.power_on,
				}
			end
		end
		
		if event.timer_name == "door_open_delay" then
			context:slot(Slot.PT_END_PHASE_80F6A179):fire_trigger()
			
			context:slot(Slot.D_RASPUTIN_DOOR):transition{
				transition = context.sdk.device_transitions.open,
			}
			
			set_directive(context, Directive.CLEAR_A_PATH_TO_CLOVIS_BRAY, Slot.SLOT_0014_80F6A179)
		end
		
		if event.timer_name == "aurora_dialog_delay" then
			context:slot(dialog_sensor):play_dialogue_cue{cue = cues.CUE_15}
		end
		
		if event.timer_name == "spear_delay" then
			context:slot(Slot.O_JAVELIN_SPAWNER_LANDING):set_object_active{active = true}
			context:slot(Slot.O_JAVELIN_VFX):set_object_active{active = true}
			context:slot(Slot.M_MUSIC_SENSOR_80F6A396):set_music_section{section = 8}
			context:slot(Slot.M_MUSIC_SENSOR_80F6A396):set_music_section{section = 9}
			context:slot(dialog_sensor):play_dialogue_cue{cue = cues.CUE_23}
			place_squads(context, ARENAS[5])
		end
	end,
	
	on_event_player_trigger = function(context, state, event)
		local current_region = state:variable("current_region")
		if current_region == BRAYTECH_FUTURESCAPES then
			if lib.is_slot(context, event, Slot.PT_SPAWN_DROPSHIPS_RIGHT) then
				context:slot(Slot.PT_SPAWN_DROPSHIPS_RIGHT):disarm_trigger()
				context:slot(Slot.PT_SPAWN_DROPSHIPS_LEFT):disarm_trigger()
				context:set_variable("alt_reinforce", false)
				context:slot(Slot.M_MUSIC_SENSOR_80F6A396):set_music_section{section = 1}
				context:slot(Slot.M_MUSIC_SENSOR_80F6A396):set_music_section{section = 2}
				spawn_courtyard(context)
			end
			
			if lib.is_slot(context, event, Slot.PT_SPAWN_DROPSHIPS_LEFT) then
				context:slot(Slot.PT_SPAWN_DROPSHIPS_RIGHT):disarm_trigger()
				context:slot(Slot.PT_SPAWN_DROPSHIPS_LEFT):disarm_trigger()
				context:slot(Slot.PT_SEED_PROPS):disarm_trigger()
				context:set_variable("alt_reinforce", true)
				context:slot(Slot.M_MUSIC_SENSOR_80F6A396):set_music_section{section = 1}
				context:slot(Slot.M_MUSIC_SENSOR_80F6A396):set_music_section{section = 2}
				spawn_courtyard(context)
				place_squads(context, ARENAS[1], "squad_intro")
			end
			
			if lib.is_slot(context, event, Slot.PT_SEED_PROPS) then
				context:slot(Slot.PT_SEED_PROPS):disarm_trigger()
				place_squads(context, ARENAS[1], "squad_intro")
			end
			
			if lib.is_slot(context, event, Slot.PT_SIGNAL_ANA) then
				context:slot(Slot.PT_SIGNAL_ANA):disarm_trigger()
				context:slot(Slot.PT_END_PHASE_80F6A179):fire_trigger()
				context:slot(Slot.M_MUSIC_SENSOR_80F6A396):set_music_section{section = 3}
				context:slot(Slot.O_START_VIGNETTE):set_object_active{active = true}
				context:slot(Slot.O_LARGE_NUTBLOCKER):set_object_active{active = true}
				context:slot(Slot.O_LARGE_NUTBLOCKER_2):set_object_active{active = true}

				context:slot(Slot.O_SMALL_NUTBLOCKER):set_object_active{active = true}
				context:slot(Slot.O_SMALL_NUTBLOCKER_2):set_object_active{active = true}

				context:slot(Slot.M_MUSIC_SENSOR_80F6A396):set_music_section{section = 4}

				context:scene(mission.Scene.SCN_ANA_POWER_UP_BRAY):activate{} -- Nutblockers need to be active for the scene to function
				context:squad(mission.Squad.SQ_ANA_VIGNETTE):place{}
				context:scene(mission.Scene.SCN_ANA_POWER_UP_BRAY):send_event{key = 0x8803483C} -- start vignette
				context:start_timer("ana_terminal_delay", 18000)
				context:start_timer("bray_poweron_delay", 36000)
				context:start_timer("door_open_delay", 55000)
			end
			
			if lib.is_slot(context, event, Slot.PT_END_PHASE_80F6A179) then
				context:slot(Slot.PT_END_PHASE_80F6A179):disarm_trigger()
				context:slot(dialog_sensor):play_dialogue_cue{cue = cues.CUE_14}
			end
		end
		
		if current_region == AURORA_REACH then
			if lib.is_slot(context, event, Slot.PT_LOCATE_ENTRANCE) then
				context:slot(Slot.PT_LOCATE_ENTRANCE):disarm_trigger()
				context:slot(Slot.M_MUSIC_SENSOR_80F6A396):set_music_section{section = 5}
				context:start_timer("aurora_dialog_delay", 5000)
				set_directive(context, Directive.CLEAR_A_PATH_TO_CLOVIS_BRAY, Slot.NP_GOTO_RASPUTIN)
			end
			
			if lib.is_slot(context, event, Slot.PT_END_PHASE_80F6A1DD) then
				context:slot(Slot.PT_END_PHASE_80F6A1DD):disarm_trigger()
				context:slot(dialog_sensor):play_dialogue_cue{cue = cues.CUE_18}
			end
		end
		
		if current_region == MINDLAB_RASPUTIN then
			if lib.is_slot(context, event, Slot.PT_SPAWN_LOWER_ENCOUNTERS) then
				context:slot(Slot.PT_SPAWN_LOWER_ENCOUNTERS):disarm_trigger()
				place_squads(context, ARENAS[2], "lower_encounter")
			end
			
			if lib.is_slot(context, event, Slot.PT_MUS_HIVE_ATTACK) then
				context:slot(Slot.PT_MUS_HIVE_ATTACK):disarm_trigger()
				context:slot(Slot.M_MUSIC_SENSOR_80F6A396):set_music_section{section = 6}
			end
			
			if lib.is_slot(context, event, Slot.PT_ELEVATOR_SEED_PROPS) then
				context:slot(Slot.PT_ELEVATOR_SEED_PROPS):disarm_trigger()
			end
			
			if lib.is_slot(context, event, Slot.PT_ELEVATOR_SPAWN_WIZARDS) then
				context:slot(Slot.PT_ELEVATOR_SPAWN_WIZARDS):disarm_trigger()
				place_squads(context, ARENAS[2], "elevator_wizards")
			end
			
			if lib.is_slot(context, event, Slot.PT_ELEVATOR_SPAWN_MELEE) then
				context:slot(Slot.PT_ELEVATOR_SPAWN_MELEE):disarm_trigger()
				place_squads(context, ARENAS[2], "elevator_melee")
			end
			
			if lib.is_slot(context, event, Slot.PT_ASCENSION_ELEVATOR) then
				context:slot(Slot.PT_ASCENSION_ELEVATOR):disarm_trigger()
				place_squads(context, ARENAS[3], "pipes_front")
			end
			
			if lib.is_slot(context, event, Slot.PT_SPAWN_OVERRIDES_OFF) then
				context:slot(Slot.PT_SPAWN_OVERRIDES_OFF):disarm_trigger()
				context:slot(dialog_sensor):play_dialogue_cue{cue = cues.CUE_19}
			end
			
			if lib.is_slot(context, event, Slot.PT_PIPES_SPAWN_BACK) then
				context:slot(Slot.PT_PIPES_SPAWN_BACK):disarm_trigger()
				place_squads(context, ARENAS[3], "pipes_back")
			end
			
			if lib.is_slot(context, event, Slot.PT_HIVE_MUSIC_END) or lib.is_slot(context, event, Slot.PT_LEFT_HIVE_MUSIC_END) then
				context:slot(Slot.PT_HIVE_MUSIC_END):disarm_trigger()
				context:slot(Slot.PT_LEFT_HIVE_MUSIC_END):disarm_trigger()
				context:slot(Slot.M_MUSIC_SENSOR_80F6A396):set_music_section{section = 7}
			end
			
			if lib.is_slot(context, event, Slot.PT_ASCENSION_CABLE) or lib.is_slot(context, event, Slot.PT_LEFT_ASCENSION_CABLE) then
				context:slot(Slot.PT_ASCENSION_CABLE):disarm_trigger()
				context:slot(Slot.PT_LEFT_ASCENSION_CABLE):disarm_trigger()
				context:slot(dialog_sensor):play_dialogue_cue{cue = cues.CUE_20}
			end
			
			if lib.is_slot(context, event, Slot.PT_ASCENSION_CABLE_2) or lib.is_slot(context, event, Slot.PT_LEFT_ASCENSION_CABLE) then
				context:slot(Slot.PT_ASCENSION_CABLE_2):disarm_trigger()
				context:slot(Slot.PT_LEFT_ASCENSION_CABLE_2):disarm_trigger()
				context:slot(dialog_sensor):play_dialogue_cue{cue = cues.CUE_21}
			end
			
			if lib.is_slot(context, event, Slot.PT_SPAWN_SPEAR_INTRO) or lib.is_slot(context, event, Slot.PT_SPAWN_SPEAR_INTRO_ALT) then
				context:slot(Slot.PT_SPAWN_SPEAR_INTRO):disarm_trigger()
				context:slot(Slot.PT_LEFT_ASCENSION_CABLE_2):disarm_trigger()
				place_squads(context, ARENAS[4])
				context:slot(dialog_sensor):play_dialogue_cue{cue = cues.CUE_22}
				context:start_timer("spear_delay", 8000)
			end
		end
	end,

	on_event_squad_state = function(context, state, event)
		-- Checks on every squad state update if the arena is cleared or not
		-- and perform the relevant actions tied to the arena
		update_arena_status(context, state, ARENAS[state:variable("active_arena")])
	end,
}