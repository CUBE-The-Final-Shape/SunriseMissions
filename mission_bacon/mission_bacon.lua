local missions = require("missions")
local mission = require(missions.MISSION_BACON)
local lib = require("lib.mission_lib")
local Slot, Directive, Squad, Scene = mission.Slot, mission.Directive, mission.Squad, mission.Scene
local sensor = mission.Slot.M_DIALOG_SENSOR_80F6A396
local cues = mission.DialogueCue.M_DIALOG_SENSOR_80F6A396

local GLACIAL_DRIFT = mission.states.STATE_80F6A028_0005_0000_80F6A984.region_index  -- 40 | Intro region
local DYNAMO_APPROACH = mission.states.STATE_80F6A028_0008_0000_80F6A99B.region_index -- 64
local BRAYTECH_FUTURESCAPES = mission.states.STATE_80F6A028_0001_0000_80F6A01C.region_index -- 8
local AURORA_REACH = mission.states.STATE_80F6A028_0009_0000_80F6A99C.region_index -- 72
local MINDLAB_RASPUTIN = mission.states.STATE_80F6A028_000A_0000_80F6A9A8.region_index -- 80

local ARENAS = {
    {
        id = "placeholder",
		objective = "placeholder",
		clear_music_section = "placeholder",
		enter_sensor = "placeholder",
		clear_sensor = "placeholder",
		doors = {"placeholder"},
        squads = {
					{squad = "placeholder", count = "placeholder", default_group = "placeholder"},
				},
    },
}

local function set_directive(context, directive, navpoint, sensor)
	context:slot(Slot.M_DIRECTIVE_SENSOR_80F6A396):set_directive{
			directive = context:slot(directive),
			navpoint = context:slot(navpoint),
			audience = context:slot(sensor),
	}
end

local function place_squads(context, arena_data, wave)
	local squad_data = wave and arena_data.squads[wave] or arena_data.squads
	for i, sq in ipairs(squad_data) do
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
        table.insert(squads, Squad[entry.squad])
    end

    return context:cohort{squads = squads}.cleared
end

local function update_arena_status(context, state, arena)
	local key = arena.id .. ".arena_cleared"
	local entries = arena_squad_entries(arena)
	
	-- Debug code that logs if a squad counts as cleared
	for i, entry in ipairs(entries) do
		if context:cohort{squads = {Squad[entry.squad]}}.cleared then
			context:set_variable(arena.id .. ".cleared.dbg." .. i-1, true)
		end
	end

	if not state:variable(key) and check_cleared_status(context, arena) then
		-- If the arena has a corresponding engagement sensor that should be set on clear, it gets set here.
		if arena.clear_sensor then
			set_directive(context, arena.clear_sensor)
		end
		
		-- Some arenas end the current music segment when cleared, some don't.
		-- This section checks if the arena has a clear_music_section and if it exists, plays it.
		if arena.clear_music_section then
			context:slot(Slot.M_MUSIC_SENSOR):set_music_section{section = arena.clear_music_section}
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
        region_index = GLACIAL_DRIFT,
        spawn_set_hash = 0x09E1FC45,
    },

    -- Runs once, when the mission starts for the first time.
    on_start = function(context, state)
        context:set_variable("mission_bacon", "started")
    end,

    on_load = function(context, state)
        context:set_variable("reloaded", true)
	end,

    -- Runs each time the player moves into another region.
    on_event_region_changed = function(context, state, event)

        if event.region_index == BRAYTECH_FUTURESCAPES then
            if not state:variable("braytech_visited.armed") then
                context:set_variable("braytech_visited.armed", true)
				-- Placeholder
            end
        end
    end,

    -- Fires the intro dialogue and directive once the client actually holds the start region.
    on_event_client_state_changed = function(context, state, event)
        if event.entered == true
            and event.held_region_index == GLACIAL_DRIFT
            and not state:variable("intro.sent") then
            context:set_variable("intro.sent", true)
            -- Placeholder
        end
    end,
	
	on_event_squad_state = function(context, state, event)
		-- Checks on every squad state update if the arena is cleared or not
		-- and perform the relevant actions tied to the arena
		update_arena_status(context, state, ARENAS[state:variable("active_arena")])
	end,

    on_event_player_trigger = function(context, state, event)
        -- Placeholder
    end,

    on_event_entity_died = function(context, state, event)
        -- Placeholder
    end,

    on_event_timer_elapsed = function(context, state, event)
		-- Placeholder
    end,
	
	on_event_cinematic_terminated = function(context, state, event)
		-- the cinematic ended, or its start was refused
	end,
	
	on_event_cinematic_skip_requested = function(context, state, event)
		-- a player asked to skip
	end,
}

--[[
context:slot(Slot.M_MUSIC_SENSOR_80F6A396):set_music_section{section = X}
	Section:
	1, no music
	2, combat music
	3, no music
	4, ana vignette
	5, pt_locate_entrance, rasputin_reveal
	6, combat music
	7, no music
	8, combat music, spear?
	9, combat music
	10, no music
	11, eerie music

navigation sensor
NAVIGATION_80F76A4B

pt_endphase
pt_endphase_alt

pt_intro_directive
Slot.M_DIRECTIVE_SENSOR_80F6A396
Directive.CLEAR_A_PATH_TO_CLOVIS_BRAY

context:slot(sensor):play_dialogue_cue{cue = cues.CUE_1}
context:slot(sensor):play_dialogue_cue{cue = cues.CUE_2}

context:slot(Slot.PT_SPAWN_DROPSHIPS_RIGHT):fire_trigger()
context:slot(Slot.PT_SPAWN_DROPSHIPS_LEFT):fire_trigger()
context:slot(Slot.PT_SEED_PROPS):fire_trigger()
context:slot(Slot.PT_BYPASS_RIGHT):fire_trigger()
context:slot(Slot.PT_BYPASSED_LEFT):fire_trigger()

pt_sniper_fallback

pt_activate_boss_waypoint
pt_start_balcony_monitor  -- probably engagement sensor

INTRO_SQUAD_A_LEGIONAIRE_1
INTRO_SQUAD_A_LEGIONAIRE_2
INTRO_SQUAD_A_PHALANX_1

Slot.MAIN_OBJECTIVE_80F6A0E6 -- 19 Groups
	Group 0
		INTRO_SQUAD_A
		INTRO_SQUAD_B
		INTRO_SQUAD_C
		INTRO_SQUAD_D
		
	Group 1
		COURTYARD_SQUAD_B
		COURTYARD_SQUAD_B_1
		
		REINFORCE_SQUAD_B
		
	Group 2
		COURTYARD_SQUAD_C
		COURTYARD_SQUAD_C_1
		
		REINFORCE_SQUAD_C
		
	Group 3
		( -- Spawns with a 1,5s delay
		COURTYARD_SQUAD_A
		COURTYARD_SQUAD_A_1
		COURTYARD_SQUAD_A_2
		)
		
		REINFORCE_SQUAD_A_1
		REINFORCE_SQUAD_A_2


Slot.BOSS_OBJECTIVE -- 10 Groups
	INTERIOR_SQUAD_A group 1
	INTERIOR_SQUAD_B group 2
	INTERIOR_SQUAD_C group 3
	INTERIOR_SQUAD_D group 4
	INTERIOR_SQUAD_E group 5
	INTERIOR_SQUAD_BOSS group 0

pt_signal_ana
tv_weapondown_2

context:slot(Slot.O_LARGE_NUTBLOCKER):set_object_active{active = true}
context:slot(Slot.O_LARGE_NUTBLOCKER_2):set_object_active{active = true}

context:slot(Slot.O_SMALL_NUTBLOCKER):set_object_active{active = true}
context:slot(Slot.O_SMALL_NUTBLOCKER_2):set_object_active{active = true}

context:scene(mission.Scene.SCN_ANA_POWER_UP_BRAY):activate{spawn = true} Nutblockers need to be active for the scene to function
context:scene(mission.Scene.SCN_ANA_POWER_UP_BRAY):send_event{key = 0x8803483C} -- start vignette
context:squad(mission.Squad.SQ_ANA_VIGNETTE):place{}
context:scene(mission.Scene.SCN_ANA_POWER_UP_BRAY):send_event{key = 0x1526DC06} -- temper pacifist
context:scene(mission.Scene.SCN_ANA_POWER_UP_BRAY):send_event{key = 0xF9521E4E} -- temper rooted
context:scene(mission.Scene.SCN_ANA_POWER_UP_BRAY):send_event{key = 0xB38DB1E8} -- open the door
context:scene(mission.Scene.SCN_ANA_POWER_UP_BRAY):send_event{key = 0x3f9c28bd} -- ana

context:slot(Slot.O_START_VIGNETTE):set_object_active{active = true}

context:slot(Slot.O_MINI_RAS_DOOR):set_object_active{active = true} -- scene door

pt_end_phase

context:slot(Slot.M_MUSIC_SENSOR_80F6A396):set_music_section{section = 2}

pt_locate_entrance, starts music and dialouge. Dialouge after ca 5 sec
cues: 15, 

Aurora reach door
context:slot(Slot.DOOR_DEVICE):transition{
	transition = context.sdk.device_transitions.open,
}

pt_end_phase, cue 18
tv_dialog_hive_warning

pt_mus_hive_attack
pt_elevator_seed_props

pt_spawn_lower_encounters
entrance_trooper_squad_a, entrance_trooper_squad_b
elevator_trooper_squad_1 knight + acolyte, elevator_trooper_squad_2 acolyte count = 3, elevator_trooper_squad_3 acolyte

pt_elevator_spawn_melee
elevator_thrall_squad_a, elevator_thrall_squad_b, elevator_thrall_squad_c

pt_elevator_spawn_wizards
elevator_wizard_squad_1 spawns first, elevator_wizard_squad_2 spawns 1-2 secs after wizard 1

pt_ascension_elevator

pt_spawn_overrides_off, plays cue 19

pipes_trooper_squad_a, pipes_trooper_squad_b

pt_pipes_spawn_back

pipes_knight_squad_a count = 2 acolytes, pipes_knight_squad_b knight

pt_spawn_overrides_on

pt_hive_music_end

pt_spawn_spear_intro/pt_spawn_spear_intro_alt
pt_ascension_cable cue = 20, pt_ascension_cable_2 cue = 21

spear_intro_squad_a to e

context:slot(Slot.O_JAVELIN_SPAWNER_LANDING):set_object_active{active = true}
context:slot(Slot.O_JAVELIN_VFX):set_object_active{active = true}
play music
play cue 23

D_JAVELIN_DOOR

darkness zone

after arena clear play cue 24

pt_machine_god

context:slot(Slot.PF_CINEMATIC_BOOKEND_CINEMATIC):set_cinematic_active{active = true}
]]
