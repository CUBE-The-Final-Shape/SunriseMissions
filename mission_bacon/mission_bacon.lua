local missions = require("missions")
local mission = require(missions.MISSION_BACON)
local lib = require("lib.mission_lib")
local Slot, Directive, Squad = mission.Slot, mission.Directive, mission.Squad
local sensor = mission.Slot.M_DIALOG_SENSOR_80F6A396
local cues = mission.DialogueCue.M_DIALOG_SENSOR_80F6A396

local INTRO_REGION = mission.states.STATE_80F6A028_0005_0000_80F6A984.region_index  -- 40
local BRAYTECH_FUTURESCAPES = mission.states.STATE_80F6A028_0001_0000_80F6A01C.region_index -- 8

return {
    initial_state = {
        region_index = INTRO_REGION,
        spawn_set_hash = 0x09E1FC45,
    },

    -- Runs once, when the mission starts for the first time.
    on_start = function(context, state)
        context:set_variable("hello", "started")
    end,

    on_load = function(context, state)
        context:set_variable("reloaded", true)
    end,

    -- Runs each time the player moves into another region.
    on_event_region_changed = function(context, state, event)
        context:set_variable("last_region", event.region_index)
        local seen = state:variable("regions_seen") or 0
        context:set_variable("regions_seen", seen + 1)
		if event.region_index == BRAYTECH_FUTURESCAPES and not state:variable("braytech_visited.armed") then
			context:set_variable("Braytech_futurescapes", "I_am_here")
			context:set_variable("braytech_visited.armed", true)
			context:slot(Slot.PT_SPAWN_DROPSHIPS_RIGHT):fire_trigger()
			context:slot(Slot.PT_SPAWN_DROPSHIPS_LEFT):fire_trigger()
			context:slot(Slot.PT_SEED_PROPS):fire_trigger()
			context:slot(Slot.PT_BYPASS_RIGHT):fire_trigger()
			context:slot(Slot.PT_BYPASSED_LEFT):fire_trigger()
		end
    end,

    -- Fires the intro dialogue and directive once the client actually holds the start region.
    on_event_client_state_changed = function(context, state, event)
        if event.entered == true
            and event.held_region_index == INTRO_REGION
            and not state:variable("intro.sent") then

            context:set_variable("intro.sent", true)

			context:start_timer("intro", 2000)
			context:start_timer("post_intro", 5000)
        end
    end,
	
	on_event_player_trigger = function(context, state, event)
		if event.slot == nil then return end
		
		if lib.is_slot(context, event, Slot.PT_BYPASS_RIGHT) or lib.is_slot(context, event, Slot.PT_BYPASSED_LEFT) then
			context:slot(Slot.PT_BYPASS_RIGHT):disarm_trigger()
			context:slot(Slot.PT_BYPASSED_LEFT):disarm_trigger()
			
			context:slot(Slot.REINFORCE_SQUAD_A_1):assign_combat_objective{
				objective = context:slot(Slot.MAIN_OBJECTIVE_80F6A0E6),
				task_group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_3,
			}
			
			context:slot(Slot.REINFORCE_SQUAD_A_2):assign_combat_objective{
				objective = context:slot(Slot.MAIN_OBJECTIVE_80F6A0E6),
				task_group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_3,
			}
			
			context:squad(Squad.REINFORCE_SQUAD_A_1):place{}
			context:squad(Squad.REINFORCE_SQUAD_A_2):place{}
			
			context:slot(Slot.REINFORCE_SQUAD_B):assign_combat_objective{
				objective = context:slot(Slot.MAIN_OBJECTIVE_80F6A0E6),
				task_group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_1,
			}
			
			context:squad(Squad.REINFORCE_SQUAD_B):place{}
			
			context:slot(Slot.REINFORCE_SQUAD_C):assign_combat_objective{
				objective = context:slot(Slot.MAIN_OBJECTIVE_80F6A0E6),
				task_group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_1,
			}
			
			context:squad(Squad.REINFORCE_SQUAD_C):place{}
			
			
			context:slot(Slot.INTERIOR_SQUAD_A):assign_combat_objective{
				objective = context:slot(Slot.BOSS_OBJECTIVE),
				task_group = mission.TaskGroup.BOSS_OBJECTIVE.GROUP_1,
			}
			
			context:slot(Slot.INTERIOR_SQUAD_B):assign_combat_objective{
				objective = context:slot(Slot.BOSS_OBJECTIVE),
				task_group = mission.TaskGroup.BOSS_OBJECTIVE.GROUP_2,
			}
			
			context:slot(Slot.INTERIOR_SQUAD_C):assign_combat_objective{
				objective = context:slot(Slot.BOSS_OBJECTIVE),
				task_group = mission.TaskGroup.BOSS_OBJECTIVE.GROUP_3,
			}
			
			context:slot(Slot.INTERIOR_SQUAD_D):assign_combat_objective{
				objective = context:slot(Slot.BOSS_OBJECTIVE),
				task_group = mission.TaskGroup.BOSS_OBJECTIVE.GROUP_4,
			}
			
			context:slot(Slot.INTERIOR_SQUAD_E):assign_combat_objective{
				objective = context:slot(Slot.BOSS_OBJECTIVE),
				task_group = mission.TaskGroup.BOSS_OBJECTIVE.GROUP_5,
			}
			context:slot(Slot.INTERIOR_SQUAD_BOSS):assign_combat_objective{
				objective = context:slot(Slot.BOSS_OBJECTIVE),
				task_group = mission.TaskGroup.BOSS_OBJECTIVE.GROUP_0,
			}
			
			context:squad(Squad.INTERIOR_SQUAD_A):place{}
			context:squad(Squad.INTERIOR_SQUAD_B):place{}
			context:squad(Squad.INTERIOR_SQUAD_C):place{}
			context:squad(Squad.INTERIOR_SQUAD_D):place{}
			context:squad(Squad.INTERIOR_SQUAD_E):place{}
			context:squad(Squad.INTERIOR_SQUAD_BOSS):place{}
		end
		
		if lib.is_slot(context, event, Slot.PT_SEED_PROPS) then
			context:slot(Slot.PT_SEED_PROPS):disarm_trigger()
			context:slot(Slot.INTRO_SQUAD_A):assign_combat_objective{
				objective = context:slot(Slot.MAIN_OBJECTIVE_80F6A0E6),
				task_group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_0,
			}
			
			context:slot(Slot.INTRO_SQUAD_B):assign_combat_objective{
				objective = context:slot(Slot.MAIN_OBJECTIVE_80F6A0E6),
				task_group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_0,
			}
			
			context:slot(Slot.INTRO_SQUAD_C):assign_combat_objective{
				objective = context:slot(Slot.MAIN_OBJECTIVE_80F6A0E6),
				task_group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_0,
			}
			
			context:slot(Slot.INTRO_SQUAD_D):assign_combat_objective{
				objective = context:slot(Slot.MAIN_OBJECTIVE_80F6A0E6),
				task_group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_0,
			}
			
			context:squad(Squad.INTRO_SQUAD_A):place{}
			context:squad(Squad.INTRO_SQUAD_B):place{}
			context:squad(Squad.INTRO_SQUAD_C):place{}
			context:squad(Squad.INTRO_SQUAD_D):place{}
		end
		
		if lib.is_slot(context, event, Slot.PT_SPAWN_DROPSHIPS_RIGHT) or lib.is_slot(context, event, Slot.PT_SPAWN_DROPSHIPS_LEFT) then
            -- Disarm first so a lingering player doesn't retrigger this.

            context:slot(Slot.PT_SPAWN_DROPSHIPS_RIGHT):disarm_trigger()
			context:slot(Slot.PT_SPAWN_DROPSHIPS_LEFT):disarm_trigger()
            context:clear_variable("braytech_visited.armed")

            -- Your event logic:
            context:set_variable("PT_SPAWN_DROPHSIPS", "I_have_been_triggered")
			
			context:slot(Slot.COURTYARD_SQUAD_B):assign_combat_objective{
				objective = context:slot(Slot.MAIN_OBJECTIVE_80F6A0E6),
				task_group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_1,
			}
			
			context:slot(Slot.COURTYARD_SQUAD_B_1):assign_combat_objective{
				objective = context:slot(Slot.MAIN_OBJECTIVE_80F6A0E6),
				task_group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_1,
			}
			
			context:slot(Slot.COURTYARD_SQUAD_C):assign_combat_objective{
				objective = context:slot(Slot.MAIN_OBJECTIVE_80F6A0E6),
				task_group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_2,
			}
			
			context:slot(Slot.COURTYARD_SQUAD_C_1):assign_combat_objective{
				objective = context:slot(Slot.MAIN_OBJECTIVE_80F6A0E6),
				task_group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_2,
			}
			
			context:squad(Squad.COURTYARD_SQUAD_B):place{}
			context:squad(Squad.COURTYARD_SQUAD_B_1):place{}
			context:squad(Squad.COURTYARD_SQUAD_C):place{}
			context:squad(Squad.COURTYARD_SQUAD_C_1):place{}
			context:start_timer("COURTYARD_SQUAD_A_DELAY", 1000)
        end
	end,
	
	on_event_timer_elapsed = function(context, state, event)
		if event.timer_name == "intro" then
			context:slot(sensor):play_dialogue_cue{cue = cues.CUE_1}
		end
		if event.timer_name == "post_intro" then
			context:slot(Slot.M_DIRECTIVE_SENSOR_80F6A396):set_directive{
                directive = Directive.CLEAR_A_PATH_TO_CLOVIS_BRAY,
            }
			
            context:slot(sensor):play_dialogue_cue{cue = cues.CUE_2}
		end
		if event.timer_name == "COURTYARD_SQUAD_A_DELAY" then
			
			context:slot(Slot.COURTYARD_SQUAD_A):assign_combat_objective{
				objective = context:slot(Slot.MAIN_OBJECTIVE_80F6A0E6),
				task_group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_3,
			}
			
			context:slot(Slot.COURTYARD_SQUAD_A_1):assign_combat_objective{
				objective = context:slot(Slot.MAIN_OBJECTIVE_80F6A0E6),
				task_group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_3,
			}
			
			context:slot(Slot.COURTYARD_SQUAD_A_2):assign_combat_objective{
				objective = context:slot(Slot.MAIN_OBJECTIVE_80F6A0E6),
				task_group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_3,
			}
			
			context:squad(Squad.COURTYARD_SQUAD_A):place{}
			context:squad(Squad.COURTYARD_SQUAD_A_1):place{}
			context:squad(Squad.COURTYARD_SQUAD_A_2):place{}
		end
	end,
}