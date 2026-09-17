-- Spark. Red War campaign draft; not tested in game.
-- Steps follow the step objects, their lines and the trigger volume positions: the wall gap, the
-- cave, the building, the forest, then the well of Light and the fight at the Shard.
local missions = require("missions")
local mission = require(missions.MISSION_RISE)
local campaign = require("lib.campaign")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive = mission.Slot, mission.Squad, mission.Directive
local cue = mission.DialogueCue.M_DIALOG_SENSOR_80B5E7CC

local cave = {
    id = "cave",
    trigger = Slot.PT_CAVE_FALLEN_SPAWNER,
    objective = Slot.OBJ_CAVE,
    squads = {
        unit(Squad.SQ_RISE_CAVE_REVEAL, Slot.SQ_RISE_CAVE_REVEAL),
        unit(Squad.SQ_RISE_CAVE_MARAUDERS_5, Slot.SQ_RISE_CAVE_MARAUDERS_5),
        unit(Squad.SQ_RISE_CAVE_ULTRA_1, Slot.SQ_RISE_CAVE_ULTRA_1),
        unit(Squad.SQ_RISE_CAVE_MARAUDER_SCENE, Slot.SQ_RISE_CAVE_MARAUDER_SCENE),
        unit(Squad.SQ_MARAUDER_CRAWLING_1, Slot.SQ_MARAUDER_CRAWLING_1),
        unit(Squad.SQ_MARAUDER_CRAWLING_2, Slot.SQ_MARAUDER_CRAWLING_2),
        unit(Squad.SQ_MARAUDER_CRAWLING_3, Slot.SQ_MARAUDER_CRAWLING_3),
    },
}

-- The Fallen seen past the cave, on the way to the building.
local building = {
    id = "building",
    trigger = Slot.PT_MOVE_FALLEN_BUILDING_TEASE,
    squads = {unit(Squad.SQ_RISE_CAVE_REVEAL_BUILDING, Slot.SQ_RISE_CAVE_REVEAL_BUILDING)},
}

-- The forest groups carry no encounter objective.
local shadow = {
    id = "shadow",
    trigger = Slot.PT_DIALOG_RISE_SHADOW_1,
    squads = {
        unit(Squad.SQ_RISE_SHADOW_SLAG_ANNOUNCE, Slot.SQ_RISE_SHADOW_SLAG_ANNOUNCE),
        unit(Squad.SQ_RISE_SHADOW_REAR_HARVESTER, Slot.SQ_RISE_SHADOW_REAR_HARVESTER),
        unit(Squad.SQ_RISE_SHADOW_REINFORCE_LEFT_1, Slot.SQ_RISE_SHADOW_REINFORCE_LEFT_1),
        unit(Squad.SQ_RISE_SHADOW_REINFORCE_LEFT_2, Slot.SQ_RISE_SHADOW_REINFORCE_LEFT_2),
        unit(Squad.SQ_RISE_SHADOW_REINFORCE_LEFT_3, Slot.SQ_RISE_SHADOW_REINFORCE_LEFT_3),
        unit(Squad.SQ_RISE_SHADOW_ANNOUNCE_MELEE_1, Slot.SQ_RISE_SHADOW_ANNOUNCE_MELEE_1),
        unit(Squad.SQ_RISE_SHADOW_ANNOUNCE_MELEE_2, Slot.SQ_RISE_SHADOW_ANNOUNCE_MELEE_2),
        unit(Squad.SQ_RISE_SHADOW_REINFORCE_RIGHT_1C, Slot.SQ_RISE_SHADOW_REINFORCE_RIGHT_1C),
        unit(Squad.SQ_RISE_SHADOW_REINFORCE_MELEE_1, Slot.SQ_RISE_SHADOW_REINFORCE_MELEE_1),
        unit(Squad.SQ_RISE_SHADOW_MARAUDER_1, Slot.SQ_RISE_SHADOW_MARAUDER_1),
        unit(Squad.SQ_RISE_SHADOW_MARAUDER_2, Slot.SQ_RISE_SHADOW_MARAUDER_2),
        unit(Squad.SQ_RISE_SHADOW_MARAUDER_3, Slot.SQ_RISE_SHADOW_MARAUDER_3),
        unit(Squad.SQ_RISE_SHADOW_MARAUDER_5, Slot.SQ_RISE_SHADOW_MARAUDER_5),
        unit(Squad.SQ_RISE_SHADOW_MARAUDER_8, Slot.SQ_RISE_SHADOW_MARAUDER_8),
    },
}

local harvester = {
    id = "harvester",
    trigger = Slot.PT_SPAWN_HARVESTER_ENCOUNTER,
    objective = Slot.OBJ_SHADOW_HARVESTER_DREGS,
    squads = {
        unit(Squad.SQ_HARVESTER_DREGS_1, Slot.SQ_HARVESTER_DREGS_1),
        unit(Squad.SQ_HARVESTER_DREGS_2, Slot.SQ_HARVESTER_DREGS_2),
        unit(Squad.SQ_HARVESTER_DREGS_3, Slot.SQ_HARVESTER_DREGS_3),
        unit(Squad.SQ_HARVESTER_DREGS_4_1, Slot.SQ_HARVESTER_DREGS_4_1),
        unit(Squad.SQ_HARVESTER_DREGS_4_2, Slot.SQ_HARVESTER_DREGS_4_2),
        unit(Squad.SQ_HARVESTER_DREGS_6, Slot.SQ_HARVESTER_DREGS_6),
        unit(Squad.SQ_HARVESTER_DREGS_7, Slot.SQ_HARVESTER_DREGS_7),
        unit(Squad.SQ_HARVESTER_DREGS_8, Slot.SQ_HARVESTER_DREGS_8),
        unit(Squad.SQ_HARVESTER_DREGS_9, Slot.SQ_HARVESTER_DREGS_9),
        unit(Squad.SQ_HARVESTER_DREGS_10_1, Slot.SQ_HARVESTER_DREGS_10_1),
        unit(Squad.SQ_HARVESTER_DREGS_10_2, Slot.SQ_HARVESTER_DREGS_10_2),
        unit(Squad.SQ_HARVESTER_DREGS_11, Slot.SQ_HARVESTER_DREGS_11),
        unit(Squad.SQ_HARVESTER_DREGS_12, Slot.SQ_HARVESTER_DREGS_12),
        unit(Squad.SQ_HARVESTER_DREGS_13, Slot.SQ_HARVESTER_DREGS_13),
        unit(Squad.SQ_HARVESTER_DREGS_14, Slot.SQ_HARVESTER_DREGS_14),
    },
}

local captain = {
    id = "captain",
    trigger = Slot.PT_SPAWN_HARVESTER_CAPTAIN,
    squads = {
        unit(Squad.SQ_RISE_CAPTAIN, Slot.SQ_RISE_CAPTAIN),
        unit(Squad.SQ_CAPTAIN_ADDS_1, Slot.SQ_CAPTAIN_ADDS_1),
        unit(Squad.SQ_CAPTAIN_ADDS_2, Slot.SQ_CAPTAIN_ADDS_2),
        unit(Squad.SQ_CAPTAIN_ADDS_3, Slot.SQ_CAPTAIN_ADDS_3),
        unit(Squad.SQ_CAPTAIN_ADDS_4, Slot.SQ_CAPTAIN_ADDS_4),
    },
}

local path = {
    id = "path",
    trigger = Slot.PT_SPAWN_PATH_MIDPOINT,
    squads = {
        unit(Squad.SQ_RISE_SHADOW_PATH_MIDPOINT, Slot.SQ_RISE_SHADOW_PATH_MIDPOINT),
        unit(Squad.SQ_RISE_SHADOW_PATH_MIDPOINT_1, Slot.SQ_RISE_SHADOW_PATH_MIDPOINT_1),
        unit(Squad.SQ_RISE_SHADOW_PATH_MIDPOINT_MELEE,
             Slot.SQ_RISE_SHADOW_PATH_MIDPOINT_MELEE),
        unit(Squad.SQ_RISE_SHADOW_PATH_MIDPOINT_BACKUP,
             Slot.SQ_RISE_SHADOW_PATH_MIDPOINT_BACKUP),
        unit(Squad.SQ_RISE_SHADOW_PATH_MIDPOINT_BACKUP_2,
             Slot.SQ_RISE_SHADOW_PATH_MIDPOINT_BACKUP_2),
        unit(Squad.SQ_RISE_SHADOW_PATH_MIDPOINT_BACKUP_3,
             Slot.SQ_RISE_SHADOW_PATH_MIDPOINT_BACKUP_3),
        unit(Squad.SQ_RISE_SHADOW_PATH_MIDPOINT_BACKUP_4,
             Slot.SQ_RISE_SHADOW_PATH_MIDPOINT_BACKUP_4),
        unit(Squad.SQ_RISE_SHADOW_PATH_MIDPOINT_BACKUP_5,
             Slot.SQ_RISE_SHADOW_PATH_MIDPOINT_BACKUP_5),
        unit(Squad.SQ_RISE_SHADOW_PATH_MIDPOINT_BACKUP_6,
             Slot.SQ_RISE_SHADOW_PATH_MIDPOINT_BACKUP_6),
    },
}

-- The super fight has no encounter objective; it starts with the Light.
local super_fight = {
    id = "super_fight",
    after = "light",
    squads = {
        unit(Squad.SQ_LEFT_RUSH_A, Slot.SQ_LEFT_RUSH_A),
        unit(Squad.SQ_LEFT_RUSH_A_2, Slot.SQ_LEFT_RUSH_A_2),
        unit(Squad.SQ_LEFT_RUSH_A_3, Slot.SQ_LEFT_RUSH_A_3),
        unit(Squad.SQ_LEFT_RUSH_B, Slot.SQ_LEFT_RUSH_B),
        unit(Squad.SQ_LEFT_RUSH_B_2, Slot.SQ_LEFT_RUSH_B_2),
        unit(Squad.SQ_LEFT_RUSH_B_3, Slot.SQ_LEFT_RUSH_B_3),
        unit(Squad.SQ_CENTER_RUSH_A, Slot.SQ_CENTER_RUSH_A),
        unit(Squad.SQ_CENTER_RUSH_A_2, Slot.SQ_CENTER_RUSH_A_2),
        unit(Squad.SQ_CENTER_RUSH_A_3, Slot.SQ_CENTER_RUSH_A_3),
        unit(Squad.SQ_CENTER_RUSH_B, Slot.SQ_CENTER_RUSH_B),
        unit(Squad.SQ_CENTER_RUSH_B_2, Slot.SQ_CENTER_RUSH_B_2),
        unit(Squad.SQ_CENTER_RUSH_B_3, Slot.SQ_CENTER_RUSH_B_3),
        unit(Squad.SQ_CENTER_RUSH_C, Slot.SQ_CENTER_RUSH_C),
        unit(Squad.SQ_CENTER_RUSH_C_2, Slot.SQ_CENTER_RUSH_C_2),
        unit(Squad.SQ_CENTER_RUSH_C_3, Slot.SQ_CENTER_RUSH_C_3),
        unit(Squad.SQ_RIGHT_RUSH_A, Slot.SQ_RIGHT_RUSH_A),
        unit(Squad.SQ_RIGHT_RUSH_A_2, Slot.SQ_RIGHT_RUSH_A_2),
        unit(Squad.SQ_RIGHT_RUSH_A_3, Slot.SQ_RIGHT_RUSH_A_3),
        unit(Squad.SQ_LEFT_ANCHOR_A, Slot.SQ_LEFT_ANCHOR_A),
        unit(Squad.SQ_LEFT_ANCHOR_A_REINFORCE, Slot.SQ_LEFT_ANCHOR_A_REINFORCE),
        unit(Squad.SQ_RIGHT_ANCHOR_A, Slot.SQ_RIGHT_ANCHOR_A),
        unit(Squad.SQ_RIGHT_ANCHOR_A_REINFORCE, Slot.SQ_RIGHT_ANCHOR_A_REINFORCE),
        unit(Squad.SQ_MID_ANCHOR_A, Slot.SQ_MID_ANCHOR_A),
    },
}

local ultra = {
    id = "ultra",
    after = "shard",
    objective = Slot.OBJ_ULTRA,
    squads = {
        unit(Squad.SQ_RISE_ULTRA_CAPTAIN, Slot.SQ_RISE_ULTRA_CAPTAIN),
        unit(Squad.SQ_ULTRA_ADDS_WRETCH_1, Slot.SQ_ULTRA_ADDS_WRETCH_1),
        unit(Squad.SQ_ULTRA_ADDS_WRETCH_2, Slot.SQ_ULTRA_ADDS_WRETCH_2),
        unit(Squad.SQ_ULTRA_ADDS_WRETCH_3, Slot.SQ_ULTRA_ADDS_WRETCH_3),
        unit(Squad.SQ_ULTRA_ADDS_WRETCH_4, Slot.SQ_ULTRA_ADDS_WRETCH_4),
        unit(Squad.SQ_ULTRA_ADDS_WRETCH_5, Slot.SQ_ULTRA_ADDS_WRETCH_5),
        unit(Squad.SQ_ULTRA_ADDS_DREG_1, Slot.SQ_ULTRA_ADDS_DREG_1),
        unit(Squad.SQ_ULTRA_ADDS_DREG_2, Slot.SQ_ULTRA_ADDS_DREG_2),
        unit(Squad.SQ_ULTRA_ADDS_DREG_3, Slot.SQ_ULTRA_ADDS_DREG_3),
        unit(Squad.SQ_ULTRA_ADDS_DREG_4, Slot.SQ_ULTRA_ADDS_DREG_4),
        unit(Squad.SQ_ULTRA_ADDS_DREG_5, Slot.SQ_ULTRA_ADDS_DREG_5),
        unit(Squad.SQ_ULTRA_ADDS_DREG_6, Slot.SQ_ULTRA_ADDS_DREG_6),
        unit(Squad.SQ_ULTRA_ADDS_DREG_7, Slot.SQ_ULTRA_ADDS_DREG_7),
        unit(Squad.SQ_ULTRA_ADDS_DREG_8, Slot.SQ_ULTRA_ADDS_DREG_8),
        unit(Squad.SQ_ULTRA_ADDS_DREG_9, Slot.SQ_ULTRA_ADDS_DREG_9),
        unit(Squad.SQ_ULTRA_ADDS_DREG_10, Slot.SQ_ULTRA_ADDS_DREG_10),
        unit(Squad.SQ_ULTRA_ADDS_DREG_11, Slot.SQ_ULTRA_ADDS_DREG_11),
        unit(Squad.SQ_ULTRA_ADDS_DREG_12, Slot.SQ_ULTRA_ADDS_DREG_12),
        unit(Squad.SQ_ULTRA_ADDS_MARAUDER_1, Slot.SQ_ULTRA_ADDS_MARAUDER_1),
        unit(Squad.SQ_ULTRA_ADDS_MARAUDER_2, Slot.SQ_ULTRA_ADDS_MARAUDER_2),
        unit(Squad.SQ_ULTRA_ADDS_MARAUDER_3, Slot.SQ_ULTRA_ADDS_MARAUDER_3),
    },
}

return campaign.new{
    key = "rise",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80B5E7CC,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80B5E7CC,
    -- The shotgun pickup is not a step end, so it is left out of the seed here.
    omit = {Slot.QUARANTINE_SHOTGUN_INTERACT},
    legs = {
        {id = "quarantine", state = mission.states.STATE_80B5E372_0001_0000_80B5E36D, arm = {
            Slot.PT_START_GOTO, Slot.PT_CAVE_FALLEN_SPAWNER, Slot.PT_CAVE_GOTO,
        }},
        {id = "super_town", state = mission.states.STATE_80B5E372_0002_0000_80B5E36F, arm = {
            Slot.PT_MOVE_FALLEN_BUILDING_TEASE, Slot.PT_BUILDING_GOTO,
            Slot.PT_DIALOG_RISE_SHADOW_1, Slot.PT_SPAWN_HARVESTER_ENCOUNTER,
            Slot.PT_SPAWN_HARVESTER_CAPTAIN, Slot.PT_SPAWN_PATH_MIDPOINT, Slot.PT_GOTO_SHARD,
            Slot.PT_STARTING_WELL_OF_LIGHT,
        }},
    },
    steps = {
        -- Cayde on City rules, then the gap in the wall and the car to duck under.
        {id = "enter", directive = Directive.FIND_A_WAY_TO_THE_SHARD_OF_THE_TRAVELER_8179B607,
            navpoint = Slot.AP_START_GOTO,
            lines = {line(cue.CUE_0), line(cue.CUE_2, Slot.SLOT_0010),
                line(cue.CUE_3, Slot.SLOT_0011)},
            on_start = function(context)
                context:slot(Slot.QUARANTINE_SHOTGUN_INTERACT):set_interactable_object{used = true}
            end,
            ends = {trigger = Slot.PT_START_GOTO}},
        -- Hawthorne's signal dies in the dark, then the Fallen attack in the cave.
        {id = "cave", directive = Directive.FIND_A_WAY_TO_THE_SHARD_OF_THE_TRAVELER_31D1F01C,
            navpoint = Slot.AP_CAVE_GOTO,
            lines = {line(cue.CUE_4, Slot.TV_DIALOG_RISE_DARKNESS_1),
                line(cue.CUE_5, Slot.SLOT_000D_80B5E51F), line(cue.CUE_6, Slot.SLOT_000F)},
            ends = {trigger = Slot.PT_CAVE_GOTO}},
        -- "Those Fallen weren't wearing any house colors", then the first view of the Shard.
        {id = "building", directive = Directive.FIND_A_WAY_TO_THE_SHARD_OF_THE_TRAVELER_B1773045,
            navpoint = Slot.AP_BUILDING_GOTO,
            lines = {line(cue.CUE_7), line(cue.CUE_8, Slot.SLOT_0009_80B5E85E)},
            ends = {trigger = Slot.PT_BUILDING_GOTO}},
        {id = "forest", directive = Directive.GET_TO_THE_SHARD_OF_THE_TRAVELER_BA840FB9,
            navpoint = Slot.AP_SHADOW_GOTO,
            ends = {trigger = Slot.PT_GOTO_SHARD}},
        {id = "push", directive = Directive.FIND_A_WAY_TO_THE_SHARD_OF_THE_TRAVELER,
            navpoint = Slot.AP_SHARD_GOTO,
            ends = {trigger = Slot.PT_STARTING_WELL_OF_LIGHT}},
        -- The four wells power on together and the Light comes back.
        {id = "light", directive = Directive.USE_THE_LIGHT, navpoint = Slot.AP_SUPERFIGHT_GOTO,
            lines = {line(cue.CUE_13)},
            on_start = function(context)
                move(context, {
                    Slot.RISE_WELL_OF_LIGHT_SCRIPT_PREFAB_1_WELL_OF_LIGHT_DEVICE,
                    Slot.RISE_WELL_OF_LIGHT_SCRIPT_PREFAB_2_WELL_OF_LIGHT_DEVICE,
                    Slot.RISE_WELL_OF_LIGHT_SCRIPT_PREFAB_3_WELL_OF_LIGHT_DEVICE,
                    Slot.RISE_WELL_OF_LIGHT_SCRIPT_PREFAB_4_WELL_OF_LIGHT_DEVICE,
                }, "power_on")
            end,
            ends = {clear = "super_fight"}},
        {id = "shard", directive = Directive.GET_TO_THE_SHARD_OF_THE_TRAVELER,
            navpoint = Slot.AP_SHARD_ULTRA_GOTO,
            ends = {clear = "ultra"}},
        -- "I think we scared them away. Take me to the Shard."
        {id = "scared", directive = Directive.GET_TO_THE_SHARD_OF_THE_TRAVELER_C0332418,
            navpoint = Slot.AP_SHARD_ULTRA_GOTO, lines = {line(cue.CUE_12)}},
    },
    encounters = {cave, building, shadow, harvester, captain, path, super_fight, ultra},
}
