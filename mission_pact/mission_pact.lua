-- Tree of Probabilities. Native mission logic; live play remains unverified.
-- Absent: eight Forest defenders, Harvester delivery, boss retreat motion and immunity.
local missions = require("missions")
local mission = require(missions.MISSION_PACT)
local campaign = require("lib.campaign")
local EventKind = require("sunrise.activity_sdk").EventKind
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive, Scene = mission.Slot, mission.Squad, mission.Directive, mission.Scene
local cue = mission.DialogueCue.M_DIALOG_SENSOR

local intro = {
    id = "intro",
    objective = Slot.OBJ_PACT_LIGHTHOUSE,
    squads = {
        unit(Squad.SQ_INTRO_FIGHT_0, Slot.SQ_INTRO_FIGHT_0),
        unit(Squad.SQ_INTRO_FIGHT_1, Slot.SQ_INTRO_FIGHT_1),
    },
}

local vanguard = {
    id = "vanguard",
    after = "landing",
    objective = Slot.OBJ_PACT_LIGHTHOUSE,
    squads = {
        unit(Squad.SQ_CABAL_VANGUARD_0, Slot.SQ_CABAL_VANGUARD_0),
        unit(Squad.SQ_CABAL_VANGUARD_1, Slot.SQ_CABAL_VANGUARD_1),
        unit(Squad.SQ_CABAL_VANGUARD_2, Slot.SQ_CABAL_VANGUARD_2),
        unit(Squad.SQ_MIXED_CENTER_0, Slot.SQ_MIXED_CENTER_0),
        unit(Squad.SQ_MIXED_CENTER_4, Slot.SQ_MIXED_CENTER_4),
        unit(Squad.SQ_MIXED_CENTER_7, Slot.SQ_MIXED_CENTER_7),
    },
}

local rearguard = {
    id = "rearguard",
    on_start = function(context)
        context:slot(Slot.SQ_CABAL_ANCHOR_GLADIATOR):bind_combatant_to_squad()
    end,
    trigger = Slot.PT_NEAR_GATE,
    objective = Slot.OBJ_PACT_LIGHTHOUSE,
    squads = {
        unit(Squad.SQ_CABAL_REARGUARD_0, Slot.SQ_CABAL_REARGUARD_0),
        unit(Squad.SQ_CABAL_REARGUARD_2, Slot.SQ_CABAL_REARGUARD_2),
        unit(Squad.SQ_VEX_HARASSERS_0, Slot.SQ_VEX_HARASSERS_0),
        unit(Squad.SQ_CABAL_ANCHOR, Slot.SQ_CABAL_ANCHOR),
    },
}

local basilisk = {
    id = "basilisk",
    trigger = Slot.PT_NEAR_GATE,
    objective = Slot.OBJ_PACT_LIGHTHOUSE,
    squads = {
        unit(Squad.SQ_BASILISK, Slot.SQ_BASILISK),
    },
}
local portal = {
    id = "portal",
    after = "barrier",
    objective = Slot.OBJ_IFB,
    squads = {
        unit(Squad.SQ_PORTAL_GUARD_0, Slot.SQ_PORTAL_GUARD_0),
        unit(Squad.SQ_PORTAL_GUARD_1, Slot.SQ_PORTAL_GUARD_1),
    },
}

local first_room = {
    id = "first_room",
    trigger = Slot.PT_ENTER_CHASE,
    objective = Slot.OBJ_CHASE,
    squads = {
        unit(Squad.SQ_CABAL_FIRSTROOM_0, Slot.SQ_CABAL_FIRSTROOM_0),
        unit(Squad.SQ_CABAL_FIRSTROOM_1, Slot.SQ_CABAL_FIRSTROOM_1),
        unit(Squad.SQ_CABAL_FIRSTROOM_2, Slot.SQ_CABAL_FIRSTROOM_2),
        unit(Squad.SQ_CABAL_FIRSTROOM_3, Slot.SQ_CABAL_FIRSTROOM_3),
        unit(Squad.SQ_CABAL_FIRSTROOM_4, Slot.SQ_CABAL_FIRSTROOM_4),
        unit(Squad.SQ_CABAL_FIRSTROOM_5, Slot.SQ_CABAL_FIRSTROOM_5),
        unit(Squad.SQ_CABAL_FIRSTROOM_6, Slot.SQ_CABAL_FIRSTROOM_6),
        unit(Squad.SQ_VEX_FIRSTROOM_0, Slot.SQ_VEX_FIRSTROOM_0),
        unit(Squad.SQ_VEX_FIRSTROOM_1, Slot.SQ_VEX_FIRSTROOM_1),
        unit(Squad.SQ_VEX_FIRSTROOM_2, Slot.SQ_VEX_FIRSTROOM_2),
        unit(Squad.SQ_VEX_FIRSTROOM_3, Slot.SQ_VEX_FIRSTROOM_3),
        unit(Squad.SQ_VEX_FIRSTROOM_4, Slot.SQ_VEX_FIRSTROOM_4),
        unit(Squad.SQ_VEX_FIRSTROOM_5, Slot.SQ_VEX_FIRSTROOM_5),
        unit(Squad.SQ_VEX_FIRSTROOM_6, Slot.SQ_VEX_FIRSTROOM_6),
    },
}

local chase_reinforce = {
    id = "chase_reinforce",
    after = "chase_reinforce",
    objective = Slot.OBJ_CHASE,
    squads = {
        unit(Squad.SQ_CABAL_REINFORCEMENTS_0, Slot.SQ_CABAL_REINFORCEMENTS_0),
        unit(Squad.SQ_CABAL_REINFORCEMENTS_1, Slot.SQ_CABAL_REINFORCEMENTS_1),
        unit(Squad.SQ_CABAL_REINFORCEMENTS_2, Slot.SQ_CABAL_REINFORCEMENTS_2),
        unit(Squad.SQ_VEX_REINFORCEMENTS_0, Slot.SQ_VEX_REINFORCEMENTS_0),
        unit(Squad.SQ_VEX_REINFORCEMENTS_1, Slot.SQ_VEX_REINFORCEMENTS_1),
        unit(Squad.SQ_VEX_REINFORCEMENTS_2, Slot.SQ_VEX_REINFORCEMENTS_2),
    },
}

local conflict = {
    id = "conflict",
    after = "conflict",
    objective = Slot.OBJ_CHASE,
    squads = {
        unit(Squad.SQ_CONFLICT_SNIPERS_0, Slot.SQ_CONFLICT_SNIPERS_0),
        unit(Squad.SQ_CONFLICT_SNIPERS_1, Slot.SQ_CONFLICT_SNIPERS_1),
        unit(Squad.SQ_CONFLICT_GOONS_TOP_0, Slot.SQ_CONFLICT_GOONS_TOP_0),
        unit(Squad.SQ_CONFLICT_GOONS_TOP_1, Slot.SQ_CONFLICT_GOONS_TOP_1),
        unit(Squad.SQ_CONFLICT_GOONS_0, Slot.SQ_CONFLICT_GOONS_0),
        unit(Squad.SQ_CONFLICT_GOONS_1, Slot.SQ_CONFLICT_GOONS_1),
        unit(Squad.SQ_CONFLICT_GOONS_2, Slot.SQ_CONFLICT_GOONS_2),
        unit(Squad.SQ_CONFLICT_GOONS_3, Slot.SQ_CONFLICT_GOONS_3),
        unit(Squad.SQ_CONFLICT_GOONS_4, Slot.SQ_CONFLICT_GOONS_4),
        unit(Squad.SQ_CONFLICT_GOONS_5, Slot.SQ_CONFLICT_GOONS_5),
    },
}

local ledge = {
    id = "ledge",
    after = "ledge",
    objective = Slot.OBJ_BOMB,
    squads = {
        unit(Squad.SQ_CABAL_LEDGE_0, Slot.SQ_CABAL_LEDGE_0),
        unit(Squad.SQ_CABAL_LEDGE_1, Slot.SQ_CABAL_LEDGE_1),
        unit(Squad.SQ_CABAL_LEDGE_2, Slot.SQ_CABAL_LEDGE_2),
        unit(Squad.SQ_CABAL_LEDGE_3, Slot.SQ_CABAL_LEDGE_3),
        unit(Squad.SQ_CABAL_LEDGE_4, Slot.SQ_CABAL_LEDGE_4),
        unit(Squad.SQ_CABAL_LEDGE_5, Slot.SQ_CABAL_LEDGE_5),
        unit(Squad.SQ_CABAL_LEDGE_6, Slot.SQ_CABAL_LEDGE_6),
        unit(Squad.SQ_CABAL_LEDGE_7, Slot.SQ_CABAL_LEDGE_7),
        unit(Squad.SQ_CABAL_LEDGE_8, Slot.SQ_CABAL_LEDGE_8),
        unit(Squad.SQ_CABAL_LEDGE_9, Slot.SQ_CABAL_LEDGE_9),
        unit(Squad.SQ_CABAL_LEDGE_10, Slot.SQ_CABAL_LEDGE_10),
        unit(Squad.SQ_CABAL_LEDGE_11, Slot.SQ_CABAL_LEDGE_11),
        unit(Squad.SQ_CABAL_LEDGE_12, Slot.SQ_CABAL_LEDGE_12),
        unit(Squad.SQ_VEX_LEDGE_0, Slot.SQ_VEX_LEDGE_0),
        unit(Squad.SQ_VEX_LEDGE_1, Slot.SQ_VEX_LEDGE_1),
        unit(Squad.SQ_VEX_LEDGE_2, Slot.SQ_VEX_LEDGE_2),
        unit(Squad.SQ_VEX_LEDGE_3, Slot.SQ_VEX_LEDGE_3),
        unit(Squad.SQ_VEX_LEDGE_4, Slot.SQ_VEX_LEDGE_4),
        unit(Squad.SQ_VEX_LEDGE_5, Slot.SQ_VEX_LEDGE_5),
        unit(Squad.SQ_VEX_LEDGE_6, Slot.SQ_VEX_LEDGE_6),
        unit(Squad.SQ_VEX_LEDGE_7, Slot.SQ_VEX_LEDGE_7),
        unit(Squad.SQ_VEX_LEDGE_8, Slot.SQ_VEX_LEDGE_8),
        unit(Squad.SQ_VEX_LEDGE_9, Slot.SQ_VEX_LEDGE_9),
        unit(Squad.SQ_VEX_LEDGE_10, Slot.SQ_VEX_LEDGE_10),
        unit(Squad.SQ_VEX_LEDGE_11, Slot.SQ_VEX_LEDGE_11),
        unit(Squad.SQ_VEX_LEDGE_12, Slot.SQ_VEX_LEDGE_12),
    },
}

local prefight = {
    id = "prefight",
    after = "ledge",
    objective = Slot.OBJ_BOMB_BOSS,
    squads = {
        unit(Squad.SQ_PREFIGHT_SKIRMISH_0, Slot.SQ_PREFIGHT_SKIRMISH_0),
        unit(Squad.SQ_PREFIGHT_SKIRMISH_1, Slot.SQ_PREFIGHT_SKIRMISH_1),
        unit(Squad.SQ_PREFIGHT_SKIRMISH_2, Slot.SQ_PREFIGHT_SKIRMISH_2),
        unit(Squad.SQ_PREFIGHT_SKIRMISH_3, Slot.SQ_PREFIGHT_SKIRMISH_3),
        unit(Squad.SQ_PREFIGHT_SKIRMISH_4, Slot.SQ_PREFIGHT_SKIRMISH_4),
        unit(Squad.SQ_PREFIGHT_SKIRMISH_5, Slot.SQ_PREFIGHT_SKIRMISH_5),
    },
}
local minotaur = {
    id = "minotaur",
    after = "reveal",
    objective = Slot.OBJ_BOMB_BOSS,
    squads = {
        unit(Squad.SQ_MINOTAUR_INTRO, Slot.SQ_MINOTAUR_INTRO),
    },
}

local boss = {
    id = "boss",
    after = "reveal",
    objective = Slot.OBJ_BOMB_BOSS,
    squads = {unit(Squad.SQ_BOSS_80F54E07, Slot.SQ_BOSS_80F54E07)},
    on_start = function(context)
        context:slot(Slot.SQ_BOSS_VAL_THOOUN):bind_combatant_to_squad()
    end,
}

local room1 = {
    id = "room1",
    after = "room1",
    objective = Slot.OBJ_BOMB_BOSS,
    squads = {
        unit(Squad.SQ_ROOM1_ADDS_0, Slot.SQ_ROOM1_ADDS_0),
        unit(Squad.SQ_ROOM1_ADDS_1, Slot.SQ_ROOM1_ADDS_1),
        unit(Squad.SQ_ROOM1_ADDS_2, Slot.SQ_ROOM1_ADDS_2),
        unit(Squad.SQ_ROOM1_ADDS_3, Slot.SQ_ROOM1_ADDS_3),
        unit(Squad.SQ_ROOM1_ADDS_4, Slot.SQ_ROOM1_ADDS_4),
        unit(Squad.SQ_ROOM1_ADDS_5, Slot.SQ_ROOM1_ADDS_5),
        unit(Squad.SQ_ROOM1_ADDS_6, Slot.SQ_ROOM1_ADDS_6),
        unit(Squad.SQ_ROOM1_VEX_0, Slot.SQ_ROOM1_VEX_0),
        unit(Squad.SQ_ROOM1_VEX_1, Slot.SQ_ROOM1_VEX_1),
        unit(Squad.SQ_ROOM1_VEX_2, Slot.SQ_ROOM1_VEX_2),
        unit(Squad.SQ_ROOM1_VEX_3, Slot.SQ_ROOM1_VEX_3),
        unit(Squad.SQ_ROOM1_VEX_4, Slot.SQ_ROOM1_VEX_4),
        unit(Squad.SQ_ROOM1_VEX_5, Slot.SQ_ROOM1_VEX_5),
        unit(Squad.SQ_ROOM1_VEX_6, Slot.SQ_ROOM1_VEX_6),
        unit(Squad.SQ_ROOM1_SHIELD_VEX, Slot.SQ_ROOM1_SHIELD_VEX),
    },
}

local room2 = {
    id = "room2",
    after = "room2",
    objective = Slot.OBJ_BOMB_BOSS,
    squads = {
        unit(Squad.SQ_ROOM2_ADDS_0, Slot.SQ_ROOM2_ADDS_0),
        unit(Squad.SQ_ROOM2_ADDS_1, Slot.SQ_ROOM2_ADDS_1),
        unit(Squad.SQ_ROOM2_ADDS_2, Slot.SQ_ROOM2_ADDS_2),
        unit(Squad.SQ_ROOM2_ADDS_3, Slot.SQ_ROOM2_ADDS_3),
        unit(Squad.SQ_ROOM2_ADDS_4, Slot.SQ_ROOM2_ADDS_4),
        unit(Squad.SQ_ROOM2_ADDS_5, Slot.SQ_ROOM2_ADDS_5),
        unit(Squad.SQ_ROOM2_ADDS_6, Slot.SQ_ROOM2_ADDS_6),
        unit(Squad.SQ_ROOM2_VEX_0, Slot.SQ_ROOM2_VEX_0),
        unit(Squad.SQ_ROOM2_VEX_1, Slot.SQ_ROOM2_VEX_1),
        unit(Squad.SQ_ROOM2_VEX_2, Slot.SQ_ROOM2_VEX_2),
        unit(Squad.SQ_ROOM2_VEX_3, Slot.SQ_ROOM2_VEX_3),
        unit(Squad.SQ_ROOM2_VEX_4, Slot.SQ_ROOM2_VEX_4),
        unit(Squad.SQ_ROOM2_VEX_5, Slot.SQ_ROOM2_VEX_5),
        unit(Squad.SQ_ROOM2_VEX_6, Slot.SQ_ROOM2_VEX_6),
        unit(Squad.SQ_ROOM2_SHIELD_VEX, Slot.SQ_ROOM2_SHIELD_VEX),
    },
}

local room3 = {
    id = "room3",
    after = "room3",
    objective = Slot.OBJ_BOMB_BOSS,
    squads = {
        unit(Squad.SQ_ROOM3_ADDS_0, Slot.SQ_ROOM3_ADDS_0),
        unit(Squad.SQ_ROOM3_ADDS_1, Slot.SQ_ROOM3_ADDS_1),
        unit(Squad.SQ_ROOM3_ADDS_2, Slot.SQ_ROOM3_ADDS_2),
        unit(Squad.SQ_ROOM3_ADDS_3, Slot.SQ_ROOM3_ADDS_3),
        unit(Squad.SQ_ROOM3_ADDS_4, Slot.SQ_ROOM3_ADDS_4),
        unit(Squad.SQ_ROOM3_ADDS_5, Slot.SQ_ROOM3_ADDS_5),
        unit(Squad.SQ_ROOM3_ADDS_6, Slot.SQ_ROOM3_ADDS_6),
    },
}

local script = campaign.new{
    omit = {Slot.LIGHTHOUSE_TELEPORT},
    key = "pactmission",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR,
    dialogue_sensor = Slot.M_DIALOG_SENSOR,
    legs = {
        {id = "gateway", state = mission.states.STATE_80F474E3_000F_0000_80F474DE, arm = {
            Slot.PT_NEAR_GATE, Slot.PT_INITIAL_SPAWNS, Slot.PT_ENTER_TUNNEL,
        }},
        {id = "forest", state = mission.states.STATE_80F474E3_0009_0000_80F474D8, arm = {
            Slot.PT_START_FOREST, Slot.PT_BEGIN, Slot.PT_LOAD_POST, Slot.PT_SEE_PORTAL,
            Slot.PT_REACHED_PORTAL, Slot.PT_LEAVING_FOREST,
        }},
        {id = "chase", state = mission.states.STATE_80F474E3_0002_0000_80F474D1, arm = {
            Slot.PT_ENTER_CHASE, Slot.PT_SPARROW_RUN, Slot.PT_SPARROW_JUMP,
        }},
        {id = "bomb", state = mission.states.STATE_80F474E3_0000_0000_80F474CF,
            arm = {Slot.PT_REACHED_BOSS, Slot.PT_SEE_TREE},
            watch = {Slot.PM_LEDGE_FINAL, Slot.PM_ROOM2, Slot.PM_ROOM3}},
    },
    steps = {
        {id = "approach", directive = Directive.APPROACH_THE_INFINITE_FOREST_GATEWAY,
            navpoint = Slot.AP_FOREST_PORTAL_80F55205,
            lines = {line(cue.CUE_0)},
            on_start = function(context)
                move(context, {Slot.D_SHIELD_WALL_80F551DE}, "open")
            end,
            ends = {trigger = {Slot.PT_INITIAL_SPAWNS, Slot.PT_NEAR_GATE}}},
        {id = "landing", directive = Directive.APPROACH_THE_INFINITE_FOREST_GATEWAY,
            navpoint = Slot.AP_FOREST_PORTAL_80F55205,
            ends = {trigger = Slot.PT_NEAR_GATE}},
        {id = "gate", directive = Directive.APPROACH_THE_INFINITE_FOREST_GATEWAY,
            navpoint = Slot.AP_FOREST_PORTAL_80F55205,
            lines = {line(cue.CUE_1)},
            barrier = true, ends = {clear = "rearguard"}},
        {id = "traverse", directive = Directive.TRAVERSE_THE_INFINITE_FOREST,
            navpoint = Slot.AP_FOREST_PORTAL_80F55205,
            on_start = function(context)
                move(context, {Slot.D_SHIELD_WALL_80F551DE}, "close")
                context:activate_objects{slots = {Slot.LIGHTHOUSE_TELEPORT}, active = true}
            end,
            ends = {trigger = Slot.PT_ENTER_TUNNEL, region = "forest"}},
        {id = "forest", directive = Directive.TRAVERSE_THE_INFINITE_FOREST,
            navpoint = Slot.AP_FOREST_PORTAL_80F550C9,
            on_start = function(context)
                move(context, {Slot.D_SHIELD_WALL_80F550B8}, "open")
                context:slot(Slot.MAP_GENERATOR_SENSOR_80F550B8):generate_map{
                    seed = campaign.run_seed(context), enabled = true}
            end,
            ends = {trigger = {Slot.PT_LOAD_POST, Slot.PT_SEE_PORTAL, Slot.PT_REACHED_PORTAL}}},
        {id = "barrier", directive = Directive.DISABLE_THE_BARRIER,
            navpoint = Slot.AP_FOREST_PORTAL_80F550C9,
            barrier = true, ends = {clear = "portal"}},
        {id = "forest_exit", directive = Directive.TRAVERSE_THE_INFINITE_FOREST,
            navpoint = Slot.AP_FOREST_PORTAL_80F550C9,
            on_start = function(context)
                move(context, {Slot.D_SHIELD_WALL_80F550B8}, "close")
            end,
            ends = {trigger = Slot.PT_LEAVING_FOREST, region = "chase"}},
        {id = "hostiles", directive = Directive.ELIMINATE_HOSTILES,
            navpoint = Slot.AP_FIGHT_ROOM,
            ends = {clear = "first_room"}},
        {id = "chase_reinforce", directive = Directive.ELIMINATE_HOSTILES,
            navpoint = Slot.AP_FIGHT_ROOM,
            ends = {clear = "chase_reinforce"}},
        {id = "mount_up", directive = Directive.MOUNT_UP_AND_MOVE_QUICKLY,
            navpoint = Slot.AP_BOSS_ROOM_80F55018,
            lines = {line(cue.CUE_13)},
            ends = {trigger = {Slot.PT_SPARROW_RUN, Slot.PT_SPARROW_JUMP}}},
        {id = "conflict", directive = Directive.FIND_THE_CABAL_LEADER,
            navpoint = Slot.AP_BOSS_ROOM_80F55018,
            ends = {region = "bomb"}},
        {id = "ledge", directive = Directive.FIND_THE_CABAL_LEADER,
            navpoint = Slot.AP_BOSS_ROOM_80F54E12,
            lines = {line(cue.CUE_17)},
            ends = {monitor = Slot.PM_LEDGE_FINAL}},
        {id = "find_map", directive = Directive.FIND_THE_MAP_OF_THE_INFINITE_FOREST,
            navpoint = Slot.AP_BOSS_ROOM_80F54E12,
            lines = {line(cue.CUE_18)},
            ends = {trigger = Slot.PT_REACHED_BOSS}},
        {id = "prefight", directive = Directive.FIND_THE_MAP_OF_THE_INFINITE_FOREST,
            navpoint = Slot.AP_BOSS_ROOM_80F54E12,
            barrier = true, ends = {clear = "prefight"}},
        {id = "reveal", directive = Directive.FIND_THE_MAP_OF_THE_INFINITE_FOREST,
            navpoint = Slot.AP_BOSS_ROOM_80F54E12,
            lines = {line(cue.CUE_20)}, scene = Scene.SCENE_MINOTAUR,
            barrier = true, ends = {scene = Slot.SCENE_MINOTAUR}},
        {id = "minotaur", barrier = true, ends = {clear = "minotaur"}},
        {id = "thuun", directive = Directive.DEFEAT_VALUS_THUUN,
            navpoint = Slot.AP_BOSS_ROOM_80F54E12,
            lines = {line(cue.CUE_21)},
            barrier = true, ends = {}},
        {id = "room1", directive = Directive.DEFEAT_VALUS_THUUN,
            on_start = function(context)
                move(context, {Slot.D_GATE_ROOM1_ENTRY}, "close")
            end,
            barrier = true, ends = {health = {slot = Slot.SQ_BOSS_VAL_THOOUN, at = 2 / 3}}},
        {id = "room1_clear", barrier = true, ends = {clear = "room1"}},
        {id = "enter2", barrier = true,
            on_start = function(context)
                move(context, {Slot.D_GATE_ROOM1_EXIT, Slot.D_GATE_ROOM2_ENTRY}, "close")
            end,
            ends = {monitor = Slot.PM_ROOM2}},
        {id = "room2", directive = Directive.EVADE_VEX_DEFENSES, navpoint = Slot.AP_ROOM2,
            barrier = true, ends = {health = {slot = Slot.SQ_BOSS_VAL_THOOUN, at = 1 / 3}}},
        {id = "room2_clear", barrier = true, ends = {clear = "room2"}},
        {id = "enter3", directive = Directive.DEFEAT_VALUS_THUUN,
            lines = {line(cue.CUE_24)}, barrier = true,
            on_start = function(context)
                move(context, {Slot.D_GATE_ROOM2_EXIT, Slot.D_GATE_ROOM3_ENTRY}, "close")
            end,
            ends = {monitor = Slot.PM_ROOM3}},
        {id = "room3", directive = Directive.DEFEAT_VALUS_THUUN,
            navpoint = Slot.AP_BOSS_ROOM_80F54E12,
            barrier = true, ends = {health = {slot = Slot.SQ_BOSS_VAL_THOOUN, at = 0}}},
        {id = "access", directive = Directive.ACCESS_THE_MAP,
            lines = {line(cue.CUE_27)},
            on_start = function(context)
                move(context, {Slot.D_GATE_ROOM3_EXIT}, "close")
            end,
            barrier = true, ends = {ghost_link = Slot.INTERACT_GHOST_LINK}},
        {id = "scanned", lines = {line(cue.CUE_29)}},
    },
    encounters = {
        intro, vanguard, rearguard, basilisk, portal,
        first_room, chase_reinforce, conflict,
        ledge, prefight, minotaur, boss, room1, room2, room3,
    },
}

local route_lines = {
    [Slot.PT_ENTER_TUNNEL] = cue.CUE_5,
    [Slot.PT_START_FOREST] = cue.CUE_4,
    [Slot.PT_ENTER_CHASE] = cue.CUE_10,
    [Slot.PT_REACHED_BOSS] = cue.CUE_19,
}
local triggered = script.on_event_player_trigger
script.on_event_player_trigger = function(context, state, event)
    local dialogue = event.slot ~= nil and route_lines[event.slot.id] or nil
    if event.kind == EventKind.PLAYER_TRIGGER and dialogue ~= nil then
        local key = "pact.route." .. dialogue
        if state:variable(key) ~= context.attempt_generation then
            context:set_variable(key, context.attempt_generation)
            context:slot(Slot.M_DIALOG_SENSOR):play_dialogue_cue{cue = dialogue}
        end
    end
    triggered(context, state, event)
end

return script
