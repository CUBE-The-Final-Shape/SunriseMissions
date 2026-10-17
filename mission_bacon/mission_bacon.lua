-- scripts/mission_bacon/mission_bacon.lua
local missions = require("missions")
local mission = require(missions.MISSION_BACON)
local lib = require("lib.mission_lib")
local flow = require("lib.flow")
local shared = require("mission_bacon.shared")(mission)

local glacier = require("mission_bacon.glacier")(mission)
local bray = require("mission_bacon.bray")(mission)
local miniras = require("mission_bacon.miniras")(mission)
-- local rasputin = require("mission_bacon.rasputin")(mission)

-- Show one goal, with an optional marker.
local function show(context, directive, marker)
    context:slot(shared.goals):set_directive{
        directive = directive,
        navpoint = marker ~= nil and context:slot(marker) or nil,
    }
end

-- Arm a trigger and remember it, so its first report can disarm it.
local function arm(context, id)
    context:set_variable("armed/" .. id, true)
    context:slot(id):fire_trigger()
end

local function activate(context, id)
    context:set_variable("activated/" .. id, true)
    context:slot(id):set_object_active{active = true}
end

local function open(context, id)
    context:set_variable("opened/" .. id, true)
    context:slot(id):transition{
		transition = context.sdk.device_transitions.open,
	}
end

local function power_on(context, id)
    context:set_variable("powered_on/" .. id, true)
    context:slot(id):transition{
		transition = context.sdk.device_transitions.power_on,
	}
end

local function power_off(context, id)
    context:set_variable("powered_off/" .. id, true)
    context:slot(id):transition{
		transition = context.sdk.device_transitions.power_off,
	}
end

local function place_squads(context, arena_data, wave)
	local squad_data = wave and arena_data.squads[wave] or arena_data.squads
	for _, sq in ipairs(squad_data) do
		local squad = context:squad(mission.Squad[sq.squad])
		local counts = squad:counts()
		local default_objective = sq.default_objective or arena_data.objective
		counts:set(1, sq.count)
		context:slot(mission.Slot[sq.squad]):assign_combat_objective{
			objective = context:slot(mission.Slot[default_objective]),
			task_group = mission.TaskGroup[default_objective]["GROUP_" .. sq.default_group]
		}
		squad:place{counts = counts}
	end
end

local function flatten_squad_entries(list, out, wave_keys)
    if list[1] ~= nil then
        -- flat arena.squads array (existing arenas)
        for _, value in ipairs(list) do
            table.insert(out, value)
        end
        return
    end

    -- keyed by wave name (boss arena)
    for _, key in ipairs(wave_keys) do
        local wave = list[key]
        if wave then
            for _, value in ipairs(wave) do
                table.insert(out, value)
            end
        end
    end
end

local function squads_of_fight(arena)
    local entries = {}
    flatten_squad_entries(arena.squads, entries, arena.WAVE_KEYS)
	local squads = {}
    for _, entry in ipairs(entries) do
        table.insert(squads, mission.Squad[entry.squad])
    end
    return squads
end

local function trigger_fact(id, slot)
    return {id = id, observe = function(context, _, event)
        return lib.is_slot(context, event, slot)
    end}
end

local graph = flow.new{
    key = "mb",
    facts = {
		{id = "arrived", observe = function(_, _, event)
            return event.entered == true
                and event.held_region_index == shared.glacier_region.region_index
        end},
		{id = "arrive_miniheat_area", observe = function(_, _, event)
            return event.region_index == shared.miniheat_region.region_index
        end},
		{id = "arrive_bray_area", observe = function(_, _, event)
            return event.region_index == shared.bray_region.region_index
        end},
		{id = "arrive_miniras_area", observe = function(_, _, event)
            return event.region_index == shared.miniras_region.region_index
        end},
		{id = "arrive_rasputin_area", observe = function(_, _, event)
            return event.region_index == shared.rasputin_region.region_index
        end},
		{id = "arrive_outro_state_area", observe = function(_, _, event)
            return event.region_index == shared.outro_state_region.region_index
        end},
		trigger_fact("at_intro_directive", glacier.at_intro_directive),
		trigger_fact("at_endphase", glacier.at_endphase),
		trigger_fact("at_endphase_alt", glacier.at_endphase_alt),
		trigger_fact("at_goto_bray_right", glacier.at_goto_bray_right),
		trigger_fact("at_goto_bray_left", glacier.at_goto_bray_left),
		trigger_fact("at_dropships_right", glacier.at_dropships_right),
		trigger_fact("at_dropships_left", glacier.at_dropships_left),
		
		trigger_fact("at_seed_props", bray.at_seed_props),
		trigger_fact("at_bypass_right", bray.at_bypass_right),
		trigger_fact("at_bypassed_left", bray.at_bypassed_left),
		trigger_fact("at_activate_boss_waypoint", bray.at_activate_boss_waypoint),
		trigger_fact("at_start_balcony_monitor", bray.at_start_balcony_monitor),
		trigger_fact("at_signal_ana", bray.at_signal_ana),
		trigger_fact("at_bray_end_phase", bray.at_end_phase),
		
		trigger_fact("at_locate_entrance", miniras.at_locate_entrance),
		trigger_fact("at_end_phase", miniras.at_end_phase),
	},
	steps = {
		{id = "arrive", await = flow.fact("arrived"), await = flow.fact("at_intro_directive"), run = function(context)
			arm(context, glacier.at_intro_directive)
			arm(context, glacier.at_endphase)
			arm(context, glacier.at_endphase_alt)
			arm(context, glacier.at_goto_bray_right)
			arm(context, glacier.at_goto_bray_left)
			arm(context, glacier.at_dropships_right)
			arm(context, glacier.at_dropships_left)
		end},
		{id = "at_intro_directive", after = {"arrive"}, run = function(context)
			context:slot(shared.music):set_music_section{section = 0}
            context:slot(shared.dialog):play_dialogue_cue{cue = glacier.line_open}
			context:start_timer("directive_delay", 3500)
        end},
		{id = "arrive_bray_area", after = {"at_intro_directive"}, await = flow.fact("arrive_bray_area")},
		{id = "arm_bray", after = {"arrive_bray_area"}, await = flow.any(flow.fact("at_dropships_right"), flow.fact("at_dropships_left")), run = function(context)
			arm(context, glacier.at_dropships_right)
			arm(context, glacier.at_dropships_left)
			arm(context, bray.at_seed_props)
			arm(context, bray.at_bypass_right)
			arm(context, bray.at_bypassed_left)
			arm(context, bray.at_activate_boss_waypoint)
			arm(context, bray.at_start_balcony_monitor)
			activate(context, bray.o_mini_ras_door)
			activate(context, bray.o_seraph_tower_0)
			activate(context, bray.o_seraph_tower_1)
			activate(context, bray.o_seraph_tower_2)
			activate(context, bray.o_seraph_tower_3)
			activate(context, bray.o_seraph_tower_4)
			activate(context, bray.o_avoidance_0)
			activate(context, bray.o_avoidance_1)
			activate(context, bray.o_avoidance_2)
			activate(context, bray.o_avoidance_3)
			activate(context, bray.o_avoidance_4)
			power_off(context, bray.d_door_lights)
			power_off(context, bray.d_screen_bank_1_0)
			power_off(context, bray.d_screen_bank_1_1)
			power_off(context, bray.d_screen_bank_1_2)
			power_off(context, bray.d_screen_bank_1_3)
			power_off(context, bray.d_screen_bank_1_4)
			power_off(context, bray.d_screen_bank_1_5)
			power_off(context, bray.d_screen_bank_1_6)
			power_off(context, bray.d_screen_bank_1_7)
			power_off(context, bray.d_screen_bank_1_8)
			power_off(context, bray.d_screen_bank_1_9)
			power_off(context, bray.d_screen_bank_2_0)
			power_off(context, bray.d_screen_bank_2_1)
			power_off(context, bray.d_screen_bank_2_2)
			power_off(context, bray.d_screen_bank_2_3)
			power_off(context, bray.d_screen_bank_2_4)
			power_off(context, bray.d_screen_bank_2_5)
			power_off(context, bray.d_screen_bank_2_6)
			power_off(context, bray.d_screen_bank_2_7)
			power_off(context, bray.d_screen_bank_2_8)
			context:slot(shared.music):set_music_section{section = 1}
			show(context, shared.goal_secure_bray_CC40FDF7, bray.np_goto_bray_168)
		end},
		{id = "at_dropships", after = {"arm_bray"}, run = function(context)
			context:slot(shared.music):set_music_section{section = 2}
			show(context, shared.goal_secure_bray_CC40FDF7, bray.np_goto_bray_179)
			place_squads(context, bray.arena, "squad_a")
			place_squads(context, bray.arena, "squad_b")
			place_squads(context, bray.arena, "squad_c")
		end},
		{id = "at_seed_props", after = {"at_dropships"}, await = flow.any(flow.fact("at_seed_props"), flow.fact("at_dropships_left"))},
		{id = "spawn_bray", after = {"at_seed_props"}, run = function(context)
			place_squads(context, bray.arena, "squad_intro")
			place_squads(context, bray.arena, "squad_boss")
		end},
		{id = "at_activate_boss_waypoint", after = {"spawn_bray"}, await = flow.fact("at_activate_boss_waypoint")},
		{id = "update_bray_waypoint", after = {"at_activate_boss_waypoint"}, run = function(context)
			show(context, shared.goal_secure_bray_CC40FDF7, bray.np_slot_0015)
		end, await = function(context)
			return context:cohort{squads = squads_of_fight(bray.arena)}.cleared
		end},
		{id = "futurescapes_cleared", after = {"update_bray_waypoint"}, await = flow.fact("at_signal_ana"), run = function(context)
			arm(context, bray.at_signal_ana)
			arm(context, bray.at_end_phase)
			show(context, shared.goal_secure_bray_FF11C73B, bray.np_activate_console)
		end},
		{id = "at_signal_ana", after = {"futurescapes_cleared"}, await = flow.fact("at_bray_end_phase"), run = function(context)
			activate(context, bray.o_start_vignette)
			activate(context, bray.o_large_nutblocker)
			activate(context, bray.o_large_nutblocker_2)
			activate(context, bray.o_small_nutblocker)
			activate(context, bray.o_small_nutblocker_2)
			context:slot(shared.music):set_music_section{section = 4}
			context:scene(bray.scene_ana_power_up):activate{}
			context:squad(bray.scene_ana_squad):place{}
			context:scene(bray.scene_ana_power_up):send_event{key = bray.scene_ana_power_up_key}
			context:start_timer("ana_terminal_delay", 18000)
			context:start_timer("bray_poweron_delay", 36000)
			context:start_timer("door_open_delay", 55000)
		end},
		{id = "at_bray_end_phase", after = {"at_signal_ana"}, run = function(context)
			context:slot(shared.dialog):play_dialogue_cue{cue = bray.line_sensor_14}
		end},
		{id = "arrive_miniras_area", after = {"at_bray_end_phase"}, await = flow.fact("arrive_miniras_area")},
		{id = "at_locate_entrance", after = {"arrive_miniras_area"}, await = flow.fact("at_locate_entrance"), run = function(context)
			arm(context, miniras.at_locate_entrance)
			arm(context, miniras.at_end_phase)
			open(context, miniras.door)
			show(context, shared.goal_goto_bray, miniras.initial_nav)
		end},
		{id = "aurora_dialog", after = {"at_locate_entrance"}, await = flow.fact("at_end_phase"), run = function(context)
			show(context, shared.goal_goto_bray, miniras.goto_rasputin_nav)
			context:slot(shared.music):set_music_section{section = 5}
			context:start_timer("aurora_dialog_delay", 4000)
		end},
		{id = "at_end_phase", after = {"aurora_dialog"}, run = function(context)
			context:slot(shared.dialog):play_dialogue_cue{cue = miniras.line_sensor_18}
			show(context, shared.goal_ascend_F9396C1F, miniras.alt_nav)
		end},
		{id = "arrive_rasputin_area", after = {"at_end_phase"}, await = flow.fact("arrive_rasputin_area")},
	},
}

local function handle(context, state, event)
    graph:handle(context, state, event)
end

return {
    initial_state = {
		region_index = shared.glacier_region.region_index,
		spawn_set_hash = 0x09E1FC45,
	},

    on_start = function(context, state) graph:advance(context, state) end,
    on_load = function(context, state) graph:advance(context, state) end,

    on_event_client_state_changed = function(context, state, event)
        if event.entered == true then handle(context, state, event) end
    end,
    on_event_region_changed = handle,
    on_event_squad_state = handle,
    on_event_device_state = handle,

    on_event_player_trigger = function(context, state, event)
        local slot = event.slot
        if slot ~= nil and state:variable("armed/" .. slot.id) == true then
            context:clear_variable("armed/" .. slot.id)
            slot:disarm_trigger()
        end
        handle(context, state, event)
    end,
	
	on_event_timer_elapsed = function(context, state, event)
		if event.timer_name == "directive_delay" then
			show(context, shared.goal_goto_bray, glacier.navpoint)
            context:slot(shared.dialog):play_dialogue_cue{cue = glacier.line_open_cont}
		end
	
		if event.timer_name == "ana_terminal_delay" then
			open(context, bray.d_ana_terminal)
		end
		
		if event.timer_name == "bray_poweron_delay" then
			power_on(context, bray.d_door_lights)
			power_on(context, bray.d_screen_bank_1_0)
			power_on(context, bray.d_screen_bank_1_1)
			power_on(context, bray.d_screen_bank_1_2)
			power_on(context, bray.d_screen_bank_1_3)
			power_on(context, bray.d_screen_bank_1_4)
			power_on(context, bray.d_screen_bank_1_5)
			power_on(context, bray.d_screen_bank_1_6)
			power_on(context, bray.d_screen_bank_1_7)
			power_on(context, bray.d_screen_bank_1_8)
			power_on(context, bray.d_screen_bank_1_9)
			power_on(context, bray.d_screen_bank_2_0)
			power_on(context, bray.d_screen_bank_2_1)
			power_on(context, bray.d_screen_bank_2_2)
			power_on(context, bray.d_screen_bank_2_3)
			power_on(context, bray.d_screen_bank_2_4)
			power_on(context, bray.d_screen_bank_2_5)
			power_on(context, bray.d_screen_bank_2_6)
			power_on(context, bray.d_screen_bank_2_7)
			power_on(context, bray.d_screen_bank_2_8)
		end
		
		if event.timer_name == "door_open_delay" then
			open(context, bray.d_rasputin_door)
			show(context, shared.goal_goto_bray, bray.np_slot_0014)
		end
		
		if event.timer_name == "aurora_dialog_delay" then
			context:slot(shared.dialog):play_dialogue_cue{cue = miniras.line_sensor_15}
		end
	end,
}