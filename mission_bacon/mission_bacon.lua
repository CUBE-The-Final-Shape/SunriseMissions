-- scripts/mission_bacon/mission_bacon.lua
local missions = require("missions")
local mission = require(missions.MISSION_BACON)
local lib = require("lib.mission_lib")
local flow = require("lib.flow")
local shared = require("mission_bacon.shared")(mission)
local combat = require("lib.combat")

local glacier = require("mission_bacon.glacier")(mission)
local bray = require("mission_bacon.bray")(mission)
local miniras = require("mission_bacon.miniras")(mission)
local rasputin = require("mission_bacon.rasputin")(mission)

-- Show one goal, with an optional marker.
local function show(context, directive, marker, audience)
    context:slot(shared.goals):set_directive{
        directive = directive,
        navpoint = marker ~= nil and context:slot(marker) or nil,
		audience = audience ~= nil and context:slot(audience) or nil,
    }
end

-- Arm a trigger and remember it, so its first report can disarm it.
local function arm(context, id_list)
	for _, id in ipairs(id_list) do
		context:set_variable("armed/" .. id, true)
		context:slot(id):fire_trigger()
	end
end

local function activate(context, id_list)
	for _, id in ipairs(id_list) do
		context:set_variable("activated/" .. id, true)
		context:slot(id):set_object_active{active = true}
	end
end

local function deactivate(context, id)
    context:set_variable("activated/" .. id, true)
    context:slot(id):set_object_active{active = false}
end

local function open(context, id)
    context:set_variable("opened/" .. id, true)
    context:slot(id):transition{
		transition = context.sdk.device_transitions.open,
	}
end

local function close_device(context, id)
    context:set_variable("closed/" .. id, true)
    context:slot(id):transition{
		transition = context.sdk.device_transitions.close,
	}
end

local function power_on(context, id_list)
	for _, id in ipairs(id_list) do
		context:set_variable("powered_on/" .. id, true)
		context:slot(id):transition{
			transition = context.sdk.device_transitions.power_on,
		}
	end
end

local function power_off(context, id_list)
	for _, id in ipairs(id_list) do
		context:set_variable("powered_off/" .. id, true)
		context:slot(id):transition{
			transition = context.sdk.device_transitions.power_off,
		}
	end
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

local function remove_squads(context, arena_data, wave)
	local squad_data = wave and arena_data.squads[wave] or arena_data.squads
	for _, sq in ipairs(squad_data) do
		local squad = context:squad(mission.Squad[sq.squad])
		local counts = squad:counts()
		for index = 1, counts.count do counts:set(index, 0) end
		squad:place{counts = counts}
	end
end

local function place_throne_actors(context, index)
		
		context:slot(rasputin.arena_throne.actor_squads[index].actor):bind_combatant_to_squad()

		local counts = context:squad(mission.Squad[rasputin.arena_throne.actor_squads[index].squad]):counts()
		counts:set(1, rasputin.arena_throne.actor_squads[index].count)
		
		context:slot(rasputin.arena_throne.actor_squads[index].actor):run_atoms{
			atoms = {{kind = "trivial"}},
			spawn = true,
		}
		
		context:slot(mission.Slot[rasputin.arena_throne.actor_squads[index].squad]):assign_combat_objective{
			objective = context:slot(mission.Slot.FINALE_OBJECTIVE),
			task_group = mission.TaskGroup.FINALE_OBJECTIVE["GROUP_" .. rasputin.arena_throne.actor_squads[index].default_group],
		}
		--context:squad(mission.Squad[rasputin.arena_throne.actor_squads[index].squad]):place{counts = counts}
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

local function squads_of_fight(arena, check_wave)
    local entries = {}
	if check_wave then
		flatten_squad_entries(arena.squads, entries, check_wave)
	else
		flatten_squad_entries(arena.squads, entries, arena.WAVE_KEYS)
	end
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
		--[[
		{id = "arrive_miniheat_area", observe = function(_, _, event)
            return event.region_index == shared.miniheat_region.region_index
        end},]]
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
		
		trigger_fact("at_goto_bray_right", bray.at_goto_bray_right),
		trigger_fact("at_goto_bray_left", bray.at_goto_bray_left),
		trigger_fact("at_dropships_right", bray.at_dropships_right),
		trigger_fact("at_dropships_left", bray.at_dropships_left),
		trigger_fact("at_seed_props", bray.at_seed_props),
		trigger_fact("at_bypass_right", bray.at_bypass_right),
		trigger_fact("at_bypassed_left", bray.at_bypassed_left),
		trigger_fact("at_activate_boss_waypoint", bray.at_activate_boss_waypoint),
		trigger_fact("at_start_balcony_monitor", bray.at_start_balcony_monitor),
		trigger_fact("at_signal_ana", bray.at_signal_ana),
		trigger_fact("at_bray_end_phase", bray.at_end_phase),
		
		trigger_fact("at_locate_entrance", miniras.at_locate_entrance),
		trigger_fact("at_end_phase", miniras.at_end_phase),
		
		trigger_fact("at_spawn_lower_encounters", rasputin.at_spawn_lower_encounters),
		trigger_fact("at_mus_hive_attack", rasputin.at_mus_hive_attack),
		trigger_fact("at_elevator_seed_props", rasputin.at_elevator_seed_props),
		trigger_fact("at_elevator_spawn_wizards", rasputin.at_elevator_spawn_wizards),
		trigger_fact("at_elevator_spawn_melee", rasputin.at_elevator_spawn_melee),
		trigger_fact("at_ascension_elevator", rasputin.at_ascension_elevator),
		trigger_fact("at_spawn_overrides_off", rasputin.at_spawn_overrides_off),
		trigger_fact("at_pipes_spawn_back", rasputin.at_pipes_spawn_back),
		trigger_fact("at_spawn_overrides_on", rasputin.at_spawn_overrides_on),
		trigger_fact("at_hive_music_end", rasputin.at_hive_music_end),
		trigger_fact("at_ascension_cable", rasputin.at_ascension_cable),
		trigger_fact("at_ascension_cable_2", rasputin.at_ascension_cable_2),
		trigger_fact("at_spawn_spear_intro", rasputin.at_spawn_spear_intro),
		trigger_fact("at_left_hive_music_end", rasputin.at_left_hive_music_end),
		trigger_fact("at_left_ascension_cable", rasputin.at_left_ascension_cable),
		trigger_fact("at_left_ascension_cable_2", rasputin.at_left_ascension_cable_2),
		trigger_fact("at_spawn_spear_intro_alt", rasputin.at_spawn_spear_intro_alt),
		trigger_fact("at_hook_trooper_fallback", rasputin.at_hook_trooper_fallback),
		trigger_fact("at_hook_spawn_thrall", rasputin.at_hook_spawn_thrall),
		trigger_fact("at_hook_spawn_thrall_1", rasputin.at_hook_spawn_thrall_1),
		trigger_fact("at_throne_spawn_encounter", rasputin.at_throne_spawn_encounter),
		trigger_fact("at_spawn_lower_enemies_gate", rasputin.at_spawn_lower_enemies_gate),
		trigger_fact("at_ascension_left", rasputin.at_ascension_left),
		trigger_fact("at_throne_wake_combatants", rasputin.at_throne_wake_combatants),
		trigger_fact("at_machine_god", rasputin.at_machine_god),
		trigger_fact("at_spawn_javelin", rasputin.at_spawn_javelin),
		trigger_fact("at_spawn_javelin_alt", rasputin.at_spawn_javelin_alt),
	},
	steps = {
		{id = "arrive", await = flow.fact("arrived"), run = function(context)
			context:set_variable("alt_reinforce", false)
			arm(context, {glacier.at_intro_directive, glacier.at_endphase, glacier.at_endphase_alt})
			activate(context, {glacier.o_seraph_tower_0, glacier.o_seraph_tower_1, glacier.o_seraph_tower_2, glacier.o_seraph_tower_3,
							   glacier.o_seraph_tower_4, glacier.o_javelin_floor0_80F73E47, glacier.o_javelin_floor1_80F73E47, glacier.o_javelin_floor2_80F73E47,
							   glacier.o_javelin_floor3_80F73E47, glacier.o_javelin_floor4_80F73E47})
		end},
		{id = "opening_dialog", after = {"arrive"}, await = flow.fact("at_intro_directive"), run = function(context)
			context:slot(shared.music):set_music_section{section = 0}
			context:start_timer("end_intro_music", 23000)
		end},
		{id = "at_intro_directive", after = {"opening_dialog"}, await = flow.fact("arrive_bray_area"), run = function(context)
			context:slot(shared.dialog):play_dialogue_cue{cue = glacier.line_open}
			context:start_timer("directive_delay", 3500)
        end},
		{id = "arrive_bray_area", after = {"at_intro_directive"}, await = flow.any(flow.fact("at_dropships_right"), flow.fact("at_dropships_left")), run = function(context)
			arm(context, {bray.at_dropships_right, bray.at_dropships_left, bray.at_seed_props, bray.at_bypass_right,
						  bray.at_bypassed_left, bray.at_activate_boss_waypoint, bray.at_start_balcony_monitor})
			activate(context, {bray.o_mini_ras_door, bray.o_seraph_tower_0, bray.o_seraph_tower_1, bray.o_seraph_tower_2,
							   bray.o_seraph_tower_3, bray.o_seraph_tower_4, bray.o_javelin_floor0_80F739EA, bray.o_javelin_floor1_80F739EA,
							   bray.o_javelin_floor2_80F739EA, bray.o_javelin_floor3_80F739EA, bray.o_javelin_floor4_80F739EA})
			power_off(context, {bray.d_door_lights, bray.d_screen_bank_1_0, bray.d_screen_bank_1_1, bray.d_screen_bank_1_2,
								bray.d_screen_bank_1_3, bray.d_screen_bank_1_4, bray.d_screen_bank_1_5, bray.d_screen_bank_1_6,
								bray.d_screen_bank_1_7, bray.d_screen_bank_1_8, bray.d_screen_bank_1_9, bray.d_screen_bank_2_0,
								bray.d_screen_bank_2_1, bray.d_screen_bank_2_2, bray.d_screen_bank_2_3, bray.d_screen_bank_2_4,
								bray.d_screen_bank_2_5, bray.d_screen_bank_2_6, bray.d_screen_bank_2_7, bray.d_screen_bank_2_8})
			show(context, shared.goal_secure_bray_CC40FDF7, bray.np_goto_bray_179, mission.Slot.M_ENGAGEMENT_SENSOR_80F6A0E6)
		end},
		{id = "at_dropships", after = {"arrive_bray_area"}, run = function(context)
			context:slot(shared.music):set_music_section{section = 2}
			place_squads(context, bray.arena_court, "squad_b")
			place_squads(context, bray.arena_court, "squad_c")
			context:start_timer("dropship_a_delay", 1500)
		end},
		{id = "at_seed_props", after = {"at_dropships"}, await = flow.any(flow.fact("at_seed_props"), flow.fact("at_dropships_left"))},
		{id = "spawn_bray", after = {"at_seed_props"}, run = function(context)
			place_squads(context, bray.arena_court, "squad_intro")
			place_squads(context, bray.arena_boss)
		end, await = function(context)
			return context:cohort{squads = squads_of_fight(bray.arena_court)}.cleared
		end},
		{id = "at_activate_boss_waypoint", after = {"spawn_bray"}, await = flow.fact("at_activate_boss_waypoint")},
		{id = "update_bray_waypoint", after = {"at_activate_boss_waypoint"}, run = function(context)
			show(context, shared.goal_secure_bray_CC40FDF7, bray.np_slot_0015, mission.Slot.M_ENGAGEMENT_SENSOR_80F6A0E6)
		end, await = function(context)
			return context:cohort{squads = squads_of_fight(bray.arena_boss)}.cleared
		end},
		{id = "futurescapes_cleared", after = {"update_bray_waypoint"}, await = flow.fact("at_signal_ana"), run = function(context)
			arm(context, {bray.at_signal_ana, bray.at_end_phase})
			context:slot(shared.music):set_music_section{section = 3}
			show(context, shared.goal_secure_bray_FF11C73B, bray.np_activate_console, mission.Slot.M_ENGAGEMENT_SENSOR_80F6A15A)
		end},
		{id = "at_signal_ana", after = {"futurescapes_cleared"}, await = flow.fact("at_bray_end_phase"), run = function(context)
			activate(context, {bray.o_start_vignette, bray.o_large_nutblocker, bray.o_large_nutblocker_2, bray.o_small_nutblocker, bray.o_small_nutblocker_2})
			context:slot(shared.music):set_music_section{section = 4}
			context:scene(bray.scene_ana_power_up):activate{}
			context:squad(bray.scene_ana_squad):place{}
			context:scene(bray.scene_ana_power_up):send_event{key = bray.scene_ana_power_up_key}
			context:start_timer("ana_terminal_delay", 18000)
			context:start_timer("bray_poweron_secondary_delay", 36000)
			context:start_timer("door_open_delay", 55000)
		end},
		{id = "at_bray_end_phase", after = {"at_signal_ana"}, run = function(context)
			context:slot(shared.dialog):play_dialogue_cue{cue = bray.line_sensor_14}
		end},
		{id = "arrive_miniras_area", after = {"at_bray_end_phase"}, await = flow.fact("arrive_miniras_area")},
		{id = "at_locate_entrance", after = {"arrive_miniras_area"}, await = flow.fact("at_locate_entrance"), run = function(context)
			context:slot(shared.music):set_music_section{section = 12}
			arm(context, {miniras.at_locate_entrance, miniras.at_end_phase})
			open(context, miniras.door)
			show(context, shared.goal_goto_bray, miniras.initial_nav)
		end},
		{id = "aurora_dialog", after = {"at_locate_entrance"}, await = flow.fact("at_end_phase"), run = function(context)
			context:slot(shared.music):set_music_section{section = 5}
			show(context, shared.goal_goto_bray, miniras.goto_rasputin_nav)
			context:slot(miniras.sequence_locate_entrane):play_sequence()
			context:slot(shared.dialog):play_dialogue_cue{cue = miniras.line_sensor_15}
		end},
		{id = "at_end_phase", after = {"aurora_dialog"}, run = function(context)
			context:slot(shared.dialog):play_dialogue_cue{cue = miniras.line_sensor_18}
			context:slot(shared.music):set_music_section{section = 12}
			show(context, shared.goal_ascend_F9396C1F, miniras.alt_nav)
		end},
		{id = "arrive_rasputin_area", after = {"at_end_phase"}, await = flow.fact("arrive_rasputin_area")},
		{id = "armed_rasputin_triggers", after = {"arrive_rasputin_area"}, await = flow.fact("at_spawn_lower_encounters"), run = function(context)
			arm(context, {rasputin.at_spawn_lower_encounters, rasputin.at_mus_hive_attack, rasputin.at_elevator_seed_props, rasputin.at_elevator_spawn_wizards,
						  rasputin.at_elevator_spawn_melee, rasputin.at_ascension_elevator, rasputin.at_spawn_overrides_off, rasputin.at_pipes_spawn_back,
						  rasputin.at_spawn_overrides_on, rasputin.at_hive_music_end, rasputin.at_ascension_cable, rasputin.at_ascension_cable_2,
						  rasputin.at_spawn_spear_intro, rasputin.at_left_hive_music_end, rasputin.at_left_ascension_cable, rasputin.at_left_ascension_cable_2,
						  rasputin.at_spawn_spear_intro_alt, rasputin.at_hook_spawn_thrall, rasputin.at_hook_spawn_thrall_1, rasputin.at_throne_spawn_encounter,
						  rasputin.at_spawn_lower_enemies_gate, rasputin.at_ascension_left, rasputin.at_throne_wake_combatants, rasputin.at_machine_god,
						  rasputin.at_spawn_javelin, rasputin.at_spawn_javelin_alt})
		end},
		{id = "at_spawn_lower_encounters", after = {"armed_rasputin_triggers"}, await = flow.fact("at_mus_hive_attack"), run = function(context)
			place_squads(context, rasputin.arena_elevator, "lower_encounter")
		end},
		{id = "at_mus_hive_attacks", after = {"at_spawn_lower_encounters"}, await = flow.fact("at_elevator_spawn_wizards"), run = function(context)
			context:slot(shared.music):set_music_section{section = 6}
		end},
		{id = "at_elevator_spawn_wizards", after = {"at_mus_hive_attacks"}, await = flow.fact("at_elevator_spawn_melee"), run = function(context)
			place_squads(context, rasputin.arena_elevator, "elevator_wizard")
			context:start_timer("wizard_2_delay", 1000)
		end},
		{id = "at_elevator_spawn_melee", after = {"at_elevator_spawn_wizards"}, await = flow.fact("at_ascension_elevator"), run = function(context)
			place_squads(context, rasputin.arena_elevator, "elevator_melee")
		end},
		{id = "at_ascension_elevator", after = {"at_elevator_spawn_melee"}, await = flow.fact("at_spawn_overrides_off"), run = function(context)
			place_squads(context, rasputin.arena_pipes, "pipes_front")
		end},
		{id = "at_spawn_overrides_off", after = {"at_ascension_elevator"}, await = flow.any(flow.fact("at_hive_music_end"), flow.fact("at_left_hive_music_end")), run = function(context)
			context:slot(shared.dialog):play_dialogue_cue{cue = rasputin.line_sensor_19}
		end},
		
		{id = "at_hive_music_end", after = {"at_spawn_overrides_off"}, await = flow.any(flow.fact("at_ascension_cable"), flow.fact("at_left_ascension_cable")), run = function(context)
			context:slot(shared.music):set_music_section{section = 7}
		end},
		
		{id = "at_ascension_cable", after = {"at_hive_music_end"}, await = flow.any(flow.fact("at_ascension_cable_2"), flow.fact("at_left_ascension_cable_2")), run = function(context)
			context:slot(shared.dialog):play_dialogue_cue{cue = rasputin.line_sensor_20}
			place_squads(context, rasputin.arena_spear_intro)
		end},
		
		{id = "at_ascension_cable_2", after = {"at_ascension_cable"}, await = flow.any(flow.fact("at_spawn_javelin"), flow.fact("at_spawn_javelin_alt")), run = function(context)
			context:slot(shared.dialog):play_dialogue_cue{cue = rasputin.line_sensor_21}
			place_squads(context, rasputin.arena_lower_gate)
		end},
		
		{id = "at_spawn_javelin", after = {"at_ascension_cable_2"}, await = flow.fact("at_hook_trooper_fallback"), run = function(context)
			context:slot(shared.dialog):play_dialogue_cue{cue = rasputin.line_sensor_22}
			context:slot(shared.music):set_music_section{section = 8}
			context:start_timer("spear_delay", 3000)
		end},
		{id = "throne_arena_checkpoint", after = {"at_spawn_javelin"}, checkpoint = true, reset_facts = {"at_hook_trooper_fallback", "at_throne_spawn_encounter"}},
		{id = "at_hook_trooper_fallback", after = {"throne_arena_checkpoint"}, await = flow.fact("at_hook_spawn_thrall"), run = function(context)
			activate(context, {rasputin.o_javelin_spawner_lower, rasputin.o_javelin_spawner_upper})
		end},
		{id = "at_throne_spawn_encounter", after = {"at_hook_trooper_fallback"}, run = function(context)
			place_squads(context, rasputin.arena_throne, "assault_sniper")
			place_squads(context, rasputin.arena_throne, "assault_boomer")
			place_squads(context, rasputin.arena_throne, "assault_trooper_wave1")
			place_squads(context, rasputin.arena_throne, "assault_crusader_wave1")
			context:start_timer("throne_encounter_logic", 1000)
		end, await = function(context)
			return context:cohort{squads = squads_of_fight(rasputin.arena_throne)}.cleared
		end},
		{id = "at_machine_god", after = {"at_throne_spawn_encounter"}, await = flow.fact("at_machine_god"), run = function(context)
		end},
		{id = "bookend_cinematic", after = {"at_machine_god"}, run = function(context)
			context:start_timer("bookend_start_delay", 2500)
		end},
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
    on_load = function(context, state) graph:advance(context, state)
	context:start_timer("spear_delay", 3000)end,

    on_event_client_state_changed = function(context, state, event)
        if event.entered == true then handle(context, state, event) end
    end,
    on_event_region_changed = handle,
    on_event_squad_state = handle,
    on_event_device_state = handle,

    on_event_player_trigger = function(context, state, event)
        local slot = event.slot
		
		if lib.is_slot(context, event, bray.at_dropships_left) then
			context:set_variable("alt_reinforce", true)
		end
		
		if lib.is_slot(context, event, rasputin.at_pipes_spawn_back) then
			place_squads(context, rasputin.arena_pipes, "pipes_back")
		end
		
        if slot ~= nil and state:variable("armed/" .. slot.id) == true then
            context:clear_variable("armed/" .. slot.id)
            slot:disarm_trigger()
        end
        handle(context, state, event)
    end,
	
	on_event_object_interacted = function(context, state, event)
		if lib.is_slot(context, event, rasputin.o_javelin_spawner_landing) then
			context:start_timer("rasputin_spear_door_delay", 1000)
			arm(context, {rasputin.at_hook_trooper_fallback})
			show(context, shared.goal_ascend_F9396C1F, miniras.alt_nav, mission.Slot.M_ENGAGEMENT_SENSOR_80F72B32)
		end
		if lib.is_slot(context, event, rasputin.o_javelin_spawner_lower) then
			context:start_timer("respawn_spear_lower", 16000)
		end
		if lib.is_slot(context, event, rasputin.o_javelin_spawner_upper) then
			context:start_timer("respawn_spear_upper", 16000)
		end
	end,

	on_event_timer_elapsed = function(context, state, event)
	
		if event.timer_name == "end_intro_music" then
			context:slot(shared.music):set_music_section{section = 1}
		end
		
		if event.timer_name == "directive_delay" then
			show(context, shared.goal_goto_bray, glacier.navpoint, mission.Slot.M_ENGAGEMENT_SENSOR_80F6A19A)
			context:slot(shared.dialog):play_dialogue_cue{cue = glacier.line_open_cont}
		end
		
		if event.timer_name == "dropship_a_delay" then
			place_squads(context, bray.arena_court, "squad_a")
			context:start_timer("court_encounter_logic", 1000)
		end
		
		if event.timer_name == "court_encounter_logic" then
			local alt_reinforce = state:variable("alt_reinforce")
			if context:cohort{squads = squads_of_fight(bray.arena_court, {"squad_a"})}.cleared == true
			and not state:variable("courtyard/reinf_a_placed") then
				context:set_variable("courtyard/reinf_a_placed", true)
				if alt_reinforce ~= true then
					place_squads(context, bray.arena_reinforce, "squad_reinforce_a1")
				else
					place_squads(context, bray.arena_reinforce, "squad_reinforce_a1_alt")
				end
				place_squads(context, bray.arena_reinforce, "squad_reinforce_a2")
			end
			if context:cohort{squads = squads_of_fight(bray.arena_court, {"squad_b"})}.cleared == true
			and not state:variable("courtyard/reinf_bc_placed") then
				context:set_variable("courtyard/reinf_bc_placed", true)
				if alt_reinforce ~= true then
					place_squads(context, bray.arena_reinforce, "squad_reinforce_b")
					place_squads(context, bray.arena_reinforce, "squad_reinforce_c")
				else
					place_squads(context, bray.arena_reinforce, "squad_reinforce_b_alt")
					place_squads(context, bray.arena_reinforce, "squad_reinforce_c_alt")						
				end		
			end
			
			if context:cohort{squads = squads_of_fight(bray.arena_court)}.cleared ~= true then
				context:start_timer("court_encounter_logic", 1000)
			else
				show(context, shared.goal_secure_bray_CC40FDF7, bray.np_slot_0015)
			end
		end
		
		if event.timer_name == "ana_terminal_delay" then
			open(context, bray.d_ana_terminal)
			deactivate(context, bray.o_large_nutblocker)
			deactivate(context, bray.o_large_nutblocker_2)
			context:start_timer("bray_poweron_delay", 8000)
		end
		
		if event.timer_name == "bray_poweron_delay" then
			power_on(context, {bray.d_screen_bank_2_0, bray.d_screen_bank_2_1, bray.d_screen_bank_2_2, bray.d_screen_bank_2_3,
							   bray.d_screen_bank_2_4, bray.d_screen_bank_2_7, bray.d_screen_bank_2_6, bray.d_screen_bank_2_5,
							   bray.d_screen_bank_2_8})
		end
		
		if event.timer_name == "bray_poweron_secondary_delay" then
			power_on(context, {bray.d_door_lights, bray.d_screen_bank_1_0, bray.d_screen_bank_1_1, bray.d_screen_bank_1_2,
							   bray.d_screen_bank_1_3, bray.d_screen_bank_1_4, bray.d_screen_bank_1_5, bray.d_screen_bank_1_6,
							   bray.d_screen_bank_1_7, bray.d_screen_bank_1_8, bray.d_screen_bank_1_9})
		end
		
		if event.timer_name == "door_open_delay" then
			open(context, bray.d_rasputin_door)
			show(context, shared.goal_goto_bray, bray.np_slot_0014)
		end
		
		if event.timer_name == "wizard_2_delay" then
			place_squads(context, rasputin.arena_elevator, "elevator_wizard_delayed")
		end
		
		if event.timer_name == "spear_delay" then
			context:slot(rasputin.sequence_javelin_audio):play_sequence()
			activate(context, {rasputin.o_javelin_spawner_landing, rasputin.o_javelin_vfx})
			context:start_timer("spear_dialog_delay", 2000)
		end
		
		if event.timer_name == "spear_dialog_delay" then
			context:slot(shared.dialog):play_dialogue_cue{cue = rasputin.line_sensor_23}
		end
		
		if event.timer_name == "rasputin_spear_door_delay" then
			context:slot(shared.hard_wipes):set_darkness_zone{enabled = true}
			context:slot(shared.music):set_music_section{section = 9}
			open(context, rasputin.d_javelin_door)
		end
		
		if event.timer_name == "respawn_spear_lower" then
			activate(context, {rasputin.o_javelin_spawner_lower})
		end
		
		if event.timer_name == "respawn_spear_upper" then
			activate(context, {rasputin.o_javelin_spawner_upper})
		end
		
		if event.timer_name == "bookend_start_delay" then
			context:slot(shared.goals):clear_directives()
			context:complete_mission{}
			local key = context:select_state(shared.outro_state_region)
			context:set_variable("move_request", key.value)
			context:slot(shared.bookend_cinematic):set_cinematic_active{active = true}
		end
		
		
		if event.timer_name == "throne_encounter_logic" then
			if context:cohort{squads = squads_of_fight(rasputin.arena_throne, {"assault_trooper_wave1"})}.cleared == true
			and not state:variable("throne_arena/thralls_placed") then
				context:set_variable("throne_arena/thralls_placed", true)
				place_squads(context, rasputin.arena_throne, "assault_thrall")
			end
			if context:cohort{squads = squads_of_fight(rasputin.arena_throne, {"assault_boomer", "assault_crusader_wave1"})}.cleared == true
			and not state:variable("throne_arena/trooper_wave2_placed") then
				context:set_variable("throne_arena/trooper_wave2_placed", true)
				place_squads(context, rasputin.arena_throne, "assault_trooper_wave2")
			end
			if context:cohort{squads = squads_of_fight(rasputin.arena_throne, {"assault_trooper_wave1", "assault_boomer", "assault_crusader_wave1", "assault_trooper_wave2"})}.cleared == true
			and not state:variable("throne_arena/final_wave_placed") then
				context:set_variable("throne_arena/final_wave_placed", true)
				place_squads(context, rasputin.arena_throne, "assault_crusader_wave2")
				place_squads(context, rasputin.arena_throne, "assault_ultra")
			end
			for i, entry in ipairs(squads_of_fight(rasputin.arena_throne)) do
				if context:cohort{squads = {entry}}.cleared then
					context:set_variable(rasputin.arena_throne.id .. ".cleared.dbg." .. i-1, true)
				end
			end
			
			if context:cohort{squads = squads_of_fight(rasputin.arena_throne)}.cleared ~= true then
				context:start_timer("throne_encounter_logic", 1000)
			else
				context:slot(shared.hard_wipes):set_darkness_zone{enabled = false}
				deactivate(context, rasputin.o_javelin_spawner_lower)
				deactivate(context, rasputin.o_javelin_spawner_upper)
				context:slot(shared.music):set_music_section{section = 10}
				context:slot(shared.dialog):play_dialogue_cue{cue = rasputin.line_sensor_24}
				open(context, rasputin.d_door_1)
			end
		end
	end,
	
	on_event_fireteam_state = function(context, state, event)
		local wiped = event.dead_count > 0 and event.alive_count == 0 and event.unknown_count == 0
		if not wiped or state:variable("wipe.request") ~= nil then return end
		local key = context:restart_checkpoint{region = shared.rasputin_region.region_index, spawn_set_hash = 0x80CDF71C}
		context:set_variable("wipe.request", key.value)
	end,
	
	on_event_effect_result = function(context, state, event)
		local request = state:variable("wipe.request")
		if request == nil or event.request_key.value ~= request then return end
		context:clear_variable("wipe.request")
		if event.outcome ~= "transport_staged" then return end
		-- the new attempt has started; release the client's wait
		context:restart_checkpoint{
			region = shared.rasputin_region.region_index, spawn_set_hash = 0x80CDF71C, release_request = request,
		}
		remove_squads(context, rasputin.arena_lower_gate)
		remove_squads(context, rasputin.arena_throne, "assault_sniper")
		remove_squads(context, rasputin.arena_throne, "assault_boomer")
		remove_squads(context, rasputin.arena_throne, "assault_trooper_wave1")
		remove_squads(context, rasputin.arena_throne, "assault_crusader_wave1")
		remove_squads(context, rasputin.arena_throne, "assault_thrall")
		remove_squads(context, rasputin.arena_throne, "assault_trooper_wave2")
		remove_squads(context, rasputin.arena_throne, "assault_crusader_wave2")
		remove_squads(context, rasputin.arena_throne, "assault_ultra")
		close_device(context, rasputin.d_javelin_door)
		activate(context, {rasputin.o_javelin_spawner_landing})
		context:slot(shared.hard_wipes):set_darkness_zone{enabled = false}
		place_squads(context, rasputin.arena_lower_gate)
		arm(context, {rasputin.at_hook_spawn_thrall, rasputin.at_hook_spawn_thrall_1, rasputin.at_throne_spawn_encounter, rasputin.at_spawn_lower_enemies_gate,
					  rasputin.at_ascension_left, rasputin.at_throne_wake_combatants, rasputin.at_machine_god})
	end,
	
	on_event_cinematic_terminated = function(context, state, event)
    -- the cinematic ended, or its start was refused
	end,
	
	on_event_cinematic_skip_requested = function(context, state, event)
		-- a player asked to skip
	end,
}