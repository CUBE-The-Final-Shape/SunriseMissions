local missions = require("missions")
local mission = require(missions.MISSION_COMMANDO)
local lib = require("lib.mission_lib")
local combat = require("lib.combat")
local Slot, Squad, Scene, Directive = mission.Slot, mission.Squad, mission.Scene, mission.Directive
local sensor = mission.Slot.M_DIRECTIVE_SENSOR
local cues = mission.DialogueCue.M_DIALOG_SENSOR

local INTRO_REGION = mission.states.STATE_81538016_0000_0000_8153800E.region_index
local PLAZA = mission.states.STATE_81538016_0006_0000_81538014.region_index
local HANGAR = mission.states.STATE_81538016_0005_0000_81538013.region_index

local BLVD_ARENA = {Squad.SQ_A_WAVE_ONE_8153806D, Squad.SQ_B_WAVE_ONE_8153806D, Squad.SQ_C_WAVE_ONE_8153806D, Squad.SQ_D_WAVE_ONE_8153806D, Squad.SQ_E_WAVE_ONE_8153806D, Squad.SQ_F_WAVE_ONE_8153806D}

local PLAZA_ARENA = {Squad.SQ_A_WAVE_ONE_815385C6, Squad.SQ_B_WAVE_ONE_815385C6, Squad.SQ_C_WAVE_ONE_815385C6, Squad.SQ_D_WAVE_ONE_815385C6, Squad.SQ_E_WAVE_ONE_815385C6, Squad.SQ_SNIPER_A, Squad.SQ_SNIPER_B, Squad.SQ_SNIPER_C, Squad.SQ_BOSS_A_815385C6, Squad.SQ_BOSS_B_815385C6, Squad.SQ_BOSS_C_815385C6}

-- Each arena has an id (used as the "cleared" variable key), the squads that
-- must all be seen at full strength then dead, and the doors to open once
-- that happens. Add a new arena by adding one more entry here -- no new
-- code needed elsewhere.
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
}

local function arena_cleared(context, arena)
    return context:cohort{squads = arena.squads}.cleared
end

return {
    initial_state = {
        region_index = INTRO_REGION,
        spawn_set_hash = 0x2EA8FB98,
    },

    -- Runs once, when the mission starts for the first time.
    on_start = function(context, state)
        context:set_variable("hello", "started")
    end,

    on_load = function(context, state)
        context:set_variable("reloaded", true)
    end,

    on_event_region_changed = function(context, state, event)
        context:set_variable("last_region", event.region_index)
        local seen = state:variable("regions_seen") or 0
        context:set_variable("regions_seen", seen + 1)

        if event.region_index == PLAZA and not state:variable("plaza_visited.armed") then
            context:set_variable("plaza_visited.armed", true)

            context:slot(Slot.SQ_SNIPER_A):assign_combat_objective{
                objective = context:slot(Slot.OBJ_PLAZA),
                task_group = mission.TaskGroup.OBJ_PLAZA.GROUP_0,
            }

            context:slot(Slot.SQ_A_WAVE_ONE_815385C6):assign_combat_objective{
                objective = context:slot(Slot.OBJ_PLAZA),
                task_group = mission.TaskGroup.OBJ_PLAZA.GROUP_1,
            }

            context:slot(Slot.SQ_B_WAVE_ONE_815385C6):assign_combat_objective{
                objective = context:slot(Slot.OBJ_PLAZA),
                task_group = mission.TaskGroup.OBJ_PLAZA.GROUP_2,
            }

            context:slot(Slot.SQ_C_WAVE_ONE_815385C6):assign_combat_objective{
                objective = context:slot(Slot.OBJ_PLAZA),
                task_group = mission.TaskGroup.OBJ_PLAZA.GROUP_3,
            }

            context:slot(Slot.SQ_E_WAVE_ONE_815385C6):assign_combat_objective{
                objective = context:slot(Slot.OBJ_PLAZA),
                task_group = mission.TaskGroup.OBJ_PLAZA.GROUP_4,
            }

            context:slot(Slot.SQ_SNIPER_B):assign_combat_objective{
                objective = context:slot(Slot.OBJ_PLAZA),
                task_group = mission.TaskGroup.OBJ_PLAZA.GROUP_5,
            }

            context:slot(Slot.SQ_SNIPER_C):assign_combat_objective{
                objective = context:slot(Slot.OBJ_PLAZA),
                task_group = mission.TaskGroup.OBJ_PLAZA.GROUP_6,
            }

            context:slot(Slot.SQ_BOSS_C_815385C6):assign_combat_objective{
                objective = context:slot(Slot.OBJ_PLAZA),
                task_group = mission.TaskGroup.OBJ_PLAZA.GROUP_7,
            }

            context:slot(Slot.SQ_BOSS_B_815385C6):assign_combat_objective{
                objective = context:slot(Slot.OBJ_PLAZA),
                task_group = mission.TaskGroup.OBJ_PLAZA.GROUP_8,
            }

            context:slot(Slot.SQ_BOSS_A_815385C6):assign_combat_objective{
                objective = context:slot(Slot.OBJ_PLAZA),
                task_group = mission.TaskGroup.OBJ_PLAZA.GROUP_9,
            }
			
            context:slot(Slot.SQ_D_WAVE_ONE_815385C6):assign_combat_objective{
                objective = context:slot(Slot.OBJ_PLAZA),
                task_group = mission.TaskGroup.OBJ_PLAZA.GROUP_10,
            }

            context:squad(Squad.SQ_A_WAVE_ONE_815385C6):place{}
            context:squad(Squad.SQ_B_WAVE_ONE_815385C6):place{}
            context:squad(Squad.SQ_C_WAVE_ONE_815385C6):place{}
            context:squad(Squad.SQ_D_WAVE_ONE_815385C6):place{}
            context:squad(Squad.SQ_E_WAVE_ONE_815385C6):place{}
            context:squad(Squad.SQ_SNIPER_A):place{}
            context:squad(Squad.SQ_SNIPER_B):place{}
            context:squad(Squad.SQ_SNIPER_C):place{}
            context:squad(Squad.SQ_BOSS_A_815385C6):place{}
            context:squad(Squad.SQ_BOSS_B_815385C6):place{}
            context:squad(Squad.SQ_BOSS_C_815385C6):place{}
        end
		
		if event.region_index == HANGAR and not state:variable("hangar_visited.armed") then
            context:set_variable("hangar_visited.armed", true)
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

            context:slot(Slot.SQ_A_WAVE_ONE_8153806D):assign_combat_objective{
                objective = context:slot(Slot.OBJ_BLVD),
                task_group = mission.TaskGroup.OBJ_BLVD.GROUP_0,
            }

            context:slot(Slot.SQ_B_WAVE_ONE_8153806D):assign_combat_objective{
                objective = context:slot(Slot.OBJ_BLVD),
                task_group = mission.TaskGroup.OBJ_BLVD.GROUP_1,
            }

            context:slot(Slot.SQ_C_WAVE_ONE_8153806D):assign_combat_objective{
                objective = context:slot(Slot.OBJ_BLVD),
                task_group = mission.TaskGroup.OBJ_BLVD.GROUP_2,
            }

            context:slot(Slot.SQ_D_WAVE_ONE_8153806D):assign_combat_objective{
                objective = context:slot(Slot.OBJ_BLVD),
                task_group = mission.TaskGroup.OBJ_BLVD.GROUP_3,
            }

            context:slot(Slot.SQ_E_WAVE_ONE_8153806D):assign_combat_objective{
                objective = context:slot(Slot.OBJ_BLVD),
                task_group = mission.TaskGroup.OBJ_BLVD.GROUP_4,
            }

            context:slot(Slot.SQ_F_WAVE_ONE_8153806D):assign_combat_objective{
                objective = context:slot(Slot.OBJ_BLVD),
                task_group = mission.TaskGroup.OBJ_BLVD.GROUP_5,
            }

            context:squad(Squad.SQ_A_WAVE_ONE_8153806D):place{}
            context:squad(Squad.SQ_B_WAVE_ONE_8153806D):place{}
            context:squad(Squad.SQ_C_WAVE_ONE_8153806D):place{}
            context:squad(Squad.SQ_D_WAVE_ONE_8153806D):place{}
            context:squad(Squad.SQ_E_WAVE_ONE_8153806D):place{}
            context:squad(Squad.SQ_F_WAVE_ONE_8153806D):place{}
        end
    end,

    on_event_player_trigger = function(context, state, event)
        if event.slot == nil then return end

        if lib.is_slot(context, event, Slot.PT_ENTRY) then
			context:slot(Slot.PT_ENTRY):disarm_trigger()
		
            context:squad(mission.Squad.SQ_FRIENDLY_8153806D):place{}
            context:scene(mission.Scene.SCENE_INTRO_FRIENDLY):send_event{key = 0x7d465556}
        end
    end,

    on_event_timer_elapsed = function(context, state, event)
        -- Timer code here
    end,

    -- Checks every arena in ARENAS. Each one opens its own doors exactly
    -- once, the first time its squads are all seen at full strength and
    -- then dead. Unlike a chain of early `return`s, checking every arena
    -- every time means one arena resolving never blocks another from being
    -- checked later.
    on_event_squad_state = function(context, state, event)
        for _, arena in ipairs(ARENAS) do
            local key = arena.id .. ".arena_cleared"

            if not state:variable(key) and arena_cleared(context, arena) then
                context:set_variable(key, true)

                for _, door in ipairs(arena.doors) do
                    context:slot(door):transition{
                        transition = context.sdk.device_transitions.open,
                    }
                end
            end
        end
    end,
}