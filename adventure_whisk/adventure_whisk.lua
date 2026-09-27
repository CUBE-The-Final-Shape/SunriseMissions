-- Deep Storage uses network reports; device modes and charge times remain unverified in game.
-- Absent: enemy plate contesting, plate charge visuals, and lens damage protection.
local missions = require("missions")
local mission = require(missions.ADVENTURE_WHISK)
local campaign = require("lib.campaign")
local lib = require("lib.mission_lib")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive = mission.Slot, mission.Squad, mission.Directive
local cue = mission.DialogueCue.M_DIALOG_SENSOR_80B56AB1

local function key(context, name)
    return "whisk/" .. context.attempt_generation .. "/" .. name
end

local function pose(context, slots, value)
    for _, slot in ipairs(slots) do
        context:slot(slot):set_channel{
            channel = context.sdk.device_channels.position, value = context.sdk.unit(value),
        }
    end
end

-- Charge times are reconstruction values, in milliseconds.
local plates = {
    {name = "entry", monitor = Slot.PF_SYNC_PLATE_PM_VOLUME, duration = 5000},
    {name = "left", monitor = Slot.PF_SYNC_PLATE_LEFT_PM_VOLUME, duration = 10000,
        beam = {Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LASER_LEFT,
            Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LASER_CATCH_LEFT}},
    {name = "right", monitor = Slot.PF_SYNC_PLATE_RIGHT_PM_VOLUME, duration = 10000,
        beam = {Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LASER_RIGHT,
            Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LASER_CATCH_RIGHT}},
}

local function charged(name)
    return function(context, state) return state:variable(key(context, name .. "/charged")) end
end

local function arm_plate(context, state, index)
    context:set_variable(key(context, plates[index].name .. "/armed"), true)
    context:slot(plates[index].monitor):set_occupancy_condition{value = 1}
    if state:variable(key(context, plates[index].name .. "/occupied")) then
        context:set_variable(key(context, plates[index].name .. "/charging"), true)
        context:start_timer(key(context, plates[index].name), plates[index].duration)
    end
end

local function wave_cleared(encounter)
    local squads = {}
    for _, member in ipairs(encounter.squads) do squads[#squads + 1] = member.squad end
    return function(context, state)
        return state:variable(key(context, encounter.id .. "/placed")) == true
            and context:cohort{squads = squads}.cleared
    end
end

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
    },
}

local gate_support = {
    id = "gate_support", after = "warpgate", trigger = Slot.PT_WARPGATE_FALLBACK03,
    objective = Slot.OBJ_WARPGATE,
    squads = {unit(Squad.SQ_WARPGATE_PART3_GOBLIN01, Slot.SQ_WARPGATE_PART3_GOBLIN01)},
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
    after = "plates",
    when = function(context, state)
        return state:variable(key(context, "left/occupied"))
            or state:variable(key(context, "right/occupied"))
    end,
    lines = {line(cue.CUE_12)},
    objective = Slot.OBJ_MAP_ROOM,
    squads = {
        unit(Squad.SQ_MAP_ROOM_FANATIC_SIMMER_CENTER, Slot.SQ_MAP_ROOM_FANATIC_SIMMER_CENTER),
    },
}

local map_left = {
    id = "map_left",
    when = function(context, state) return state:variable(key(context, "left/occupied")) end,
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
    when = function(context, state) return state:variable(key(context, "right/occupied")) end,
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

local map_left2 = {
    id = "map_left2", after = "plates", when = wave_cleared(map_left),
    objective = Slot.OBJ_MAP_ROOM,
    squads = {
        unit(Squad.SQ_MAP_ROOM_FANATIC05, Slot.SQ_MAP_ROOM_FANATIC05),
        unit(Squad.SQ_MAP_ROOM_FANATIC07, Slot.SQ_MAP_ROOM_FANATIC07),
        unit(Squad.SQ_MAP_ROOM_HYDRA01, Slot.SQ_MAP_ROOM_HYDRA01),
        unit(Squad.SQ_MAP_ROOM_HARPY01, Slot.SQ_MAP_ROOM_HARPY01),
        unit(Squad.SQ_MAP_ROOM_MINOTAUR01, Slot.SQ_MAP_ROOM_MINOTAUR01),
    },
}

local map_right2 = {
    id = "map_right2", after = "plates", when = wave_cleared(map_right),
    objective = Slot.OBJ_MAP_ROOM,
    squads = {
        unit(Squad.SQ_MAP_ROOM_FANATIC06, Slot.SQ_MAP_ROOM_FANATIC06),
        unit(Squad.SQ_MAP_ROOM_FANATIC08, Slot.SQ_MAP_ROOM_FANATIC08),
        unit(Squad.SQ_MAP_ROOM_HYDRA02, Slot.SQ_MAP_ROOM_HYDRA02),
        unit(Squad.SQ_MAP_ROOM_HARPY02, Slot.SQ_MAP_ROOM_HARPY02),
        unit(Squad.SQ_MAP_ROOM_MINOTAUR02, Slot.SQ_MAP_ROOM_MINOTAUR02),
    },
}
for _, encounter in ipairs({map_left, map_right}) do
    encounter.on_start = function(context)
        context:set_variable(key(context, encounter.id .. "/placed"), true)
    end
end

local descent_objects = {
    {Slot.O_PYRAMIDION_WHISK_BLOCK04, Slot.O_PYRAMIDION_WHISK_BLOCK04_COV},
    {Slot.O_PYRAMIDION_WHISK_BLOCK05, Slot.O_PYRAMIDION_WHISK_BLOCK05_COV},
    {Slot.O_PYRAMIDION_WHISK_BLOCK06, Slot.O_PYRAMIDION_WHISK_BLOCK06_COV},
}
local reveals = {}
for index, trigger in ipairs({Slot.PT_DESCENT_PLAT03, Slot.PT_DESCENT_PLAT04,
    Slot.PT_DESCENT_PLAT05}) do
    reveals[index] = {id = "platform" .. index, after = "door", trigger = trigger,
        on_start = function(context)
            context:activate_objects{slots = descent_objects[index], active = true}
        end}
end

local script = campaign.new{
    key = "whisk",
    omit = {
        Slot.O_PYRAMIDION_WHISK_BLOCK04, Slot.O_PYRAMIDION_WHISK_BLOCK04_COV,
        Slot.O_PYRAMIDION_WHISK_BLOCK05, Slot.O_PYRAMIDION_WHISK_BLOCK05_COV,
        Slot.O_PYRAMIDION_WHISK_BLOCK06, Slot.O_PYRAMIDION_WHISK_BLOCK06_COV,
        Slot.O_DUSTBOWL_WHISK_CONFLUX, Slot.O_PYRAMIDION_WHISK_MAP_ROOM_CONFLUX,
        Slot.O_DUSTBOWL_WHISK_GHOST_INTERACT, Slot.O_PYRAMIDION_WHISK_GHOST_INTERACT,
        Slot.O_PYRAMIDION_WHISK_MAP_ROOM_PROBABILITY_DOME_HOLOGRAM,
    },
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80B56AB1,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80B56AB1,
    legs = {
        {id = "rupture", state = mission.states.STATE_80B5606D_0004_0000_80B56049,
            arm = {Slot.PT_IO_M_WHISK_THERUPTURE_010_VO, Slot.PT_GO_TO_PYRAMIDIAN_ENDPOINT,
                Slot.PT_IO_M_WHISK_PYRAMIDION_010_VO}},
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
                Slot.PT_GO_TO_FINAL_ROOM_ENDPOINT}},
    },
    steps = {
        -- The Rupture. The vault door is shut and the conflux plate is the way in.
        {id = "briefing", directive = Directive.STEAL_A_MAP_OF_THE_INFINITE_FOREST_B035525A,
            navpoint = Slot.AP_PYRAMIDION_ALTAR,
            lines = {line(cue.CUE_0)},
            on_start = function(context, state)
                move(context, {Slot.D_PYRAMIDION_VAULT_DOOR, Slot.D_DUSTBOWL_WHISK_CONFLUX},
                    "close")
                pose(context, {Slot.SEC2_ENERGY_WALL_DEVICE}, 0.2)
                arm_plate(context, state, 1)
                context:activate_objects{slots = {Slot.PF_SYNC_PLATE_O_ALTAR,
                    Slot.O_DUSTBOWL_WHISK_BLOCK01, Slot.O_DUSTBOWL_WHISK_BLOCK02}, active = true}
            end,
            barrier = true, ends = {await = charged("entry")}},
        -- "That was a trick." The conflux comes up where the plate charged.
        {id = "conflux", directive = Directive.STEAL_A_MAP_OF_THE_INFINITE_FOREST_F8F223A7,
            navpoint = Slot.AP_PYRAMIDION_ALTAR,
            lines = {line(cue.CUE_1), line(cue.CUE_2)},
            on_start = function(context)
                context:activate_objects{slots = {Slot.O_DUSTBOWL_WHISK_CONFLUX}, active = true}
                move(context, {Slot.D_DUSTBOWL_WHISK_CONFLUX}, "open")
                context:slot(Slot.O_DUSTBOWL_WHISK_GHOST_INTERACT)
                    :set_interactable_object{used = true}
            end,
            barrier = true, ends = {ghost_link = Slot.GL_PYRAMIDION_VAULT_DOOR}},
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
                pose(context, {Slot.SEC2_ENERGY_WALL_DEVICE}, 0.2)
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
                pose(context, {Slot.D_PYRAMIDION_WHISK_WARPGATE}, 0.1)
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
                pose(context, {Slot.D_PYRAMIDION_WHISK_BARRIER01}, 0)
            end,
            barrier = true,
            ends = {clear = {"cyclops", "cyclops_guards1", "cyclops_guards2", "cyclops_guards3"}}},
        {id = "barrier_down",
            on_start = function(context)
                pose(context, {Slot.D_PYRAMIDION_WHISK_BARRIER01}, 1)
            end,
            ends = {trigger = Slot.PT_ENTER_FINAL_SPACE_MUSIC}},
        -- "It is dark down here." The pit restricts respawns until the map room is done.
        {id = "pit", lines = {line(cue.CUE_10)},
            ends = {trigger = Slot.PT_GO_TO_FINAL_ROOM_ENDPOINT}},
        -- The map room. Both plates are armed; standing on one starts its side's waves.
        {id = "plates", directive = Directive.ACCESS_THE_MAP,
            navpoint = Slot.AP_GO_TO_FINAL_ROOM_ENDPOINT,
            on_start = function(context, state)
                context:activate_objects{slots = {Slot.PF_SYNC_PLATE_LEFT_O_ALTAR,
                    Slot.PF_SYNC_PLATE_RIGHT_O_ALTAR, Slot.O_PYRAMIDION_WHISK_MAP_ROOM_LENS,
                    Slot.O_PYRAMIDION_WHISK_MAP_ROOM_BLOCK01,
                    Slot.O_PYRAMIDION_WHISK_MAP_ROOM_LASER_CENTER,
                    Slot.O_PYRAMIDION_WHISK_MAP_ROOM_LASER_LEFT,
                    Slot.O_PYRAMIDION_WHISK_MAP_ROOM_LASER_RIGHT}, active = true}
                move(context, {Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LENS,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LASER_LEFT,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LASER_RIGHT,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_COV01,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_COV02,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_COV03,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_COV04}, "open")
                pose(context, {Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LASER_CATCH_LEFT,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LASER_CATCH_RIGHT}, 0.5)
                move(context, {Slot.D_PYRAMIDION_WHISK_MAP_ROOM_LASER_CENTER,
                    Slot.D_PYRAMIDION_WHISK_MAP_ROOM_CONFLUX}, "close")
                arm_plate(context, state, 2)
                arm_plate(context, state, 3)
            end,
            barrier = true,
            ends = {await = function(context, state)
                return charged("left")(context, state) and charged("right")(context, state)
            end}},
        {id = "beams", barrier = true,
            ends = {destroyed = {Slot.O_PYRAMIDION_WHISK_MAP_ROOM_LENS}}},
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
                context:slot(Slot.O_PYRAMIDION_WHISK_GHOST_INTERACT)
                    :set_interactable_object{used = true}
            end,
            barrier = true, ends = {ghost_link = Slot.GL_PYRAMIDION_CONFLUX}},
        -- "The coordinates are missing." The hologram comes up with the answer.
        {id = "coordinates", lines = {line(cue.CUE_13), line(cue.CUE_14)},
            on_start = function(context)
                context:activate_objects{
                    slots = {Slot.O_PYRAMIDION_WHISK_MAP_ROOM_PROBABILITY_DOME_HOLOGRAM},
                    active = true}
                pose(context, {Slot.D_PYRAMIDION_WHISK_MAP_ROOM_PROBABILITY_DOME_HOLOGRAM}, 0.5)
            end},
    },
    encounters = {
        descent, reveals[1], reveals[2], reveals[3],
        warpgate_intro, warpgate_1, warpgate_2, warpgate_3, gate_support, corridor,
        cyclops, cyclops_guards1, cyclops_guards2, cyclops_guards3,
        map_simmer, map_left, map_right, map_left2, map_right2,
    },
}

local entered = script.on_event_trigger_entered
script.on_event_trigger_entered = function(context, state, event)
    if event.attempt_generation ~= context.attempt_generation then return end
    for _, plate in ipairs(plates) do
        if lib.is_slot(context, event, plate.monitor) then
            context:set_variable(key(context, plate.name .. "/occupied"), true)
            if state:variable(key(context, plate.name .. "/armed"))
                and not charged(plate.name)(context, state)
                and not state:variable(key(context, plate.name .. "/charging")) then
                context:set_variable(key(context, plate.name .. "/charging"), true)
                context:start_timer(key(context, plate.name), plate.duration)
            end
        end
    end
    entered(context, state, event)
end
script.on_event_trigger_exited = function(context, state, event)
    if event.attempt_generation ~= context.attempt_generation then return end
    for _, plate in ipairs(plates) do
        if lib.is_slot(context, event, plate.monitor) then
            context:clear_variable(key(context, plate.name .. "/occupied"))
            context:clear_variable(key(context, plate.name .. "/charging"))
            context:cancel_timer(key(context, plate.name))
        end
    end
end
local elapsed = script.on_event_timer_elapsed
script.on_event_timer_elapsed = function(context, state, event)
    if event.attempt_generation ~= context.attempt_generation then return end
    for _, plate in ipairs(plates) do
        if event.timer_name == key(context, plate.name)
            and state:variable(key(context, plate.name .. "/occupied"))
            and state:variable(key(context, plate.name .. "/charging")) then
            context:clear_variable(key(context, plate.name .. "/charging"))
            context:set_variable(key(context, plate.name .. "/charged"), true)
            if plate.beam ~= nil then pose(context, plate.beam, 0) end
        end
    end
    elapsed(context, state, event)
end

return script
