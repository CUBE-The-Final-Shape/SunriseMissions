-- Deep Storage. Ported from the Dawn fork's step graph; not tested in game.
-- Two legs: the Rupture entrance (32) and the Pyramidion (152). The route is the descent, the warp
-- gate, the corridor, the Cyclops, then the map room's two sync plates and its lens.
-- Dawn read the plates and the scans back through a client hook. Here each plate is its authored
-- type-30 volume monitor and each scan is its authored type-65 ghost link, both reported on the
-- wire. Not ported: the lens beam order, which Dawn drove from plate charge receipts.
local missions = require("missions")
local mission = require(missions.ADVENTURE_WHISK)
local campaign = require("lib.campaign")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive = mission.Slot, mission.Squad, mission.Directive
local cue = mission.DialogueCue.M_DIALOG_SENSOR_80B56AB1

-- Every descent platform is published when the vault door opens; the walk down never waits on them.
local descent = {
    id = "descent",
    after = "door",
    objective = Slot.OBJ_DESCENT,
    squads = {
        unit(Squad.SQ_DESCENT_PLAT01_GOBLIN01, Slot.SQ_DESCENT_PLAT01_GOBLIN01),
        unit(Squad.SQ_DESCENT_PLAT01_GOBLIN02, Slot.SQ_DESCENT_PLAT01_GOBLIN02),
        unit(Squad.SQ_DESCENT_PLAT02_FANATIC01, Slot.SQ_DESCENT_PLAT02_FANATIC01),
        unit(Squad.SQ_DESCENT_PLAT02_FANATIC02, Slot.SQ_DESCENT_PLAT02_FANATIC02),
        unit(Squad.SQ_DESCENT_PLAT03_HOBGOBLIN01, Slot.SQ_DESCENT_PLAT03_HOBGOBLIN01),
        unit(Squad.SQ_DESCENT_PLAT03_FANATIC01, Slot.SQ_DESCENT_PLAT03_FANATIC01),
        unit(Squad.SQ_DESCENT_PLAT03_FANATIC02, Slot.SQ_DESCENT_PLAT03_FANATIC02),
        unit(Squad.SQ_DESCENT_PLAT04_HOBGOBLIN01, Slot.SQ_DESCENT_PLAT04_HOBGOBLIN01),
        unit(Squad.SQ_DESCENT_PLAT04_HOBGOBLIN02, Slot.SQ_DESCENT_PLAT04_HOBGOBLIN02),
        unit(Squad.SQ_DESCENT_PLAT04_FANATIC01, Slot.SQ_DESCENT_PLAT04_FANATIC01),
        unit(Squad.SQ_DESCENT_PLAT04_FANATIC02, Slot.SQ_DESCENT_PLAT04_FANATIC02),
        unit(Squad.SQ_DESCENT_PLAT05_HOBGOBLIN01, Slot.SQ_DESCENT_PLAT05_HOBGOBLIN01),
        unit(Squad.SQ_DESCENT_PLAT05_FANATIC01, Slot.SQ_DESCENT_PLAT05_FANATIC01),
        unit(Squad.SQ_DESCENT_PLAT05_FANATIC02, Slot.SQ_DESCENT_PLAT05_FANATIC02),
        unit(Squad.SQ_DESCENT_PLAT06_HOBGOBLIN01, Slot.SQ_DESCENT_PLAT06_HOBGOBLIN01),
        unit(Squad.SQ_DESCENT_PLAT06_HOBGOBLIN02, Slot.SQ_DESCENT_PLAT06_HOBGOBLIN02),
        unit(Squad.SQ_DESCENT_PLAT06_GOBLIN01, Slot.SQ_DESCENT_PLAT06_GOBLIN01),
    },
}

local warpgate_intro = {
    id = "warpgate_intro",
    trigger = Slot.PT_WARPGATE_INTRO,
    objective = Slot.OBJ_WARPGATE_INTRO,
    squads = {
        unit(Squad.SQ_WARPGATE_INTRO_HARPY01, Slot.SQ_WARPGATE_INTRO_HARPY01),
    },
}

local warpgate_1 = {
    id = "warpgate_1",
    after = "warpgate",
    objective = Slot.OBJ_WARPGATE,
    squads = {
        unit(Squad.SQ_WARPGATE_PART1_GOBLIN01, Slot.SQ_WARPGATE_PART1_GOBLIN01),
        unit(Squad.SQ_WARPGATE_PART1_HOBGOBLIN01, Slot.SQ_WARPGATE_PART1_HOBGOBLIN01),
    },
}

local warpgate_2 = {
    id = "warpgate_2",
    trigger = Slot.PT_WARPGATE_FALLBACK02,
    after = "warpgate",
    objective = Slot.OBJ_WARPGATE,
    squads = {
        unit(Squad.SQ_WARPGATE_PART2_MINOTAUR01, Slot.SQ_WARPGATE_PART2_MINOTAUR01),
        unit(Squad.SQ_WARPGATE_PART2_MINOTAUR02, Slot.SQ_WARPGATE_PART2_MINOTAUR02),
        unit(Squad.SQ_WARPGATE_PART2_HARPY01, Slot.SQ_WARPGATE_PART2_HARPY01),
        unit(Squad.SQ_WARPGATE_PART2_HARPY02, Slot.SQ_WARPGATE_PART2_HARPY02),
        unit(Squad.SQ_WARPGATE_PART2_HARPY03, Slot.SQ_WARPGATE_PART2_HARPY03),
        unit(Squad.SQ_WARPGATE_PART2_HARPY04, Slot.SQ_WARPGATE_PART2_HARPY04),
    },
}

-- The Hydra holds the gate. Nothing else has to die for it to open.
local warpgate_3 = {
    id = "warpgate_3",
    trigger = Slot.PT_WARPGATE_FALLBACK03,
    after = "warpgate",
    objective = Slot.OBJ_WARPGATE,
    squads = {
        unit(Squad.SQ_WARPGATE_PART3_HYDRA, Slot.SQ_WARPGATE_PART3_HYDRA),
        unit(Squad.SQ_WARPGATE_PART3_GOBLIN01, Slot.SQ_WARPGATE_PART3_GOBLIN01),
    },
}

local corridor = {
    id = "corridor",
    trigger = Slot.PT_CORRIDOR,
    objective = Slot.OBJ_CORRIDOR,
    squads = {
        unit(Squad.SQ_CORRIDOR_HOBGOBLIN01, Slot.SQ_CORRIDOR_HOBGOBLIN01),
        unit(Squad.SQ_CORRIDOR_HOBGOBLIN02, Slot.SQ_CORRIDOR_HOBGOBLIN02),
        unit(Squad.SQ_CORRIDOR_HARPY01, Slot.SQ_CORRIDOR_HARPY01),
        unit(Squad.SQ_CORRIDOR_GOBLIN01, Slot.SQ_CORRIDOR_GOBLIN01),
    },
}

local cyclops = {
    id = "cyclops",
    after = "barrier",
    objective = Slot.OBJ_CYCLOPS,
    squads = {
        unit(Squad.SQ_CYCLOPS_CYCLOPS, Slot.SQ_CYCLOPS_CYCLOPS),
    },
}

local cyclops_guards1 = {
    id = "cyclops_guards1",
    after = "barrier",
    objective = Slot.OBJ_CYCLOPS,
    squads = {
        unit(Squad.SQ_CYCLOPS_GOBLIN01, Slot.SQ_CYCLOPS_GOBLIN01),
        unit(Squad.SQ_CYCLOPS_GOBLIN04, Slot.SQ_CYCLOPS_GOBLIN04),
        unit(Squad.SQ_CYCLOPS_GOBLIN05, Slot.SQ_CYCLOPS_GOBLIN05),
        unit(Squad.SQ_CYCLOPS_BACK_HOBGOBLIN01, Slot.SQ_CYCLOPS_BACK_HOBGOBLIN01),
        unit(Squad.SQ_CYCLOPS_BACK_HOBGOBLIN04, Slot.SQ_CYCLOPS_BACK_HOBGOBLIN04),
        unit(Squad.SQ_CYCLOPS_BACK_HOBGOBLIN05, Slot.SQ_CYCLOPS_BACK_HOBGOBLIN05),
    },
}

local cyclops_guards2 = {
    id = "cyclops_guards2",
    trigger = Slot.PT_CYCLOPS_FALLBACK01,
    after = "barrier",
    objective = Slot.OBJ_CYCLOPS,
    squads = {
        unit(Squad.SQ_CYCLOPS_GOBLIN02, Slot.SQ_CYCLOPS_GOBLIN02),
        unit(Squad.SQ_CYCLOPS_GOBLIN03, Slot.SQ_CYCLOPS_GOBLIN03),
        unit(Squad.SQ_CYCLOPS_GOBLIN06, Slot.SQ_CYCLOPS_GOBLIN06),
        unit(Squad.SQ_CYCLOPS_BACK_HOBGOBLIN02, Slot.SQ_CYCLOPS_BACK_HOBGOBLIN02),
        unit(Squad.SQ_CYCLOPS_BACK_HOBGOBLIN03, Slot.SQ_CYCLOPS_BACK_HOBGOBLIN03),
        unit(Squad.SQ_CYCLOPS_BACK_HOBGOBLIN06, Slot.SQ_CYCLOPS_BACK_HOBGOBLIN06),
    },
}

local cyclops_guards3 = {
    id = "cyclops_guards3",
    trigger = Slot.PT_CYCLOPS_FALLBACK02,
    after = "barrier",
    objective = Slot.OBJ_CYCLOPS,
    squads = {
        unit(Squad.SQ_CYCLOPS_HOBGOBLIN01, Slot.SQ_CYCLOPS_HOBGOBLIN01),
        unit(Squad.SQ_CYCLOPS_HOBGOBLIN02, Slot.SQ_CYCLOPS_HOBGOBLIN02),
        unit(Squad.SQ_CYCLOPS_MINOTAUR01, Slot.SQ_CYCLOPS_MINOTAUR01),
        unit(Squad.SQ_CYCLOPS_MINOTAUR02, Slot.SQ_CYCLOPS_MINOTAUR02),
        unit(Squad.SQ_CYCLOPS_MINOTAUR03, Slot.SQ_CYCLOPS_MINOTAUR03),
        unit(Squad.SQ_CYCLOPS_HARPY01, Slot.SQ_CYCLOPS_HARPY01),
    },
}

-- The first Fanatic walks in as soon as a plate is stood on.
local map_simmer = {
    id = "map_simmer",
    monitor = Slot.PF_SYNC_PLATE_LEFT_PM_VOLUME,
    after = "plates",
    objective = Slot.OBJ_MAP_ROOM,
    squads = {
        unit(Squad.SQ_MAP_ROOM_FANATIC_SIMMER_CENTER, Slot.SQ_MAP_ROOM_FANATIC_SIMMER_CENTER),
    },
}

local map_left = {
    id = "map_left",
    monitor = Slot.PF_SYNC_PLATE_LEFT_PM_VOLUME,
    after = "plates",
    objective = Slot.OBJ_MAP_ROOM,
    squads = {
        unit(Squad.SQ_MAP_ROOM_FANATIC_SIMMER_LEFT, Slot.SQ_MAP_ROOM_FANATIC_SIMMER_LEFT),
        unit(Squad.SQ_MAP_ROOM_FANATIC01_STARTER, Slot.SQ_MAP_ROOM_FANATIC01_STARTER),
        unit(Squad.SQ_MAP_ROOM_FANATIC01, Slot.SQ_MAP_ROOM_FANATIC01),
        unit(Squad.SQ_MAP_ROOM_FANATIC03_STARTER, Slot.SQ_MAP_ROOM_FANATIC03_STARTER),
        unit(Squad.SQ_MAP_ROOM_FANATIC03, Slot.SQ_MAP_ROOM_FANATIC03),
    },
}

local map_right = {
    id = "map_right",
    monitor = Slot.PF_SYNC_PLATE_RIGHT_PM_VOLUME,
    after = "plates",
    objective = Slot.OBJ_MAP_ROOM,
    squads = {
        unit(Squad.SQ_MAP_ROOM_FANATIC_SIMMER_RIGHT, Slot.SQ_MAP_ROOM_FANATIC_SIMMER_RIGHT),
        unit(Squad.SQ_MAP_ROOM_FANATIC02_STARTER, Slot.SQ_MAP_ROOM_FANATIC02_STARTER),
        unit(Squad.SQ_MAP_ROOM_FANATIC02, Slot.SQ_MAP_ROOM_FANATIC02),
        unit(Squad.SQ_MAP_ROOM_FANATIC04_STARTER, Slot.SQ_MAP_ROOM_FANATIC04_STARTER),
        unit(Squad.SQ_MAP_ROOM_FANATIC04, Slot.SQ_MAP_ROOM_FANATIC04),
    },
}

local map_wave2 = {
    id = "map_wave2",
    after = "map_fight",
    objective = Slot.OBJ_MAP_ROOM,
    squads = {
        unit(Squad.SQ_MAP_ROOM_FANATIC05, Slot.SQ_MAP_ROOM_FANATIC05),
        unit(Squad.SQ_MAP_ROOM_FANATIC06, Slot.SQ_MAP_ROOM_FANATIC06),
        unit(Squad.SQ_MAP_ROOM_FANATIC07, Slot.SQ_MAP_ROOM_FANATIC07),
        unit(Squad.SQ_MAP_ROOM_FANATIC08, Slot.SQ_MAP_ROOM_FANATIC08),
        unit(Squad.SQ_MAP_ROOM_HYDRA01, Slot.SQ_MAP_ROOM_HYDRA01),
        unit(Squad.SQ_MAP_ROOM_HYDRA02, Slot.SQ_MAP_ROOM_HYDRA02),
        unit(Squad.SQ_MAP_ROOM_HARPY01, Slot.SQ_MAP_ROOM_HARPY01),
        unit(Squad.SQ_MAP_ROOM_HARPY02, Slot.SQ_MAP_ROOM_HARPY02),
        unit(Squad.SQ_MAP_ROOM_MINOTAUR01, Slot.SQ_MAP_ROOM_MINOTAUR01),
        unit(Squad.SQ_MAP_ROOM_MINOTAUR02, Slot.SQ_MAP_ROOM_MINOTAUR02),
    },
}

return campaign.new{
    key = "whisk",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80B56AB1,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80B56AB1,
    legs = {
        {id = "rupture", state = mission.states.STATE_80B5606D_0004_0000_80B56049,
            arm = {Slot.PT_IO_M_WHISK_THERUPTURE_010_VO, Slot.PT_GO_TO_PYRAMIDIAN_ENDPOINT,
                Slot.PT_IO_M_WHISK_PYRAMIDION_010_VO},
            watch = {Slot.PF_SYNC_PLATE_PM_VOLUME}},
        {id = "pyramidion", state = mission.states.STATE_80B5606D_0013_0000_80B5606C,
            arm = {Slot.PT_DESCENT, Slot.PT_DESCENT_PLAT01, Slot.PT_DESCENT_PLAT02,
                Slot.PT_DESCENT_PLAT03, Slot.PT_DESCENT_PLAT04, Slot.PT_DESCENT_PLAT05,
                Slot.PT_DESCENT_PLAT06, Slot.PT_DESCENT_REVEAL_MUSIC,
                Slot.PT_DOORWAY_AT_BOTTOM_MUSIC, Slot.PT_ENDPOINT,
                Slot.PT_WARPGATE_INTRO, Slot.PT_WARPGATE_INTRO_FALLBACK01, Slot.PT_WARPGATE,
                Slot.PT_WARPGATE_FALLBACK01, Slot.PT_WARPGATE_FALLBACK02,
                Slot.PT_WARPGATE_FALLBACK025, Slot.PT_WARPGATE_FALLBACK03,
                Slot.PT_GO_TO_FIRST_TELEPORTER_ENDPOINT, Slot.PT_CORRIDOR,
                Slot.PT_GO_TO_SECOND_TELEPORTER_ENDPOINT, Slot.PT_CYCLOPS,
                Slot.PT_CYCLOPS_FALLBACK01, Slot.PT_CYCLOPS_FALLBACK02,
                Slot.PT_CYCLOPS_BARRIER01, Slot.PT_ENTER_FINAL_SPACE_MUSIC,
                Slot.PT_GO_TO_FINAL_ROOM_ENDPOINT},
            watch = {Slot.PF_SYNC_PLATE_LEFT_PM_VOLUME, Slot.PF_SYNC_PLATE_RIGHT_PM_VOLUME}},
    },
    steps = {
        -- The Rupture. The vault door is shut and the conflux plate is the way in.
        {id = "briefing", directive = Directive.STEAL_A_MAP_OF_THE_INFINITE_FOREST_B035525A,
            navpoint = Slot.AP_PYRAMIDION_ALTAR,
            lines = {line(cue.CUE_0)},
            on_start = function(context)
                move(context, {Slot.D_PYRAMIDION_VAULT_DOOR, Slot.D_DUSTBOWL_WHISK_CONFLUX,
                    Slot.SEC2_ENERGY_WALL_DEVICE}, "close")
                context:activate_objects{slots = {Slot.PF_SYNC_PLATE_O_ALTAR,
                    Slot.O_DUSTBOWL_WHISK_BLOCK01, Slot.O_DUSTBOWL_WHISK_BLOCK02}, active = true}
            end,
            ends = {monitor = Slot.PF_SYNC_PLATE_PM_VOLUME}},
        -- "That was a trick." The conflux comes up where the plate charged.
        {id = "conflux", directive = Directive.STEAL_A_MAP_OF_THE_INFINITE_FOREST_F8F223A7,
            navpoint = Slot.AP_PYRAMIDION_ALTAR,
            lines = {line(cue.CUE_1), line(cue.CUE_2)},
            on_start = function(context)
                context:activate_objects{slots = {Slot.O_DUSTBOWL_WHISK_CONFLUX}, active = true}
                move(context, {Slot.D_DUSTBOWL_WHISK_CONFLUX}, "open")
            end,
            ends = {ghost_link = Slot.GL_PYRAMIDION_VAULT_DOOR}},
        -- The vault door opens and the whole descent is published behind it.
        {id = "door", directive = Directive.STEAL_A_MAP_OF_THE_INFINITE_FOREST,
            lines = {line(cue.CUE_3)},
            on_start = function(context)
                move(context, {Slot.D_PYRAMIDION_VAULT_DOOR}, "open")
            end,
            ends = {trigger = Slot.PT_IO_M_WHISK_PYRAMIDION_010_VO, region = "pyramidion"}},
        -- The descent. The energy wall at the bottom is down from the start.
        {id = "descend", directive = Directive.STEAL_A_MAP_OF_THE_INFINITE_FOREST_772F4471,
            lines = {line(cue.CUE_4)},
            on_start = function(context)
                move(context, {Slot.SEC2_ENERGY_WALL_DEVICE}, "close")
            end,
            ends = {trigger = {Slot.PT_DESCENT_PLAT06, Slot.PT_DOORWAY_AT_BOTTOM_MUSIC}}},
        {id = "hallway", lines = {line(cue.CUE_5)},
            ends = {trigger = Slot.PT_WARPGATE_INTRO}},
        -- The warp gate arena. The gate is shut and its barrier is up until the Hydra falls.
        {id = "warpgate", directive = Directive.FIND_AN_ACCESS_POINT_TO_VIEW_THE_MAP_7811B582,
            navpoint = Slot.AP_GO_TO_FIRST_TELEPORTER_ENDPOINT,
            lines = {line(cue.CUE_6)},
            on_start = function(context)
                move(context, {Slot.D_PYRAMIDION_WHISK_WARPGATE}, "close")
                move(context, {Slot.D_PYRAMIDION_WHISK_WARPGATE_BARRIER}, "open")
            end,
            barrier = true, ends = {clear = "warpgate_3"}},
        {id = "gate_open", lines = {line(cue.CUE_7)},
            on_start = function(context)
                move(context, {Slot.D_PYRAMIDION_WHISK_WARPGATE}, "open")
                move(context, {Slot.D_PYRAMIDION_WHISK_WARPGATE_BARRIER}, "close")
            end,
            ends = {trigger = Slot.PT_GO_TO_FIRST_TELEPORTER_ENDPOINT}},
        -- The corridor between the two teleporters, with its laser traps.
        {id = "corridor", directive = Directive.FIND_AN_ACCESS_POINT_TO_VIEW_THE_MAP,
            navpoint = Slot.AP_GO_TO_SECOND_TELEPORTER_ENDPOINT,
            lines = {line(cue.CUE_9)},
            on_start = function(context)
                context:activate_objects{slots = {Slot.O_PYRAMIDION_WHISK_LASERTRAP01,
                    Slot.O_PYRAMIDION_WHISK_LASERTRAP02, Slot.O_PYRAMIDION_WHISK_LASERTRAP03,
                    Slot.O_PYRAMIDION_WHISK_LASERTRAP04}, active = true}
            end,
            ends = {trigger = Slot.PT_GO_TO_SECOND_TELEPORTER_ENDPOINT}},
        -- The Cyclops guards the pit. Its barrier holds until the room is clear.
        {id = "barrier", directive = Directive.FIND_AN_ACCESS_POINT_TO_VIEW_THE_MAP_2A751789,
            on_start = function(context)
                context:activate_objects{slots = {Slot.O_PYRAMIDION_WHISK_BARRIER01},
                    active = true}
                move(context, {Slot.D_PYRAMIDION_WHISK_BARRIER01}, "open")
            end,
            barrier = true,
            ends = {clear = {"cyclops", "cyclops_guards1", "cyclops_guards2", "cyclops_guards3"}}},
        {id = "barrier_down",
            on_start = function(context)
                move(context, {Slot.D_PYRAMIDION_WHISK_BARRIER01}, "close")
            end,
            ends = {trigger = Slot.PT_ENTER_FINAL_SPACE_MUSIC}},
        -- "It is dark down here." The pit restricts respawns until the map room is done.
        {id = "pit", lines = {line(cue.CUE_10)},
            ends = {trigger = Slot.PT_GO_TO_FINAL_ROOM_ENDPOINT}},
        -- The map room. Both plates are armed; standing on one starts its side's waves.
        {id = "plates", directive = Directive.ACCESS_THE_MAP,
            navpoint = Slot.AP_GO_TO_FINAL_ROOM_ENDPOINT,
            on_start = function(context)
                context:activate_objects{slots = {Slot.PF_SYNC_PLATE_LEFT_O_ALTAR,
                    Slot.PF_SYNC_PLATE_RIGHT_O_ALTAR, Slot.O_PYRAMIDION_WHISK_MAP_ROOM_LENS,
                    Slot.O_PYRAMIDION_WHISK_MAP_ROOM_BLOCK01,
                    Slot.O_PYRAMIDION_WHISK_MAP_ROOM_LASER_CENTER,
                    Slot.O_PYRAMIDION_WHISK_MAP_ROOM_LASER_LEFT,
                    Slot.O_PYRAMIDION_WHISK_MAP_ROOM_LASER_RIGHT}, active = true}
                move(context, {Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LENS,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LASER_LEFT,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LASER_RIGHT,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LASER_CATCH_LEFT,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LASER_CATCH_RIGHT,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_COV01,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_COV02,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_COV03,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_COV04}, "open")
                move(context, {Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LASER_CENTER,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_CONFLUX}, "close")
            end,
            barrier = true,
            ends = {monitor = {Slot.PF_SYNC_PLATE_LEFT_PM_VOLUME,
                Slot.PF_SYNC_PLATE_RIGHT_PM_VOLUME}}},
        -- "Incoming." Both sides fight while the beams charge.
        {id = "map_fight", lines = {line(cue.CUE_12)},
            barrier = true, ends = {clear = {"map_left", "map_right"}}},
        -- Both beams reach the lens and it breaks.
        {id = "beams",
            on_start = function(context)
                move(context, {Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LASER_LEFT,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LASER_CATCH_LEFT,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LASER_RIGHT,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LASER_CATCH_RIGHT}, "close")
            end,
            barrier = true, ends = {destroyed = {Slot.O_PYRAMIDION_WHISK_MAP_ROOM_LENS}}},
        -- The conflux is uncovered and the Ghost reads it.
        {id = "conflux_open", directive = Directive.ACCESS_THE_MAP_CB573BE1,
            lines = {line(cue.CUE_11)},
            on_start = function(context)
                move(context, {Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LENS,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LASER_CENTER,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_COV01,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_COV02,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_COV03,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_COV04}, "close")
                context:activate_objects{slots = {Slot.O_PYRAMIDION_WHISK_MAP_ROOM_CONFLUX},
                    active = true}
                move(context, {Slot.D_PYRAMIDION_WHISK_MAP_ROOM_CONFLUX}, "open")
            end,
            ends = {ghost_link = Slot.GL_PYRAMIDION_CONFLUX}},
        -- "The coordinates are missing." The hologram comes up with the answer.
        {id = "coordinates", lines = {line(cue.CUE_13), line(cue.CUE_14)},
            on_start = function(context)
                context:activate_objects{
                    slots = {Slot.O_PYRAMIDION_WHISK_MAP_ROOM_PROBABILITY_DOME_HOLOGRAM},
                    active = true}
                move(context, {Slot.D_PYRAMIDION_WHISK_MAP_ROOM_PROBABILITY_DOME_HOLOGRAM}, "open")
            end},
    },
    encounters = {
        descent, warpgate_intro, warpgate_1, warpgate_2, warpgate_3, corridor,
        cyclops, cyclops_guards1, cyclops_guards2, cyclops_guards3,
        map_simmer, map_left, map_right, map_wave2,
    },
}
