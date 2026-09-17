-- Looped. Red War campaign draft; not tested in game.
-- Leg order: lz -> hollows -> sunken_cave -> well_of_giants, from the transition spawn sets and
-- the trigger volume positions. Steps follow the step objects and their lines.
local missions = require("missions")
local mission = require(missions.MISSION_PROSPECT)
local campaign = require("lib.campaign")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive = mission.Slot, mission.Squad, mission.Directive
local cue = mission.DialogueCue.M_DIALOG_SENSOR_80B434A5

-- The coffins hold the Vex incubators around the teleporter.
local grotto = {
    id = "grotto",
    trigger = Slot.PT_VEX_REVEAL,
    objective = Slot.GROTTO_OBJECTIVE,
    on_start = function(context)
        move(context, {Slot.COFFIN_DEVICE, Slot.COFFIN_DEVICE_1, Slot.COFFIN_DEVICE_2,
            Slot.COFFIN_DEVICE_3, Slot.COFFIN_DEVICE_4}, "open")
    end,
    squads = {
        unit(Squad.INCUBATOR_SQUAD_1, Slot.INCUBATOR_SQUAD_1),
        unit(Squad.INCUBATOR_SQUAD_2, Slot.INCUBATOR_SQUAD_2),
        unit(Squad.INCUBATOR_SQUAD_3, Slot.INCUBATOR_SQUAD_3),
        unit(Squad.INCUBATOR_SQUAD_4, Slot.INCUBATOR_SQUAD_4),
        unit(Squad.INCUBATOR_SQUAD_5, Slot.INCUBATOR_SQUAD_5),
        unit(Squad.GOBLIN_LEFT_SQUAD_1, Slot.GOBLIN_LEFT_SQUAD_1),
        unit(Squad.GOBLIN_LEFT_SQUAD_2, Slot.GOBLIN_LEFT_SQUAD_2),
        unit(Squad.GOBLIN_LEFT_SQUAD_3, Slot.GOBLIN_LEFT_SQUAD_3),
        unit(Squad.GOBLIN_LEFT_SQUAD_4, Slot.GOBLIN_LEFT_SQUAD_4),
        unit(Squad.GOBLIN_LEFT_SQUAD_5, Slot.GOBLIN_LEFT_SQUAD_5),
        unit(Squad.GOBLIN_LEFT_SUPP_SQUAD, Slot.GOBLIN_LEFT_SUPP_SQUAD),
        unit(Squad.GOBLIN_RIGHT_SQUAD_1, Slot.GOBLIN_RIGHT_SQUAD_1),
        unit(Squad.GOBLIN_RIGHT_SQUAD_2, Slot.GOBLIN_RIGHT_SQUAD_2),
        unit(Squad.GOBLIN_RIGHT_SQUAD_3, Slot.GOBLIN_RIGHT_SQUAD_3),
        unit(Squad.GOBLIN_RIGHT_SQUAD_4, Slot.GOBLIN_RIGHT_SQUAD_4),
        unit(Squad.GOBLIN_RIGHT_SQUAD_5, Slot.GOBLIN_RIGHT_SQUAD_5),
        unit(Squad.GOBLIN_RIGHT_SUPP_SQUAD, Slot.GOBLIN_RIGHT_SUPP_SQUAD),
        unit(Squad.MINOTAUR_LEFT_SQUAD_2, Slot.MINOTAUR_LEFT_SQUAD_2),
        unit(Squad.MINOTAUR_LEFT_SQUAD_3, Slot.MINOTAUR_LEFT_SQUAD_3),
        unit(Squad.MINOTAUR_RIGHT_SQUAD_1, Slot.MINOTAUR_RIGHT_SQUAD_1),
        unit(Squad.MINOTAUR_RIGHT_SQUAD_2, Slot.MINOTAUR_RIGHT_SQUAD_2),
    },
}

-- Cayde's image in the teleporter is kept apart so it never holds up a clear.
local cayde_image = {
    id = "cayde_image",
    trigger = Slot.PT_PLAYER_APPROACHING_CAYDE,
    objective = Slot.GROTTO_OBJECTIVE,
    squads = {unit(Squad.SQUAD_CAYDE_IN_TELEPORTER, Slot.SQUAD_CAYDE_IN_TELEPORTER)},
}

local overhang = {
    id = "overhang",
    trigger = Slot.OVERHANG_ENTRY_TRIGGER,
    objective = Slot.OVERHANG_OBJECTIVE,
    squads = {
        unit(Squad.LEDGE_HOBGOBLIN_SQUAD, Slot.LEDGE_HOBGOBLIN_SQUAD),
        unit(Squad.GATE_HOBGOBLIN_SQUAD, Slot.GATE_HOBGOBLIN_SQUAD),
        unit(Squad.GATE_HOBGOBLIN_SQUAD_1, Slot.GATE_HOBGOBLIN_SQUAD_1),
        unit(Squad.WELL_PATH_HOBGOBLIN_SQUAD, Slot.WELL_PATH_HOBGOBLIN_SQUAD),
        unit(Squad.PLATFORM_HOBGOBLIN_SQUAD, Slot.PLATFORM_HOBGOBLIN_SQUAD),
        unit(Squad.PLATFORM_HOBGOBLIN_SQUAD_1, Slot.PLATFORM_HOBGOBLIN_SQUAD_1),
        unit(Squad.PLATFORM_HOBGOBLIN_SQUAD_2, Slot.PLATFORM_HOBGOBLIN_SQUAD_2),
        unit(Squad.PLATFORM_HOBGOBLIN_SQUAD_3, Slot.PLATFORM_HOBGOBLIN_SQUAD_3),
        unit(Squad.GATE_GOBLIN_SQUAD, Slot.GATE_GOBLIN_SQUAD),
        unit(Squad.CUBBY_GOBLIN_SQUAD, Slot.CUBBY_GOBLIN_SQUAD),
        unit(Squad.CUBBY_GOBLIN_SQUAD_1, Slot.CUBBY_GOBLIN_SQUAD_1),
        unit(Squad.WELL_PATH_GOBLIN_SQUAD, Slot.WELL_PATH_GOBLIN_SQUAD),
        unit(Squad.BACK_MINOTAUR_SQUAD, Slot.BACK_MINOTAUR_SQUAD),
        unit(Squad.GATE_MINOTAUR_SQUAD, Slot.GATE_MINOTAUR_SQUAD),
        unit(Squad.CUBBY_MAJOR_MINOTAUR_SQUAD, Slot.CUBBY_MAJOR_MINOTAUR_SQUAD),
    },
}

-- Cayde calls out as soon as the player reaches the well.
local cayde_well = {
    id = "cayde_well",
    trigger = Slot.PT_INNER_WELL_DOOR,
    objective = Slot.WELL_OBJECTIVE,
    squads = {unit(Squad.CAYDE_WELL, Slot.CAYDE_WELL)},
}

local well = {
    id = "well",
    trigger = Slot.WELL_TRIGGER,
    after = "hapax",
    objective = Slot.WELL_OBJECTIVE,
    squads = {
        unit(Squad.WELL_BOSS_SQUAD, Slot.WELL_BOSS_SQUAD),
        unit(Squad.WELL_RIGHT_MINOTAUR_SQUAD_1, Slot.WELL_RIGHT_MINOTAUR_SQUAD_1),
        unit(Squad.WELL_RIGHT_MINOTAUR_SQUAD_2, Slot.WELL_RIGHT_MINOTAUR_SQUAD_2),
        unit(Squad.WELL_RIGHT_GOBLIN_SQUAD_1, Slot.WELL_RIGHT_GOBLIN_SQUAD_1),
        unit(Squad.WELL_RIGHT_GOBLIN_SQUAD_2, Slot.WELL_RIGHT_GOBLIN_SQUAD_2),
        unit(Squad.WELL_RIGHT_GOBLIN_SQUAD_3, Slot.WELL_RIGHT_GOBLIN_SQUAD_3),
        unit(Squad.WELL_RIGHT_GOBLIN_SQUAD_4, Slot.WELL_RIGHT_GOBLIN_SQUAD_4),
        unit(Squad.WELL_LEFT_GOBLIN_SQUAD_1, Slot.WELL_LEFT_GOBLIN_SQUAD_1),
        unit(Squad.WELL_LEFT_GOBLIN_SQUAD_2, Slot.WELL_LEFT_GOBLIN_SQUAD_2),
        unit(Squad.WELL_LEFT_GOBLIN_SQUAD_3, Slot.WELL_LEFT_GOBLIN_SQUAD_3),
        unit(Squad.WELL_LEFT_GOBLIN_SQUAD_4, Slot.WELL_LEFT_GOBLIN_SQUAD_4),
        unit(Squad.WELL_LEFT_MINOTAUR_SQUAD_1, Slot.WELL_LEFT_MINOTAUR_SQUAD_1),
        unit(Squad.WELL_LEFT_HOBGOBLIN_SQUAD_1, Slot.WELL_LEFT_HOBGOBLIN_SQUAD_1),
        unit(Squad.WELL_LEFT_HOBGOBLIN_SQUAD_2, Slot.WELL_LEFT_HOBGOBLIN_SQUAD_2),
    },
}

return campaign.new{
    key = "prospect",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80B434A5,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80B434A5,
    legs = {
        {id = "lz", state = mission.states.STATE_80B4335B_000D_0000_80B43AD9, arm = {
            Slot.PT_MISSION_DLG_START, Slot.PT_MIDPOINT, Slot.DESCEND_TOWER_TRIGGER_B,
        }},
        {id = "hollows", state = mission.states.STATE_80B4335B_0008_0000_80B43325, arm = {
            Slot.GROTTO_TRIGGER, Slot.PT_VEX_REVEAL, Slot.PT_PLAYER_APPROACHING_CAYDE,
            Slot.PT_DIALOG_1_80B43AB8,
        }},
        {id = "sunken_cave", state = mission.states.STATE_80B4335B_0020_0000_80B43ADE, arm = {
            Slot.OVERHANG_ENTRY_TRIGGER, Slot.OVERHANG_TRIGGER, Slot.PM_GIANTS, Slot.PT_WELL,
        }},
        {id = "well_of_giants", state = mission.states.STATE_80B4335B_002A_0000_80B43AE6, arm = {
            Slot.PT_INNER_WELL_DOOR, Slot.WELL_TRIGGER,
        }},
    },
    steps = {
        -- Failsafe gives the coordinates from her console.
        {id = "failsafe", directive = Directive.FIND_CAYDE_6_AEDCB05A,
            navpoint = Slot.NP_FAILSAFE,
            on_start = function(context) move(context, {Slot.CONSOLE_DEVICE}, "power_on") end,
            ends = {interact = Slot.FAILSAFE_INTERACT_OBJECT,
                trigger = Slot.PT_MISSION_DLG_START}},
        {id = "midpoint", directive = Directive.FIND_CAYDE_6_AEDCB05A,
            navpoint = Slot.SLOT_000B_80B43AE7,
            ends = {trigger = Slot.PT_MIDPOINT}},
        {id = "tower", directive = Directive.FIND_CAYDE_6_4E726461,
            navpoint = Slot.DESCEND_TOWER_ACTIVITY_POINT,
            ends = {trigger = Slot.DESCEND_TOWER_TRIGGER_B}},
        {id = "grotto", directive = Directive.FIND_CAYDE_6_4E726461,
            navpoint = Slot.GROTTO_ACTIVITY_POINT_80B43AA7,
            ends = {trigger = Slot.GROTTO_TRIGGER}},
        {id = "vex", directive = Directive.FIND_CAYDE_6_4E726461,
            navpoint = Slot.SLOT_000C_80B43AB8,
            ends = {clear = "grotto"}},
        {id = "cayde", directive = Directive.FIND_CAYDE_6,
            navpoint = Slot.GROTTO_ACTIVITY_POINT_80B43AB8,
            ends = {trigger = Slot.PT_PLAYER_APPROACHING_CAYDE}},
        -- Cayde's message, then "So, Failsafe. What exactly happened here?"
        {id = "coordinates", directive = Directive.GET_TO_CAYDE_6_9C44F097,
            navpoint = Slot.OVERHANG_ACTIVITY_POINT_80B43ABC,
            lines = {line(cue.CUE_11), line(cue.CUE_16)},
            ends = {trigger = Slot.OVERHANG_ENTRY_TRIGGER}},
        -- "How long have you been here, exactly?"
        {id = "overhang", directive = Directive.GET_TO_CAYDE_6_9C44F097,
            navpoint = Slot.OVERHANG_ACTIVITY_POINT_80B43BB0,
            lines = {line(cue.CUE_18, Slot.TV_DIALOG_1_80B43BB0)},
            ends = {trigger = Slot.OVERHANG_TRIGGER}},
        -- "You are good at destroying the Vex!" Then the Exodus Black crew.
        {id = "giants", directive = Directive.GET_TO_CAYDE_6_F1D2BC9C,
            navpoint = Slot.SLOT_0002_80B43BDB,
            lines = {line(cue.CUE_19), line(cue.CUE_20, Slot.WELL_OF_GIANTS_VOLUME)},
            ends = {trigger = Slot.PM_GIANTS}},
        -- "The Cayde-6 is just beyond that Vex Gate. Please proceed."
        {id = "gate", directive = Directive.GET_TO_CAYDE_6,
            navpoint = Slot.WELL_ACTIVITY_POINT_80B43494,
            lines = {line(cue.CUE_21, Slot.SLOT_000F_80B43494)},
            on_start = function(context)
                move(context, {Slot.MANCANNON_DEVICE, Slot.MANCANNON_DEVICE_1}, "open")
            end,
            ends = {trigger = Slot.PT_WELL}},
        -- "We're through! We're OK!" Then Cayde: "Hey! Over here! Get me out of here!"
        {id = "well", directive = Directive.GET_TO_CAYDE_6,
            navpoint = Slot.WELL_ACTIVITY_POINT_80B43532,
            lines = {line(cue.CUE_26, Slot.SLOT_000B_80B43494),
                line(cue.CUE_29, Slot.TV_DIALOG_1_80B43532)},
            ends = {trigger = Slot.WELL_TRIGGER}},
        -- "What's that? That a Hydra? Handle that first. Then me!"
        {id = "hapax", directive = Directive.DEFEND_CAYDE_6,
            navpoint = Slot.WELL_ACTIVITY_POINT_80B4353C, lines = {line(cue.CUE_30)},
            ends = {clear = "well"}},
        -- "Good job! Now get over here before I disappear again!"
        {id = "free", lines = {line(cue.CUE_35)},
            ends = {interact = Slot.CONFLUX_INTERACTABLE_OBJECT}},
    },
    encounters = {grotto, cayde_image, overhang, cayde_well, well},
}
