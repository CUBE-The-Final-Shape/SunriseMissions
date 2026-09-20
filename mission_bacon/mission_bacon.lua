local missions = require("missions")
local mission = require(missions.MISSION_BACON)
local lib = require("lib.mission_lib")
local Slot, Directive, Squad, Scene = mission.Slot, mission.Directive, mission.Squad, mission.Scene
local sensor = mission.Slot.M_DIALOG_SENSOR_80F6A396
local cues = mission.DialogueCue.M_DIALOG_SENSOR_80F6A396

local INTRO_REGION = mission.states.STATE_80F6A028_0005_0000_80F6A984.region_index  -- 40
local BRAYTECH_FUTURESCAPES = mission.states.STATE_80F6A028_0001_0000_80F6A01C.region_index -- 8

local BRAYTECH_FUTURESCAPES_ARENA = {
    Squad.INTERIOR_SQUAD_BOSS,
}

-- Each wave has an id and a list of squad members. Every member carries its
-- own slot/squad/objective/group, since squads within one wave don't always
-- share a group (see interior and courtyard_bc below).
local WAVES = {
    {
        id = "intro",
        squads = {
            {slot = Slot.INTRO_SQUAD_A, squad = Squad.INTRO_SQUAD_A, objective = Slot.MAIN_OBJECTIVE_80F6A0E6, group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_0},
            {slot = Slot.INTRO_SQUAD_B, squad = Squad.INTRO_SQUAD_B, objective = Slot.MAIN_OBJECTIVE_80F6A0E6, group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_0},
            {slot = Slot.INTRO_SQUAD_C, squad = Squad.INTRO_SQUAD_C, objective = Slot.MAIN_OBJECTIVE_80F6A0E6, group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_0},
            {slot = Slot.INTRO_SQUAD_D, squad = Squad.INTRO_SQUAD_D, objective = Slot.MAIN_OBJECTIVE_80F6A0E6, group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_0},
        },
    },
    {
        id = "interior",
        squads = {
            {slot = Slot.INTERIOR_SQUAD_A,    squad = Squad.INTERIOR_SQUAD_A,    objective = Slot.BOSS_OBJECTIVE, group = mission.TaskGroup.BOSS_OBJECTIVE.GROUP_1},
            {slot = Slot.INTERIOR_SQUAD_B,    squad = Squad.INTERIOR_SQUAD_B,    objective = Slot.BOSS_OBJECTIVE, group = mission.TaskGroup.BOSS_OBJECTIVE.GROUP_2},
            {slot = Slot.INTERIOR_SQUAD_C,    squad = Squad.INTERIOR_SQUAD_C,    objective = Slot.BOSS_OBJECTIVE, group = mission.TaskGroup.BOSS_OBJECTIVE.GROUP_3},
            {slot = Slot.INTERIOR_SQUAD_D,    squad = Squad.INTERIOR_SQUAD_D,    objective = Slot.BOSS_OBJECTIVE, group = mission.TaskGroup.BOSS_OBJECTIVE.GROUP_4},
            {slot = Slot.INTERIOR_SQUAD_E,    squad = Squad.INTERIOR_SQUAD_E,    objective = Slot.BOSS_OBJECTIVE, group = mission.TaskGroup.BOSS_OBJECTIVE.GROUP_5},
            {slot = Slot.INTERIOR_SQUAD_BOSS, squad = Squad.INTERIOR_SQUAD_BOSS, objective = Slot.BOSS_OBJECTIVE, group = mission.TaskGroup.BOSS_OBJECTIVE.GROUP_0},
        },
    },
    {
        id = "courtyard_bc",
        squads = {
            {slot = Slot.COURTYARD_SQUAD_B,   squad = Squad.COURTYARD_SQUAD_B,   objective = Slot.MAIN_OBJECTIVE_80F6A0E6, group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_1},
            {slot = Slot.COURTYARD_SQUAD_B_1, squad = Squad.COURTYARD_SQUAD_B_1, objective = Slot.MAIN_OBJECTIVE_80F6A0E6, group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_1},
            {slot = Slot.COURTYARD_SQUAD_C,   squad = Squad.COURTYARD_SQUAD_C,   objective = Slot.MAIN_OBJECTIVE_80F6A0E6, group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_2},
            {slot = Slot.COURTYARD_SQUAD_C_1, squad = Squad.COURTYARD_SQUAD_C_1, objective = Slot.MAIN_OBJECTIVE_80F6A0E6, group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_2},
        },
    },
    {
        id = "courtyard_a",
        squads = {
            {slot = Slot.COURTYARD_SQUAD_A,   squad = Squad.COURTYARD_SQUAD_A,   objective = Slot.MAIN_OBJECTIVE_80F6A0E6, group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_3},
            {slot = Slot.COURTYARD_SQUAD_A_1, squad = Squad.COURTYARD_SQUAD_A_1, objective = Slot.MAIN_OBJECTIVE_80F6A0E6, group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_3},
            {slot = Slot.COURTYARD_SQUAD_A_2, squad = Squad.COURTYARD_SQUAD_A_2, objective = Slot.MAIN_OBJECTIVE_80F6A0E6, group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_3},
        },
    },
    {
        id = "reinforce_a",
        squads = {
            {slot = Slot.REINFORCE_SQUAD_A_1, squad = Squad.REINFORCE_SQUAD_A_1, objective = Slot.MAIN_OBJECTIVE_80F6A0E6, group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_3},
            {slot = Slot.REINFORCE_SQUAD_A_2, squad = Squad.REINFORCE_SQUAD_A_2, objective = Slot.MAIN_OBJECTIVE_80F6A0E6, group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_3},
        },
    },
    {
        id = "reinforce_b",
        squads = {
            {slot = Slot.REINFORCE_SQUAD_B, squad = Squad.REINFORCE_SQUAD_B, objective = Slot.MAIN_OBJECTIVE_80F6A0E6, group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_1},
        },
    },
    {
        id = "reinforce_c",
        squads = {
            {slot = Slot.REINFORCE_SQUAD_C, squad = Squad.REINFORCE_SQUAD_C, objective = Slot.MAIN_OBJECTIVE_80F6A0E6, group = mission.TaskGroup.MAIN_OBJECTIVE_80F6A0E6.GROUP_1},
        },
    },
}

local function find_wave(id)
    for _, wave in ipairs(WAVES) do
        if wave.id == id then
            return wave
        end
    end
end

-- Assigns every member's combat objective first, then places every member.
-- Objectives are assigned before any place{} call in the wave, matching the
-- "assign objective before placing" rule from the recipes page.
local function spawn_wave(context, id)
    local wave = find_wave(id)
    if not wave then return end

    for _, squad in ipairs(wave.squads) do
        context:slot(squad.slot):assign_combat_objective{
            objective = context:slot(squad.objective),
            task_group = squad.group,
        }
    end
    for _, squad in ipairs(wave.squads) do
        context:squad(squad.squad):place{}
    end
end

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
		context:scene(mission.Scene.SCN_ANA_POWER_UP_BRAY):activate{}
		context:scene(mission.Scene.SCN_ANA_POWER_UP_BRAY):send_event{key = 0x3f9c28bd}
		context:squad(mission.Squad.SQ_ANA_VIGNETTE):place{}
    end,

    -- Runs each time the player moves into another region.
    on_event_region_changed = function(context, state, event)
        context:set_variable("last_region", event.region_index)
        local seen = state:variable("regions_seen") or 0
        context:set_variable("regions_seen", seen + 1)

        if event.region_index == BRAYTECH_FUTURESCAPES then
            -- Same directive every time -> refreshes silently, no popup after the first.
            context:slot(Slot.M_DIRECTIVE_SENSOR_80F6A396):set_directive{
                directive = Directive.SECURE_BRAYTECH_FUTURESCAPE,
            }

            local key = context:select_state(mission.states.STATE_80F6A028_0001_0000_80F6A01C)
            context:set_variable("move_request", key.value)

            if not state:variable("braytech_visited.armed") then
                context:set_variable("Braytech_futurescapes", "I_am_here")
                context:set_variable("braytech_visited.armed", true)
                context:slot(Slot.PT_SPAWN_DROPSHIPS_RIGHT):fire_trigger()
                context:slot(Slot.PT_SPAWN_DROPSHIPS_LEFT):fire_trigger()
                context:slot(Slot.PT_SEED_PROPS):fire_trigger()
                context:slot(Slot.PT_BYPASS_RIGHT):fire_trigger()
                context:slot(Slot.PT_BYPASSED_LEFT):fire_trigger()
            end
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
            -- Boss won't spawn if entering futurescape from left side. Consider hooking boss spawn to a trigger on both sides possibly dropship spawn. Hook reinforcements to squads taking damage
            context:slot(Slot.PT_BYPASS_RIGHT):disarm_trigger()
            context:slot(Slot.PT_BYPASSED_LEFT):disarm_trigger()
        end

        if lib.is_slot(context, event, Slot.PT_SEED_PROPS) then
            context:slot(Slot.PT_SEED_PROPS):disarm_trigger()
            spawn_wave(context, "intro")
        end

        if lib.is_slot(context, event, Slot.PT_SPAWN_DROPSHIPS_RIGHT) or lib.is_slot(context, event, Slot.PT_SPAWN_DROPSHIPS_LEFT) then
            -- Disarm first so a lingering player doesn't retrigger this.
            context:slot(Slot.PT_SPAWN_DROPSHIPS_RIGHT):disarm_trigger()
            context:slot(Slot.PT_SPAWN_DROPSHIPS_LEFT):disarm_trigger()
            context:clear_variable("braytech_visited.armed")

            -- Your event logic:
            context:set_variable("PT_SPAWN_DROPHSIPS", "spawning_dropships_and_interior_squads")

            spawn_wave(context, "interior")
            spawn_wave(context, "courtyard_bc")

            context:start_timer("COURTYARD_SQUAD_A_DELAY", 1500)
        end
    end,

    on_event_entity_died = function(context, state, event)
        if lib.is_slot(context, event, Slot.COURTYARD_SQUAD_A) and event.alive_count == 0 then
            spawn_wave(context, "reinforce_a")
        end

        if lib.is_slot(context, event, Slot.COURTYARD_SQUAD_B) and event.alive_count == 0 then
            spawn_wave(context, "reinforce_b")
        end

        if lib.is_slot(context, event, Slot.COURTYARD_SQUAD_C) and event.alive_count == 0 then
            spawn_wave(context, "reinforce_c")
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
            spawn_wave(context, "courtyard_a")
            context:start_timer("arena_check", 2000)
        end

        if event.timer_name == "arena_check" then
            if context:cohort{squads = BRAYTECH_FUTURESCAPES_ARENA}.cleared then
                context:set_variable("arena.cleared", true)
                context:set_variable("BRAY_FUTURE_ENCOUNTER", "cleared")
                context:slot(Slot.M_DIRECTIVE_SENSOR_80F6A396):clear_directives()
            else
                context:start_timer("arena_check", 2000) -- keep polling
            end
        end
    end,
}
