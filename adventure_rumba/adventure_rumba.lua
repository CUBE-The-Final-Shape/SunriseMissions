-- Hijacked. Ported from the Dawn fork's step graph; not tested in game.
-- Four legs: Artifacts Edge (104), the Mists (264), the Nessus surface (296) and the Well of
-- Echoes (320). The Entangled Mind retreats twice, then dies; the processor is carried to the
-- conflux and scanned.
-- Dawn placed this mission's enemies from a client hook and read the Mind's health the same way.
-- Here every placement is an ordinary squad request and the Mind's retreats follow its authored
-- teleport triggers. Not ported: the boss relocation mechanic, which has no server verb.
local missions = require("missions")
local mission = require(missions.ADVENTURE_RUMBA)
local campaign = require("lib.campaign")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive = mission.Slot, mission.Squad, mission.Directive
local cue = mission.DialogueCue.M_DIALOG_SENSOR_80B42ADB

-- The Harpies circling Artifacts Edge before the player moves.
local waiting = {
    id = "waiting",
    objective = Slot.MISTS_OBJECTIVE,
    squads = {
        unit(Squad.MISTS_HARPY01_SQUAD, Slot.MISTS_HARPY01_SQUAD),
        unit(Squad.MISTS_HARPY02_SQUAD, Slot.MISTS_HARPY02_SQUAD),
        unit(Squad.MISTS_HARPY03_SQUAD, Slot.MISTS_HARPY03_SQUAD),
    },
}

local upper_patrol = {
    id = "upper_patrol",
    trigger = Slot.MISTS_FALLBACK01_PLAYER_TRIGGER,
    objective = Slot.MISTS_OBJECTIVE,
    squads = {
        unit(Squad.MISTS_HOBGOBLIN01_SQUAD, Slot.MISTS_HOBGOBLIN01_SQUAD),
        unit(Squad.MISTS_GOBLIN03_SQUAD, Slot.MISTS_GOBLIN03_SQUAD),
    },
}

local patrol = {
    id = "patrol",
    trigger = Slot.PT_WAYPOINT_80B42762,
    objective = Slot.MISTS_OBJECTIVE,
    squads = {
        unit(Squad.MISTS_GOBLIN01_SQUAD, Slot.MISTS_GOBLIN01_SQUAD),
        unit(Squad.MISTS_GOBLIN02_SQUAD, Slot.MISTS_GOBLIN02_SQUAD),
    },
}

local entrance = {
    id = "entrance",
    trigger = Slot.INTRO_PLAYER_TRIGGER,
    objective = Slot.INTRO_OBJECTIVE,
    squads = {
        unit(Squad.INTRO_HARPY01_SQUAD, Slot.INTRO_HARPY01_SQUAD),
        unit(Squad.INTRO_GOBLIN01_SQUAD, Slot.INTRO_GOBLIN01_SQUAD),
    },
}

-- The small arena. Nothing here gates the route.
local small_arena = {
    id = "small_arena",
    trigger = Slot.SML_ARENA_PLAYER_TRIGGER,
    objective = Slot.SML_ARENA_OBJECTIVE,
    squads = {
        unit(Squad.SML_ARENA_HARPY01_SQUAD, Slot.SML_ARENA_HARPY01_SQUAD),
        unit(Squad.SML_ARENA_HARPY02_SQUAD, Slot.SML_ARENA_HARPY02_SQUAD),
        unit(Squad.SML_ARENA_HARPY03_SQUAD, Slot.SML_ARENA_HARPY03_SQUAD),
        unit(Squad.SML_ARENA_GOBLIN01_SQUAD, Slot.SML_ARENA_GOBLIN01_SQUAD),
        unit(Squad.SML_ARENA_GOBLIN02_SQUAD, Slot.SML_ARENA_GOBLIN02_SQUAD),
        unit(Squad.SML_ARENA_EXIT01_SQUAD, Slot.SML_ARENA_EXIT01_SQUAD),
        unit(Squad.SML_ARENA_EXIT02_SQUAD, Slot.SML_ARENA_EXIT02_SQUAD),
    },
}

-- The Entangled Mind and the front half of the large arena.
local mind = {
    id = "mind",
    after = "hunt",
    objective = Slot.HYDRA_OBJECTIVE,
    squads = {
        unit(Squad.HYDRA_HYDRA_SQUAD, Slot.HYDRA_HYDRA_SQUAD),
    },
}

local arena_front = {
    id = "arena_front",
    after = "hunt",
    objective = Slot.LRG_ARENA_OBJECTIVE,
    squads = {
        unit(Squad.LRG_ARENA_FRONT01_SQUAD, Slot.LRG_ARENA_FRONT01_SQUAD),
        unit(Squad.LRG_ARENA_MID01_SQUAD, Slot.LRG_ARENA_MID01_SQUAD),
        unit(Squad.LRG_ARENA_HARPY01_SQUAD, Slot.LRG_ARENA_HARPY01_SQUAD),
    },
}

local arena_back = {
    id = "arena_back",
    trigger = Slot.PT_HYDRA_TELEPORT01,
    after = "hunt",
    objective = Slot.LRG_ARENA_OBJECTIVE,
    squads = {
        unit(Squad.LRG_ARENA_BACK_LEFT01_SQUAD, Slot.LRG_ARENA_BACK_LEFT01_SQUAD),
        unit(Squad.LRG_ARENA_BACK_RIGHT01_SQUAD, Slot.LRG_ARENA_BACK_RIGHT01_SQUAD),
        unit(Squad.LRG_ARENA_BACK_SNIPER_LEFT01_SQUAD, Slot.LRG_ARENA_BACK_SNIPER_LEFT01_SQUAD),
        unit(Squad.LRG_ARENA_BACK_SNIPER_RIGHT01_SQUAD, Slot.LRG_ARENA_BACK_SNIPER_RIGHT01_SQUAD),
        unit(Squad.LRG_ARENA_EXIT01_SQUAD, Slot.LRG_ARENA_EXIT01_SQUAD),
    },
}

local mind_guards = {
    id = "mind_guards",
    trigger = Slot.HYDRA_PLAYER_TRIGGER,
    after = "hunt",
    objective = Slot.HYDRA_OBJECTIVE,
    squads = {
        unit(Squad.HYDRA_GOBLIN01_SQUAD, Slot.HYDRA_GOBLIN01_SQUAD),
        unit(Squad.HYDRA_GOBLIN02_SQUAD, Slot.HYDRA_GOBLIN02_SQUAD),
        unit(Squad.HYDRA_GOBLIN03_SQUAD, Slot.HYDRA_GOBLIN03_SQUAD),
        unit(Squad.HYDRA_MINOTAUR01_SQUAD, Slot.HYDRA_MINOTAUR01_SQUAD),
    },
}

-- The surface fills again on the way back out.
local return_patrols = {
    id = "return_patrols",
    after = "processor",
    objective = Slot.ECHOES_OBJECTIVE,
    squads = {
        unit(Squad.ECHOES_HARPY01_SQUAD, Slot.ECHOES_HARPY01_SQUAD),
        unit(Squad.ECHOES_MINOTAUR01_SQUAD, Slot.ECHOES_MINOTAUR01_SQUAD),
        unit(Squad.ECHOES_HOBGOBLIN02_SQUAD, Slot.ECHOES_HOBGOBLIN02_SQUAD),
    },
}

local echoes_entry = {
    id = "echoes_entry",
    trigger = Slot.ECHOES_INTRO_FALLBACK01_PLAYER_TRIGGER,
    objective = Slot.ECHOES_OBJECTIVE,
    squads = {
        unit(Squad.ECHOES_INTRO_HARPY_SQUAD, Slot.ECHOES_INTRO_HARPY_SQUAD),
        unit(Squad.ECHOES_INTRO_GOBLIN_SQUAD, Slot.ECHOES_INTRO_GOBLIN_SQUAD),
    },
}

local echoes_zone = {
    id = "echoes_zone",
    trigger = Slot.ECHOES_FALLBACK01_PLAYER_TRIGGER,
    objective = Slot.ECHOES_OBJECTIVE,
    squads = {
        unit(Squad.ECHOES_GOBLIN01_SQUAD, Slot.ECHOES_GOBLIN01_SQUAD),
        unit(Squad.ECHOES_MINOTAUR02_SQUAD, Slot.ECHOES_MINOTAUR02_SQUAD),
        unit(Squad.ECHOES_MINOTAUR03_SQUAD, Slot.ECHOES_MINOTAUR03_SQUAD),
        unit(Squad.ECHOES_HARPY02_SQUAD, Slot.ECHOES_HARPY02_SQUAD),
    },
}

local well_entrance = {
    id = "well_entrance",
    after = "well_entrance",
    objective = Slot.OBJ_INTRO,
    squads = {
        unit(Squad.SQ_INTRO_GOBLIN01, Slot.SQ_INTRO_GOBLIN01),
        unit(Squad.SQ_INTRO_FANATIC01, Slot.SQ_INTRO_FANATIC01),
        unit(Squad.SQ_INTRO_HOBGOBLIN01, Slot.SQ_INTRO_HOBGOBLIN01),
    },
}

local well_mid = {
    id = "well_mid",
    trigger = Slot.PT_MID,
    objective = Slot.OBJ_MID,
    squads = {
        unit(Squad.SQ_MID_GOBLIN01, Slot.SQ_MID_GOBLIN01),
        unit(Squad.SQ_MID_GOBLIN02, Slot.SQ_MID_GOBLIN02),
    },
}

local well_floor = {
    id = "well_floor",
    after = "plate",
    objective = Slot.OBJ_FINAL,
    squads = {
        unit(Squad.SQ_FINAL_GOBLIN00, Slot.SQ_FINAL_GOBLIN00),
        unit(Squad.SQ_FINAL_GOBLIN01, Slot.SQ_FINAL_GOBLIN01),
    },
}

local platform_guards = {
    id = "platform_guards",
    after = "climb",
    objective = Slot.OBJ_FINAL,
    squads = {
        unit(Squad.SQ_FINAL_PLAT_GOBLIN01, Slot.SQ_FINAL_PLAT_GOBLIN01),
        unit(Squad.SQ_FINAL_PLAT_GOBLIN02, Slot.SQ_FINAL_PLAT_GOBLIN02),
    },
}

-- The last guard set. The two Harpies never gate the scan.
local conflux_guards = {
    id = "conflux_guards",
    after = "conflux_fight",
    objective = Slot.OBJ_FINAL,
    squads = {
        unit(Squad.SQ_FINAL_MINOTAUR, Slot.SQ_FINAL_MINOTAUR),
        unit(Squad.SQ_FINAL_GOBLIN02, Slot.SQ_FINAL_GOBLIN02),
    },
}

local conflux_harpies = {
    id = "conflux_harpies",
    after = "conflux_fight",
    objective = Slot.OBJ_FINAL,
    squads = {
        unit(Squad.SQ_FINAL_HARPY01, Slot.SQ_FINAL_HARPY01),
        unit(Squad.SQ_FINAL_HARPY02, Slot.SQ_FINAL_HARPY02),
    },
}

return campaign.new{
    key = "rumba",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80B42ADB,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80B42ADB,
    legs = {
        {id = "edge", state = mission.states.STATE_80B4206A_000D_0000_80B42034, arm = {}},
        {id = "mists", state = mission.states.STATE_80B4206A_0021_0000_80B4203A, arm = {
            Slot.INTRO_PLAYER_TRIGGER, Slot.SML_ARENA_PLAYER_TRIGGER,
            Slot.SML_ARENA_FALLBACK01_PLAYER_TRIGGER, Slot.SML_ARENA_FALLBACK02_PLAYER_TRIGGER,
            Slot.LRG_ARENA_PLAYER_TRIGGER, Slot.LRG_ARENA_FALLBACK01_PLAYER_TRIGGER,
            Slot.PT_HYDRA_TELEPORT01, Slot.PT_HYDRA_TELEPORT02, Slot.HYDRA_PLAYER_TRIGGER,
            Slot.PT_ENDPOINT_80B42422,
        }},
        {id = "surface", state = mission.states.STATE_80B4206A_0025_0000_80B4204E, arm = {
            Slot.MISTS_FALLBACK01_PLAYER_TRIGGER, Slot.ECHOES_INTRO_FALLBACK01_PLAYER_TRIGGER,
            Slot.ECHOES_FALLBACK01_PLAYER_TRIGGER, Slot.ECHOES_FALLBACK02_PLAYER_TRIGGER,
            Slot.PT_ENTERING_THE_LAIR_MUSIC, Slot.PT_WAYPOINT_80B42762,
            Slot.PT_ENDPOINT_80B42762, Slot.PT_TELEPORT, Slot.PT_ENDPOINT_80B4252E,
            Slot.PT_NESSUS_M_RUMBA_WELL_OF_ECHOES_010_VO, Slot.PT_ENDPOINT_80B427B1,
        }},
        {id = "well", state = mission.states.STATE_80B4206A_0028_0000_80B42050, arm = {
            Slot.PT_INTRO, Slot.PT_MID, Slot.PT_FINAL_BLOCK01, Slot.PT_FINAL_BLOCK02,
            Slot.PT_FINAL_BLOCK03, Slot.PT_FINAL_BLOCK04, Slot.PT_ENDPOINT_80B42AAA,
            Slot.PT_EXIT_WARPGATE_MUSIC,
        }},
    },
    steps = {
        -- Failsafe sends the Guardian into the Mists after a Vex processor.
        {id = "briefing", directive = Directive.SCAVENGE_A_POWERFUL_PROCESSOR_FROM_THE_VEX,
            navpoint = Slot.AP_ENDPOINT_80B42762,
            lines = {line(cue.CUE_0)},
            ends = {trigger = Slot.MISTS_FALLBACK01_PLAYER_TRIGGER, region = "surface"}},
        -- "It went this way."
        {id = "track", navpoint = Slot.AP_ENDPOINT_80B42762,
            directive = Directive.SCAVENGE_A_POWERFUL_PROCESSOR_FROM_THE_VEX,
            lines = {line(cue.CUE_4)},
            ends = {trigger = {Slot.PT_ENTERING_THE_LAIR_MUSIC, Slot.PT_ENDPOINT_80B42762}}},
        {id = "search", directive = Directive.SCAVENGE_A_POWERFUL_PROCESSOR_FROM_THE_VEX_EBBB3BEC,
            lines = {line(cue.CUE_2)},
            ends = {trigger = Slot.INTRO_PLAYER_TRIGGER, region = "mists"}},
        {id = "small_arena", ends = {trigger = Slot.SML_ARENA_PLAYER_TRIGGER}},
        -- The large arena. The Mind is behind its barrier until it dies.
        {id = "hunt", directive = Directive.SCAVENGE_A_POWERFUL_PROCESSOR_FROM_THE_VEX_AE1FB52D,
            on_start = function(context)
                context:activate_objects{slots = {Slot.O_MISTS_RUMBA_BARRIER01}, active = true}
                move(context, {Slot.D_MISTS_RUMBA_BARRIER01}, "open")
            end,
            ends = {trigger = Slot.LRG_ARENA_PLAYER_TRIGGER}},
        -- "There it is." The Mind retreats twice on its own teleport triggers.
        {id = "identified", lines = {line(cue.CUE_5)},
            ends = {trigger = Slot.PT_HYDRA_TELEPORT01,
                health = {slot = Slot.HYDRA_HYDRA_SQUAD_HYDRA, at = 2 / 3}}},
        {id = "pursuit", lines = {line(cue.CUE_6)},
            ends = {trigger = Slot.PT_HYDRA_TELEPORT02,
                health = {slot = Slot.HYDRA_HYDRA_SQUAD_HYDRA, at = 1 / 3}}},
        {id = "cornered", directive = Directive.DEFEAT_THE_ENTANGLED_MIND,
            barrier = true, ends = {clear = "mind"}},
        -- The barrier drops and the way out opens.
        {id = "processor", directive = Directive.CONNECT_THE_PROCESSOR_TO_THE_VEX_NETWORK,
            navpoint = Slot.AP_ENDPOINT_80B42422,
            lines = {line(cue.CUE_9)},
            on_start = function(context)
                move(context, {Slot.D_MISTS_RUMBA_BARRIER01}, "close")
            end,
            ends = {trigger = Slot.PT_ENDPOINT_80B42422}},
        {id = "returned", navpoint = Slot.AP_TELEPORT,
            directive = Directive.CONNECT_THE_PROCESSOR_TO_THE_VEX_NETWORK,
            ends = {trigger = Slot.PT_TELEPORT, region = "surface"}},
        -- The conflux is lit before the walk to it.
        {id = "route", directive = Directive.CONNECT_THE_PROCESSOR_TO_THE_VEX_NETWORK_D014E2DA,
            navpoint = Slot.AP_ENDPOINT_80B427B1,
            on_start = function(context)
                context:activate_objects{slots = {Slot.O_ECHOES_RUMBA_FINAL_CONFLUX},
                    active = true}
                move(context, {Slot.D_ECHOES_RUMBA_FINAL_CONFLUX}, "open")
            end,
            ends = {trigger = Slot.PT_NESSUS_M_RUMBA_WELL_OF_ECHOES_010_VO}},
        -- "The Well of Echoes."
        {id = "well_approach", lines = {line(cue.CUE_10)},
            navpoint = Slot.AP_ENDPOINT_80B427B1,
            ends = {trigger = Slot.PT_ENDPOINT_80B427B1, region = "well"}},
        {id = "well_entrance",
            directive = Directive.CONNECT_THE_PROCESSOR_TO_THE_VEX_NETWORK_BCFCCB52,
            navpoint = Slot.AP_CONFLUX,
            ends = {trigger = Slot.PT_MID}},
        -- The central plate raises the climb to the conflux.
        {id = "plate", navpoint = Slot.NP_FINAL_BLOCK01,
            on_start = function(context)
                context:activate_objects{slots = {Slot.PF_SYNC_PLATE_CENTRAL_O_ALTAR},
                    active = true}
            end,
            ends = {trigger = Slot.PT_ENDPOINT_80B42AAA}},
        {id = "climb", navpoint = Slot.NP_FINAL_BLOCK01,
            on_start = function(context)
                context:activate_objects{slots = {Slot.O_ECHOES_RUMBA_BLOCK01,
                    Slot.O_ECHOES_RUMBA_BLOCK02, Slot.O_ECHOES_RUMBA_BLOCK02_COV,
                    Slot.O_ECHOES_RUMBA_BLOCK03, Slot.O_ECHOES_RUMBA_BLOCK04,
                    Slot.O_ECHOES_RUMBA_BLOCK04_COV01, Slot.O_ECHOES_RUMBA_BLOCK04_COV02},
                    active = true}
                move(context, {Slot.D_ECHOES_RUMBA_BLOCK01, Slot.D_ECHOES_RUMBA_BLOCK04}, "open")
            end,
            ends = {trigger = {Slot.PT_FINAL_BLOCK01, Slot.PT_FINAL_BLOCK02,
                Slot.PT_FINAL_BLOCK03, Slot.PT_FINAL_BLOCK04}}},
        {id = "conflux_fight", navpoint = Slot.AP_CONFLUX,
            barrier = true, ends = {clear = {"well_floor", "conflux_guards"}}},
        -- The Ghost connects the processor.
        {id = "scan", directive = Directive.CONNECT_THE_PROCESSOR_TO_THE_VEX_NETWORK_EDEDCBB4,
            navpoint = Slot.AP_CONFLUX,
            lines = {line(cue.CUE_11)},
            ends = {ghost_link = Slot.GL_ECHOES_CONFLUX}},
        -- "It failed." The lighthouse image comes up with the answer.
        {id = "failed",
            on_start = function(context)
                context:activate_objects{slots = {Slot.O_ECHOES_RUMBA_FINAL_LIGHTHOUSE},
                    active = true}
                move(context, {Slot.D_ECHOES_RUMBA_FINAL_LIGHTHOUSE}, "open")
            end,
            lines = {line(cue.CUE_12), line(cue.CUE_13)}},
    },
    encounters = {
        waiting, upper_patrol, patrol, entrance, small_arena,
        mind, arena_front, arena_back, mind_guards,
        return_patrols, echoes_entry, echoes_zone,
        well_entrance, well_mid, well_floor, platform_guards,
        conflux_guards, conflux_harpies,
    },
}
