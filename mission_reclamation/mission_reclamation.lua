-- Utopia. Red War campaign draft; not tested in game.
-- Leg order: platform -> terminal -> arcology. The platform step object carries the first goal.
-- Steps follow the step objects, their lines and the trigger volume positions down to the CPU,
-- then the loader drive out to Amanda.
local missions = require("missions")
local mission = require(missions.MISSION_RECLAMATION)
local campaign = require("lib.campaign")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive = mission.Slot, mission.Squad, mission.Directive
local cue = mission.DialogueCue.M_DIALOG_SENSOR_80B3F591

local intro = {
    id = "intro",
    trigger = Slot.PT_INTRO,
    objective = Slot.OBJ_INTRO,
    squads = {
        unit(Squad.SQ_INTRO_DREG01, Slot.SQ_INTRO_DREG01),
        unit(Squad.SQ_INTRO_DREG02, Slot.SQ_INTRO_DREG02),
        unit(Squad.SQ_INTRO_VANDAL01, Slot.SQ_INTRO_VANDAL01),
        unit(Squad.SQ_INTRO_VANDAL02, Slot.SQ_INTRO_VANDAL02),
        unit(Squad.SQ_INTRO_SERVITOR, Slot.SQ_INTRO_SERVITOR),
    },
}

local hive_intro = {
    id = "hive_intro",
    trigger = Slot.PT_HIVE_INTRO,
    after = "descend",
    objective = Slot.OBJ_HIVE_INTRO,
    on_start = function(context)
        move(context, {Slot.D_ARCOLOGY_RECLAMATION_HIVE_INTRO_DOOR01}, "open")
    end,
    squads = {
        unit(Squad.SQ_HIVE_INTRO_THRALL01, Slot.SQ_HIVE_INTRO_THRALL01),
        unit(Squad.SQ_HIVE_INTRO_THRALL02, Slot.SQ_HIVE_INTRO_THRALL02),
        unit(Squad.SQ_HIVE_INTRO_THRALL03, Slot.SQ_HIVE_INTRO_THRALL03),
        unit(Squad.SQ_HIVE_INTRO_THRALL04, Slot.SQ_HIVE_INTRO_THRALL04),
        unit(Squad.SQ_HIVE_INTRO_THRALL_UPPER01, Slot.SQ_HIVE_INTRO_THRALL_UPPER01),
        unit(Squad.SQ_HIVE_INTRO_ACOLYTE01, Slot.SQ_HIVE_INTRO_ACOLYTE01),
        unit(Squad.SQ_HIVE_INTRO_ACOLYTE02, Slot.SQ_HIVE_INTRO_ACOLYTE02),
        unit(Squad.SQ_HIVE_INTRO_ACOLYTE03, Slot.SQ_HIVE_INTRO_ACOLYTE03),
        unit(Squad.SQ_HIVE_INTRO_KNIGHT01, Slot.SQ_HIVE_INTRO_KNIGHT01),
        unit(Squad.SQ_HIVE_INTRO_WIZARD, Slot.SQ_HIVE_INTRO_WIZARD),
    },
}

local hive_melee = {
    id = "hive_melee",
    trigger = Slot.PT_HIVE_MELEE,
    objective = Slot.OBJ_HIVE_MELEE,
    squads = {
        unit(Squad.SQ_HIVE_MELEE_THRALL01, Slot.SQ_HIVE_MELEE_THRALL01),
        unit(Squad.SQ_HIVE_MELEE_THRALL02, Slot.SQ_HIVE_MELEE_THRALL02),
        unit(Squad.SQ_HIVE_MELEE_THRALL03, Slot.SQ_HIVE_MELEE_THRALL03),
        unit(Squad.SQ_HIVE_MELEE_THRALL04, Slot.SQ_HIVE_MELEE_THRALL04),
        unit(Squad.SQ_HIVE_MELEE_KNIGHT01, Slot.SQ_HIVE_MELEE_KNIGHT01),
        unit(Squad.SQ_HIVE_MELEE_KNIGHT02, Slot.SQ_HIVE_MELEE_KNIGHT02),
        unit(Squad.SQ_HIVE_MELEE_CURSED01, Slot.SQ_HIVE_MELEE_CURSED01),
        unit(Squad.SQ_HIVE_MELEE_SHRIEKER01, Slot.SQ_HIVE_MELEE_SHRIEKER01),
        unit(Squad.SQ_HIVE_MELEE_SHRIEKER02, Slot.SQ_HIVE_MELEE_SHRIEKER02),
    },
}

local hive_ranged = {
    id = "hive_ranged",
    trigger = Slot.PT_HIVE_RANGED,
    objective = Slot.OBJ_HIVE_RANGED,
    squads = {
        unit(Squad.SQ_HIVE_RANGED_ACOLYTE01, Slot.SQ_HIVE_RANGED_ACOLYTE01),
        unit(Squad.SQ_HIVE_RANGED_ACOLYTE02, Slot.SQ_HIVE_RANGED_ACOLYTE02),
        unit(Squad.SQ_HIVE_RANGED_CURSED, Slot.SQ_HIVE_RANGED_CURSED),
        unit(Squad.SQ_HIVE_RANGED_KNIGHT, Slot.SQ_HIVE_RANGED_KNIGHT),
    },
}

local hive_ogre = {
    id = "hive_ogre",
    trigger = Slot.PT_HIVE_OGRE,
    objective = Slot.OBJ_HIVE_OGRE,
    squads = {
        unit(Squad.SQ_HIVE_OGRE, Slot.SQ_HIVE_OGRE),
        unit(Squad.SQ_HIVE_OGRE_THRALL01, Slot.SQ_HIVE_OGRE_THRALL01),
    },
}

local hive_vent = {
    id = "hive_vent",
    trigger = Slot.PT_HIVE_VENT,
    objective = Slot.OBJ_HIVE_VENT,
    squads = {
        unit(Squad.SQ_HIVE_VENT_THRALL01, Slot.SQ_HIVE_VENT_THRALL01),
        unit(Squad.SQ_HIVE_VENT_THRALL02, Slot.SQ_HIVE_VENT_THRALL02),
    },
}

-- The Knights wake once the CPU is pulled.
local cpu_fight = {
    id = "cpu_fight",
    trigger = Slot.PT_HIVE_CPU_KNIGHT,
    after = "escape",
    objective = Slot.OBJ_HIVE_CPU,
    squads = {
        unit(Squad.SQ_HIVE_CPU_ACOLYTE01, Slot.SQ_HIVE_CPU_ACOLYTE01),
        unit(Squad.SQ_HIVE_CPU_ACOLYTE02, Slot.SQ_HIVE_CPU_ACOLYTE02),
        unit(Squad.SQ_HIVE_CPU_ACOLYTE04, Slot.SQ_HIVE_CPU_ACOLYTE04),
        unit(Squad.SQ_HIVE_CPU_ACOLYTE05, Slot.SQ_HIVE_CPU_ACOLYTE05),
        unit(Squad.SQ_HIVE_CPU_KNIGHT01, Slot.SQ_HIVE_CPU_KNIGHT01),
        unit(Squad.SQ_HIVE_CPU_KNIGHT02, Slot.SQ_HIVE_CPU_KNIGHT02),
    },
}

-- The loader drive runs east from the CPU exit to the Arcology center.
local loader_intro = {
    id = "loader_intro",
    trigger = Slot.PT_LOADER_INTRO,
    after = "road",
    objective = Slot.OBJ_LOADER_INTRO,
    squads = {
        unit(Squad.SQ_LOADER_INTRO_SHRIEKER01, Slot.SQ_LOADER_INTRO_SHRIEKER01),
        unit(Squad.SQ_LOADER_INTRO_SHRIEKER02, Slot.SQ_LOADER_INTRO_SHRIEKER02),
        unit(Squad.SQ_LOADER_INTRO_SHRIEKER03, Slot.SQ_LOADER_INTRO_SHRIEKER03),
        unit(Squad.SQ_LOADER_INTRO_ACOLYTE01, Slot.SQ_LOADER_INTRO_ACOLYTE01),
        unit(Squad.SQ_LOADER_INTRO_THRALL01, Slot.SQ_LOADER_INTRO_THRALL01),
        unit(Squad.SQ_LOADER_INTRO_THRALL02, Slot.SQ_LOADER_INTRO_THRALL02),
        unit(Squad.SQ_LOADER_INTRO_THRALL03, Slot.SQ_LOADER_INTRO_THRALL03),
        unit(Squad.SQ_LOADER_INTRO_KNIGHT01, Slot.SQ_LOADER_INTRO_KNIGHT01),
    },
}

local loader_early = {
    id = "loader_early",
    trigger = Slot.PT_LOADER_EARLY,
    after = "road",
    objective = Slot.OBJ_LOADER_EARLY,
    squads = {
        unit(Squad.SQ_LOADER_EARLY_SHRIEKER01, Slot.SQ_LOADER_EARLY_SHRIEKER01),
        unit(Squad.SQ_LOADER_EARLY_SHRIEKER02, Slot.SQ_LOADER_EARLY_SHRIEKER02),
        unit(Squad.SQ_LOADER_EARLY_SHRIEKER03, Slot.SQ_LOADER_EARLY_SHRIEKER03),
        unit(Squad.SQ_LOADER_EARLY_SHRIEKER04, Slot.SQ_LOADER_EARLY_SHRIEKER04),
        unit(Squad.SQ_LOADER_EARLY_SHRIEKER05, Slot.SQ_LOADER_EARLY_SHRIEKER05),
        unit(Squad.SQ_LOADER_EARLY_ACOLYTE01, Slot.SQ_LOADER_EARLY_ACOLYTE01),
        unit(Squad.SQ_LOADER_EARLY_ACOLYTE02, Slot.SQ_LOADER_EARLY_ACOLYTE02),
        unit(Squad.SQ_LOADER_EARLY_SIDE_THRALL01, Slot.SQ_LOADER_EARLY_SIDE_THRALL01),
        unit(Squad.SQ_LOADER_EARLY_SIDE_THRALL02, Slot.SQ_LOADER_EARLY_SIDE_THRALL02),
        unit(Squad.SQ_LOADER_EARLY_THRALL01, Slot.SQ_LOADER_EARLY_THRALL01),
        unit(Squad.SQ_LOADER_EARLY_THRALL02, Slot.SQ_LOADER_EARLY_THRALL02),
        unit(Squad.SQ_LOADER_EARLY_CURSED01, Slot.SQ_LOADER_EARLY_CURSED01),
        unit(Squad.SQ_LOADER_EARLY_KNIGHT01, Slot.SQ_LOADER_EARLY_KNIGHT01),
        unit(Squad.SQ_LOADER_EARLY_KNIGHT02, Slot.SQ_LOADER_EARLY_KNIGHT02),
        unit(Squad.SQ_LOADER_EARLY_DROPSHIP01, Slot.SQ_LOADER_EARLY_DROPSHIP01),
    },
}

local loader_lobby = {
    id = "loader_lobby",
    trigger = Slot.PT_LOADER_LOBBY,
    after = "road",
    objective = Slot.OBJ_LOADER_LOBBY,
    squads = {
        unit(Squad.SQ_LOADER_LOBBY_SHRIEKER01, Slot.SQ_LOADER_LOBBY_SHRIEKER01),
        unit(Squad.SQ_LOADER_LOBBY_SHRIEKER02, Slot.SQ_LOADER_LOBBY_SHRIEKER02),
        unit(Squad.SQ_LOADER_LOBBY_KNIGHT01, Slot.SQ_LOADER_LOBBY_KNIGHT01),
        unit(Squad.SQ_LOADER_LOBBY_THRALL01, Slot.SQ_LOADER_LOBBY_THRALL01),
        unit(Squad.SQ_LOADER_LOBBY_THRALL02, Slot.SQ_LOADER_LOBBY_THRALL02),
        unit(Squad.SQ_LOADER_LOBBY_CURSED, Slot.SQ_LOADER_LOBBY_CURSED),
        unit(Squad.SQ_LOADER_LOBBY_ACOLYTE, Slot.SQ_LOADER_LOBBY_ACOLYTE),
    },
}

local loader_climactic = {
    id = "loader_climactic",
    trigger = Slot.PT_LOADER_CLIMACTIC,
    after = "road",
    objective = Slot.OBJ_LOADER_CLIMACTIC,
    squads = {
        unit(Squad.SQ_LOADER_CLIMACTIC_SHRIEKER01, Slot.SQ_LOADER_CLIMACTIC_SHRIEKER01),
        unit(Squad.SQ_LOADER_CLIMACTIC_SHRIEKER02, Slot.SQ_LOADER_CLIMACTIC_SHRIEKER02),
        unit(Squad.SQ_LOADER_CLIMACTIC_KNIGHT01, Slot.SQ_LOADER_CLIMACTIC_KNIGHT01),
        unit(Squad.SQ_LOADER_CLIMACTIC_KNIGHT02, Slot.SQ_LOADER_CLIMACTIC_KNIGHT02),
        unit(Squad.SQ_LOADER_CLIMACTIC_KNIGHT03, Slot.SQ_LOADER_CLIMACTIC_KNIGHT03),
        unit(Squad.SQ_LOADER_CLIMACTIC_ACOLYTE01, Slot.SQ_LOADER_CLIMACTIC_ACOLYTE01),
        unit(Squad.SQ_LOADER_CLIMACTIC_ACOLYTE02, Slot.SQ_LOADER_CLIMACTIC_ACOLYTE02),
        unit(Squad.SQ_LOADER_CLIMACTIC_THRALL01, Slot.SQ_LOADER_CLIMACTIC_THRALL01),
        unit(Squad.SQ_LOADER_CLIMACTIC_THRALL02, Slot.SQ_LOADER_CLIMACTIC_THRALL02),
        unit(Squad.SQ_LOADER_CLIMACTIC_THRALL03, Slot.SQ_LOADER_CLIMACTIC_THRALL03),
        unit(Squad.SQ_LOADER_CLIMACTIC_THRALL04, Slot.SQ_LOADER_CLIMACTIC_THRALL04),
        unit(Squad.SQ_LOADER_CLIMACTIC_DROPSHIP01, Slot.SQ_LOADER_CLIMACTIC_DROPSHIP01),
        unit(Squad.SQ_LOADER_CLIMACTIC_DROPSHIP02, Slot.SQ_LOADER_CLIMACTIC_DROPSHIP02),
    },
}

-- Amanda's ship at the end of the road.
local hawk = {
    id = "hawk",
    after = "pickup",
    squads = {unit(Squad.SQ_OUTRO_HAWK01, Slot.SQ_OUTRO_HAWK01)},
}

local descend = Directive.SECURE_A_GOLDEN_AGE_CPU_TO_DECRYPT_RED_LEGION_INTEL_868ABAEE

return campaign.new{
    key = "reclamation",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80B3F591,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80B3F591,
    legs = {
        {id = "platform", state = mission.states.STATE_80B3F2DF_0007_0000_80B3F2DA, arm = {
            Slot.PLAYER_TRIGGER_80B998B6,
        }},
        {id = "terminal", state = mission.states.STATE_80B3F2DF_000B_0000_80B3F2DE, arm = {
            Slot.PT_INTRO, Slot.PLAYER_TRIGGER_80B99940, Slot.PLAYER_TRIGGER_80B9992C,
        }},
        {id = "arcology", state = mission.states.STATE_80B3F2DF_0001_0000_80B3F2CC, arm = {
            Slot.PT_HIVE_INTRO, Slot.PLAYER_TRIGGER_80B99812, Slot.PT_HIVE_MELEE,
            Slot.PLAYER_TRIGGER_80B99837, Slot.PT_HIVE_RANGED, Slot.PT_HIVE_OGRE,
            Slot.PLAYER_TRIGGER_80B99850, Slot.PLAYER_TRIGGER_80B99845, Slot.PT_HIVE_VENT,
            Slot.PLAYER_TRIGGER_80B9987B, Slot.PT_HIVE_CPU_KNIGHT, Slot.PLAYER_TRIGGER_EXIT,
            Slot.PT_LOADER_INTRO, Slot.PT_LOADER_EARLY, Slot.PT_LOADER_LOBBY,
            Slot.PT_LOADER_CLIMACTIC, Slot.PLAYER_TRIGGER_80B99829, Slot.PLAYER_TRIGGER_80B997ED,
        }},
    },
    steps = {
        {id = "platform",
            directive = Directive.SECURE_A_GOLDEN_AGE_CPU_TO_DECRYPT_RED_LEGION_INTEL_BA3B252E,
            navpoint = Slot.NAV_POINT_80B998B6,
            ends = {trigger = Slot.PLAYER_TRIGGER_80B998B6}},
        {id = "terminal",
            directive = Directive.SECURE_A_GOLDEN_AGE_CPU_TO_DECRYPT_RED_LEGION_INTEL_3AA02331,
            navpoint = Slot.NAV_POINT_80B99940,
            ends = {trigger = Slot.PLAYER_TRIGGER_80B99940}},
        {id = "access", directive = Directive.LOCATE_THE_CPU_NETWORK_4AC7D950,
            navpoint = Slot.NAV_POINT_80B9992C,
            on_start = function(context)
                move(context, {Slot.D_TERMINAL_RECLAMATION_DOOR01}, "open")
            end,
            ends = {trigger = Slot.PLAYER_TRIGGER_80B9992C}},
        -- The Ghost interfaces with the Arcology OS and the security door opens.
        {id = "interface", directive = Directive.LOCATE_THE_CPU_NETWORK_CE7FB7EE,
            navpoint = Slot.NAV_POINT_80B9985E,
            ends = {ghost_link = Slot.GL_SECURITY_DOOR}},
        -- "Looks like the Hive dug a short cut for us."
        {id = "descend", directive = descend, navpoint = Slot.NAV_POINT_80B99812,
            lines = {line(cue.CUE_10, Slot.SLOT_0004_80B99812)},
            on_start = function(context)
                move(context, {Slot.D_ARCOLOGY_RECLAMATION_SECURITY}, "open")
            end,
            ends = {trigger = Slot.PLAYER_TRIGGER_80B99812}},
        -- "We're definitely in Hive territory now."
        {id = "hole", directive = descend, navpoint = Slot.NAV_POINT_80B99837,
            lines = {line(cue.CUE_11)},
            ends = {trigger = Slot.PLAYER_TRIGGER_80B99837}},
        {id = "ogre", directive = descend, navpoint = Slot.NAV_POINT_80B99850,
            ends = {trigger = Slot.PLAYER_TRIGGER_80B99850}},
        {id = "shaft", directive = descend, navpoint = Slot.NAV_POINT_80B99845,
            ends = {trigger = Slot.PLAYER_TRIGGER_80B99845}},
        {id = "vents", directive = descend, navpoint = Slot.NAV_POINT_80B9987B,
            ends = {trigger = Slot.PLAYER_TRIGGER_80B9987B}},
        {id = "cpu", directive = Directive.SECURE_A_GOLDEN_AGE_CPU_TO_DECRYPT_RED_LEGION_INTEL,
            navpoint = Slot.SLOT_000B_80B99801,
            on_start = function(context)
                move(context, {Slot.D_ARCOLOGY_RECLAMATION_CPU_DOOR01}, "open")
                move(context, {Slot.D_ARCOLOGY_RECLAMATION_CPU}, "power_on")
            end,
            ends = {interact = Slot.O_ARCOLOGY_RECLAMATION_CPU}},
        -- "Warning. CPU network disrupted." Then the long walk to the surface.
        {id = "escape", directive = Directive.ESCAPE_THE_ARCOLOGY_WITH_THE_CPU,
            navpoint = Slot.SLOT_000C_80B99801,
            lines = {line(cue.CUE_24), line(cue.CUE_27)},
            ends = {trigger = Slot.PLAYER_TRIGGER_EXIT}},
        -- "This road leads to the center of the Arcology." Then "Ram the door!"
        {id = "road", directive = Directive.ESCAPE_THE_ARCOLOGY_WITH_THE_CPU,
            navpoint = Slot.NAV_POINT_80B99829,
            lines = {line(cue.CUE_34, Slot.SLOT_000C_80B99829),
                line(cue.CUE_33, Slot.SLOT_000D_80B99829)},
            on_start = function(context)
                move(context, {Slot.D_ARCOLOGY_RECLAMATION_LOADER01}, "open")
            end,
            ends = {trigger = Slot.PLAYER_TRIGGER_80B99829}},
        -- "Got eyes on ya', pal! Meet you at the end of the road!"
        {id = "pickup", directive = Directive.ESCAPE_THE_ARCOLOGY_WITH_THE_CPU,
            navpoint = Slot.NAV_POINT_80B997ED,
            lines = {line(cue.CUE_36, Slot.TV_ARCOLOGY_125_DIALOG)},
            ends = {trigger = Slot.PLAYER_TRIGGER_80B997ED}},
    },
    encounters = {
        intro, hive_intro, hive_melee, hive_ranged, hive_ogre, hive_vent, cpu_fight,
        loader_intro, loader_early, loader_lobby, loader_climactic, hawk,
    },
}
