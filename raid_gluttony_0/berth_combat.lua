local lib = require("lib.mission_lib")
local combat = require("lib.combat")

local PROVOKED_PREFIX = "berth.provoked."
local HEALTH_PREFIX = "berth.health."

return function(mission)
    local objective = lib.one(mission.Slot.OBJ_BERTH_GUARDS, "berth combat objective")
    local squads = lib.list(
        mission.Slot.SQ_BERTH_0_GUARD,
        mission.Slot.SQ_BERTH_1_GUARD,
        mission.Slot.SQ_BERTH_2_GUARD,
        mission.Slot.SQ_BERTH_3_GUARD,
        mission.Slot.SQ_BERTH_4_GUARD,
        mission.Slot.SQ_BERTH_5_GUARD,
        mission.Slot.SQ_BERTH_6_GUARD,
        mission.Slot.SQ_BERTH_7_GUARD,
        mission.Slot.SQ_BERTH_0_CINE,
        mission.Slot.SQ_BERTH_1_CINE,
        mission.Slot.SQ_BERTH_2_CINE,
        mission.Slot.SQ_BERTH_3_CINE,
        mission.Slot.SQ_BERTH_4_CINE,
        mission.Slot.SQ_BERTH_5_CINE,
        mission.Slot.SQ_BERTH_6_CINE,
        mission.Slot.SQ_BERTH_7_CINE
    )
    local scenes = {
        lib.one(mission.Scene.SCENE_BERTH_GUARD_INTRO_0, "guard scene 0"),
        lib.one(mission.Scene.SCENE_BERTH_GUARD_INTRO_1, "guard scene 1"),
        lib.one(mission.Scene.SCENE_BERTH_GUARD_INTRO_2, "guard scene 2"),
        lib.one(mission.Scene.SCENE_BERTH_GUARD_INTRO_3, "guard scene 3"),
        lib.one(mission.Scene.SCENE_BERTH_GUARD_INTRO_4, "guard scene 4"),
        lib.one(mission.Scene.SCENE_BERTH_GUARD_INTRO_5, "guard scene 5"),
        lib.one(mission.Scene.SCENE_BERTH_GUARD_INTRO_6, "guard scene 6"),
        lib.one(mission.Scene.SCENE_BERTH_GUARD_INTRO_7, "guard scene 7"),
        lib.one(mission.Scene.SCENE_BERTH_GUARD_CINE_0, "cine scene 0"),
        lib.one(mission.Scene.SCENE_BERTH_GUARD_CINE_1, "cine scene 1"),
        lib.one(mission.Scene.SCENE_BERTH_GUARD_CINE_2, "cine scene 2"),
        lib.one(mission.Scene.SCENE_BERTH_GUARD_CINE_3, "cine scene 3"),
        lib.one(mission.Scene.SCENE_BERTH_GUARD_CINE_4, "cine scene 4"),
        lib.one(mission.Scene.SCENE_BERTH_GUARD_CINE_5, "cine scene 5"),
        lib.one(mission.Scene.SCENE_BERTH_GUARD_CINE_6, "cine scene 6"),
        lib.one(mission.Scene.SCENE_BERTH_GUARD_CINE_7, "cine scene 7"),
    }
    local combatants = lib.list(
        mission.Slot.SQ_BERTH_0_GUARD_CELL_1,
        mission.Slot.SQ_BERTH_1_GUARD_CELL_1,
        mission.Slot.SQ_BERTH_2_GUARD_CELL_1,
        mission.Slot.SQ_BERTH_3_GUARD_CELL_1,
        mission.Slot.SQ_BERTH_4_GUARD_CELL_1,
        mission.Slot.SQ_BERTH_5_GUARD_CELL_1,
        mission.Slot.SQ_BERTH_6_GUARD_CELL_1,
        mission.Slot.SQ_BERTH_7_GUARD_CELL_1,
        mission.Slot.SQ_BERTH_0_CINE_CELL_1,
        mission.Slot.SQ_BERTH_1_CINE_CELL_1,
        mission.Slot.SQ_BERTH_2_CINE_CELL_1,
        mission.Slot.SQ_BERTH_3_CINE_CELL_1,
        mission.Slot.SQ_BERTH_4_CINE_CELL_1,
        mission.Slot.SQ_BERTH_5_CINE_CELL_1,
        mission.Slot.SQ_BERTH_6_CINE_CELL_1,
        mission.Slot.SQ_BERTH_7_CINE_CELL_1
    )

    local guard_squads = lib.list(
        mission.Squad.SQ_BERTH_0_GUARD,
        mission.Squad.SQ_BERTH_1_GUARD,
        mission.Squad.SQ_BERTH_2_GUARD,
        mission.Squad.SQ_BERTH_3_GUARD,
        mission.Squad.SQ_BERTH_4_GUARD,
        mission.Squad.SQ_BERTH_5_GUARD,
        mission.Squad.SQ_BERTH_6_GUARD,
        mission.Squad.SQ_BERTH_7_GUARD
    )
    local cinematic_squads = lib.list(
        mission.Squad.SQ_BERTH_0_CINE,
        mission.Squad.SQ_BERTH_1_CINE,
        mission.Squad.SQ_BERTH_2_CINE,
        mission.Squad.SQ_BERTH_3_CINE,
        mission.Squad.SQ_BERTH_4_CINE,
        mission.Squad.SQ_BERTH_5_CINE,
        mission.Squad.SQ_BERTH_6_CINE,
        mission.Squad.SQ_BERTH_7_CINE
    )
    local groups = {
        {squads = guard_squads, first = 1},
        {squads = cinematic_squads, first = #guard_squads + 1},
    }
    local task_groups = lib.list(
        mission.TaskGroup.OBJ_BERTH_GUARDS.GROUP_0,
        mission.TaskGroup.OBJ_BERTH_GUARDS.GROUP_1,
        mission.TaskGroup.OBJ_BERTH_GUARDS.GROUP_2
    )

    local function group_for(index)
        for _, group in ipairs(groups) do
            if index >= group.first and index < group.first + #group.squads then
                return group, index - group.first + 1
            end
        end
    end

    local function find_squad(context, event)
        for index, declaration in ipairs(squads) do
            if lib.is_slot(context, event, declaration) then
                return context:slot(declaration), index
            end
        end
    end

    -- A provocation names its squad by registry and index; it carries no slot handle.
    local function find_provoked(context, event)
        for index, declaration in ipairs(squads) do
            local squad = context:slot(declaration)
            if squad.registry_key == event.registry_key and squad.slot_index == event.slot_index
                and squad.slot_type == event.slot_type then
                return squad, index
            end
        end
    end

    local function assign(context, squad, group, reconsider)
        squad:assign_combat_objective{
            objective = context:slot(objective), task_group = group,
            reconsider = reconsider or false,
            refresh_player_awareness = reconsider or false,
        }
        return true
    end

    local function provoke(context, state, index)
        local group = group_for(index)
        local changed = false
        for offset, _ in ipairs(group.squads) do
            local member_index = group.first + offset - 1
            local member = context:slot(squads[member_index])
            local key = PROVOKED_PREFIX .. member.slot_index
            if not state:variable(key) then
                context:scene(scenes[member_index]):stop{}
                assign(context, member, nil, true)
                context:set_variable(key, true)
                changed = true
            end
        end
        return changed
    end

    local function injured(context, state, index, squad)
        local health = state:variable(HEALTH_PREFIX .. squad.slot_index)
        if type(health) ~= "number" or health < 0 or health >= 1
            or state:variable(PROVOKED_PREFIX .. squad.slot_index) then
            return false
        end
        local group, offset = group_for(index)
        local alive = context:cohort{squads = {group.squads[offset]}}.alive_count
        return alive ~= nil and alive > 0 and provoke(context, state, index)
    end

    -- TODO: play the guard voice cue on player approach and at about 75% door open; no input
    -- that keeps the guard pose is known.
    return {
        start_scenes = function(context, state)
            for index, declaration in ipairs(squads) do
                local squad = context:slot(declaration)
                if state:variable(PROVOKED_PREFIX .. squad.slot_index) == nil then
                    context:scene(scenes[index]):activate{spawn = true}
                    context:set_variable(PROVOKED_PREFIX .. squad.slot_index, false)
                end
            end
        end,
        on_squad_state = function(context, state, event)
            local squad, index = find_squad(context, event)
            if squad == nil or event.alive_count <= 0 then return false end
            if injured(context, state, index, squad) then return true end
            local current, assigned = event:task_group{objective = context:slot(objective)}
            if not state:variable(PROVOKED_PREFIX .. squad.slot_index) then
                if not assigned or current ~= nil then return assign(context, squad, nil) end
                return false
            end
            if not assigned then return assign(context, squad, nil) end
            local selected, known = combat.lowest_cost(event, task_groups, current)
            if not known or combat.same_group(selected, current) then return false end
            return assign(context, squad, selected)
        end,
        on_squad_provoked = function(context, state, event)
            local squad, index = find_provoked(context, event)
            if squad == nil or state:variable(PROVOKED_PREFIX .. squad.slot_index) then
                return false
            end
            return provoke(context, state, index)
        end,
        on_damage_state = function(context, state, event)
            for index, declaration in ipairs(combatants) do
                if lib.is_slot(context, event, declaration) then
                    local squad = context:slot(squads[index])
                    local health = event.health
                    if type(health) ~= "number" or health ~= health or health < 0 or health > 1 then
                        context:clear_variable(HEALTH_PREFIX .. squad.slot_index)
                        return false
                    end
                    context:set_variable(HEALTH_PREFIX .. squad.slot_index, health)
                    return injured(context, state, index, squad) or false
                end
            end
            return false
        end,
        on_entity_died = function(context, state, event)
            local squad, index = find_squad(context, event)
            if squad == nil or event.previous_alive_count <= 0
                or event.alive_count >= event.previous_alive_count then
                return false
            end
            return provoke(context, state, index)
        end,
    }
end
