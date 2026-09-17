-- Combustion. Red War campaign draft; not tested in game.
-- Leg order: town -> mines. The town step object carries the first goal and Devrim stands there;
-- Hawthorne waits at the top of the mines. The rest follows the trigger volume positions.
local missions = require("missions")
local mission = require(missions.MISSION_DEADZONE)
local campaign = require("lib.campaign")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive = mission.Slot, mission.Squad, mission.Directive
local cue = mission.DialogueCue.M_DIALOG_SENSOR_80B9AF4B

local devrim = {
    id = "devrim",
    squads = {unit(Squad.SQ_DEV_LUZ, Slot.SQ_DEV_LUZ)},
}

local start = {
    id = "start",
    trigger = Slot.PT_MINES_START,
    squads = {
        unit(Squad.SQ_START_DREGS_1, Slot.SQ_START_DREGS_1),
        unit(Squad.SQ_START_DREGS_2, Slot.SQ_START_DREGS_2),
        unit(Squad.SQ_START_DREGS_3, Slot.SQ_START_DREGS_3),
        unit(Squad.SQ_START_DREGS_4, Slot.SQ_START_DREGS_4),
        unit(Squad.SQ_START_DREGS_5, Slot.SQ_START_DREGS_5),
        unit(Squad.SQ_START_KNAVES_1, Slot.SQ_START_KNAVES_1),
        unit(Squad.SQ_START_KNAVES_2, Slot.SQ_START_KNAVES_2),
        unit(Squad.SQ_START_KNAVES_3, Slot.SQ_START_KNAVES_3),
        unit(Squad.SQ_START_KNAVES_4, Slot.SQ_START_KNAVES_4),
        unit(Squad.SQUAD_JUMPING_DREGG_VIGNETTE, Slot.SQUAD_JUMPING_DREGG_VIGNETTE),
    },
}

local entrance = {
    id = "entrance",
    trigger = Slot.PT_ENTRANCE_STABBER,
    objective = Slot.OBJ_MINE_ENTRANCE,
    squads = {unit(Squad.SQ_MINE_ENTRANCE_STABBER, Slot.SQ_MINE_ENTRANCE_STABBER)},
}

local railyard = {
    id = "railyard",
    trigger = Slot.PT_EXIT_KNAVES,
    objective = Slot.OBJ_RAILYARD,
    squads = {
        unit(Squad.SQ_RAILYARD_A_C, Slot.SQ_RAILYARD_A_C),
        unit(Squad.SQ_RAILYARD_A_D, Slot.SQ_RAILYARD_A_D),
    },
}

local mine = {
    id = "mine",
    trigger = Slot.PT_MINE,
    squads = {
        unit(Squad.SQ_MINE_KNAVE_SHADOWS, Slot.SQ_MINE_KNAVE_SHADOWS),
        unit(Squad.SQ_MINE_KNAVE_1, Slot.SQ_MINE_KNAVE_1),
        unit(Squad.SQ_MINE_KNAVE_2, Slot.SQ_MINE_KNAVE_2),
        unit(Squad.SQ_MINE_CAPTAIN, Slot.SQ_MINE_CAPTAIN),
        unit(Squad.SQ_MINE_EXIT, Slot.SQ_MINE_EXIT),
    },
}

local void = {
    id = "void",
    trigger = Slot.PT_VOID,
    objective = Slot.OBJ_VOID,
    squads = {
        unit(Squad.SQ_VOID_SHANKS_A, Slot.SQ_VOID_SHANKS_A),
        unit(Squad.SQ_VOID_SHANKS_B, Slot.SQ_VOID_SHANKS_B),
        unit(Squad.SQ_VOID_SHANKS_REINFORCE_1, Slot.SQ_VOID_SHANKS_REINFORCE_1),
        unit(Squad.SQ_VOID_SHANKS_REINFORCE_1A, Slot.SQ_VOID_SHANKS_REINFORCE_1A),
        unit(Squad.SQ_VOID_SHANKS_REINFORCE_2, Slot.SQ_VOID_SHANKS_REINFORCE_2),
        unit(Squad.SQ_VOID_SHANKS_REINFORCE_2A, Slot.SQ_VOID_SHANKS_REINFORCE_2A),
        unit(Squad.SQ_VOID_SHANKS_BOTTOM_1, Slot.SQ_VOID_SHANKS_BOTTOM_1),
        unit(Squad.SQ_VOID_SHANKS_BOTTOM_1A, Slot.SQ_VOID_SHANKS_BOTTOM_1A),
        unit(Squad.SQ_VOID_SHANKS_BOTTOM_2, Slot.SQ_VOID_SHANKS_BOTTOM_2),
        unit(Squad.SQ_VOID_VANDAL_1, Slot.SQ_VOID_VANDAL_1),
        unit(Squad.SQ_VOID_VANDAL_2, Slot.SQ_VOID_VANDAL_2),
        unit(Squad.SQ_VOID_VANDAL_BOTTOM, Slot.SQ_VOID_VANDAL_BOTTOM),
        unit(Squad.SQ_VOID_DREG_1, Slot.SQ_VOID_DREG_1),
    },
}

-- Killing the Servitors brings the power back. The cathedral groups carry no objective.
local servitors = {
    id = "servitors",
    after = "outage",
    squads = {
        unit(Squad.SQ_CATH_SERVITOR_1, Slot.SQ_CATH_SERVITOR_1),
        unit(Squad.SQ_CATH_SERVITOR_2, Slot.SQ_CATH_SERVITOR_2),
    },
}

local cathedral = {
    id = "cathedral",
    after = "outage",
    squads = {
        unit(Squad.SQ_CATH_VANDAL_1, Slot.SQ_CATH_VANDAL_1),
        unit(Squad.SQ_CATH_VANDAL_2, Slot.SQ_CATH_VANDAL_2),
        unit(Squad.SQ_CATH_DREG_1, Slot.SQ_CATH_DREG_1),
    },
}

-- The switch defenders come once the power is back.
local defenders = {
    id = "defenders",
    trigger = Slot.PT_MORIA_SWITCH_DEFENDERS,
    after = "clear",
    squads = {
        unit(Squad.SQ_CATH_BOSS, Slot.SQ_CATH_BOSS),
        unit(Squad.SQ_CATH_BOSS_BROS, Slot.SQ_CATH_BOSS_BROS),
        unit(Squad.SQ_CATH_BOSS_ADD_A, Slot.SQ_CATH_BOSS_ADD_A),
        unit(Squad.SQ_CATH_BOSS_ADD_A_RE, Slot.SQ_CATH_BOSS_ADD_A_RE),
        unit(Squad.SQ_CATH_BOSS_ADD_B, Slot.SQ_CATH_BOSS_ADD_B),
        unit(Squad.SQ_CATH_BOSS_ADD_B_RE, Slot.SQ_CATH_BOSS_ADD_B_RE),
        unit(Squad.SQ_CATH_BOSS_ADD_D, Slot.SQ_CATH_BOSS_ADD_D),
        unit(Squad.SQ_CATH_BOSS_ADD_E, Slot.SQ_CATH_BOSS_ADD_E),
    },
}

-- The fliers follow the lift up.
local lift = {
    id = "lift",
    trigger = Slot.PT_MORIA_ELEVATOR_FOLLOW,
    after = "ride",
    squads = {
        unit(Squad.SQ_ELEV_FOLLOW_A, Slot.SQ_ELEV_FOLLOW_A),
        unit(Squad.SQ_ELEV_FOLLOW_B, Slot.SQ_ELEV_FOLLOW_B),
        unit(Squad.SQ_ELEV_FOLLOW_C, Slot.SQ_ELEV_FOLLOW_C),
        unit(Squad.SQ_ELEV_FOLLOW_D, Slot.SQ_ELEV_FOLLOW_D),
        unit(Squad.SQ_ELEV_FOLLOW_FLY_A, Slot.SQ_ELEV_FOLLOW_FLY_A),
        unit(Squad.SQ_ELEV_FOLLOW_FLY_B, Slot.SQ_ELEV_FOLLOW_FLY_B),
        unit(Squad.SQ_ELEV_FOLLOW_FLY_C, Slot.SQ_ELEV_FOLLOW_FLY_C),
        unit(Squad.SQ_ELEV_FOLLOW_FLY_D, Slot.SQ_ELEV_FOLLOW_FLY_D),
    },
}

local final_rush = {
    id = "final_rush",
    trigger = Slot.PT_ELEVATOR_DOOR,
    after = "deliver",
    objective = Slot.OBJ_FINAL_RUSH,
    squads = {
        unit(Squad.SQ_CATH_RUSH_A, Slot.SQ_CATH_RUSH_A),
        unit(Squad.SQ_CATH_RUSH_B, Slot.SQ_CATH_RUSH_B),
        unit(Squad.SQ_CATH_RUSH_C, Slot.SQ_CATH_RUSH_C),
        unit(Squad.SQ_CATH_RUSH_D, Slot.SQ_CATH_RUSH_D),
        unit(Squad.SQ_CATH_RUSH_SERV, Slot.SQ_CATH_RUSH_SERV),
    },
}

local hawthorne = {
    id = "hawthorne",
    after = "deliver",
    squads = {unit(Squad.SQ_HAWTHORNE, Slot.SQ_HAWTHORNE)},
}

return campaign.new{
    key = "deadzone",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80B9AF4B,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80B9AF4B,
    legs = {
        {id = "town", state = mission.states.STATE_80B9AD31_0033_0000_80B9A87B, arm = {
            Slot.PT_ELEVATOR_TOWN,
        }},
        {id = "mines", state = mission.states.STATE_80B9AD31_002A_0000_80B9AD0E, arm = {
            Slot.PT_MINES_START, Slot.PT_ENTRANCE_STABBER, Slot.PT_MINE_ENTRANCE_ELEVATOR,
            Slot.PT_EXIT_KNAVES, Slot.PT_MINE, Slot.PT_VOID_GOTO, Slot.PT_GET_GUN,
            Slot.PT_VOID_SHIELD, Slot.PT_VOID, Slot.PT_2ND_ELEVATOR_GOTO,
            Slot.PT_2ND_ELEVATOR_GOTO_2, Slot.PT_MORIA_SWITCH_DEFENDERS,
            Slot.PT_MORIA_ELEVATOR_FOLLOW, Slot.PT_ELEVATOR_ESCAPE, Slot.PT_ELEVATOR_DOOR,
            Slot.PT_HAWTHORNE_APPROACH,
        }},
    },
    steps = {
        {id = "town", directive = Directive.RENDEZVOUS_WITH_HAWTHORNE,
            navpoint = Slot.AP_ELEVATOR_TOWN,
            ends = {trigger = Slot.PT_ELEVATOR_TOWN}},
        {id = "mines", directive = Directive.RENDEZVOUS_WITH_HAWTHORNE_116BDD06,
            ends = {trigger = Slot.PT_MINES_START}},
        -- "That elevator should take us to the top of the mines."
        {id = "elevator", directive = Directive.RENDEZVOUS_WITH_HAWTHORNE_1DD5B5F6,
            navpoint = Slot.LOOK_AT_ELEVATOR_CRASH, lines = {line(cue.CUE_14)},
            on_start = function(context)
                move(context, {Slot.D_DOOR_MINE_ENTRANCE}, "open")
            end,
            ends = {trigger = Slot.PT_MINE_ENTRANCE_ELEVATOR}},
        -- The lift falls: "We'll have to find another way up to Hawthorne."
        {id = "another_way", directive = Directive.FIND_ANOTHER_WAY_UP_TO_HAWTHORNE,
            navpoint = Slot.SLOT_000B_80BDA14E, lines = {line(cue.CUE_15), line(cue.CUE_18)},
            on_start = function(context)
                move(context, {Slot.D_ELEVATOR_FALLING, Slot.D_DOOR_MINE}, "open")
            end,
            ends = {trigger = Slot.PT_VOID_GOTO}},
        {id = "gun", directive = Directive.FIND_ANOTHER_WAY_UP_TO_HAWTHORNE_9C90E0DD,
            navpoint = Slot.AP_GET_GUN,
            ends = {trigger = Slot.PT_GET_GUN}},
        {id = "shield", directive = Directive.FIND_ANOTHER_WAY_UP_TO_HAWTHORNE,
            navpoint = Slot.SLOT_0010_80BDA168,
            ends = {trigger = Slot.PT_VOID_SHIELD}},
        -- The void shield drops and the way down to the second elevator opens.
        {id = "void", directive = Directive.FIND_ANOTHER_WAY_UP_TO_HAWTHORNE,
            navpoint = Slot.SLOT_000F_80BDA168,
            on_start = function(context) move(context, {Slot.D_SHIELD_VOID_B}, "power_off") end,
            ends = {trigger = Slot.PT_2ND_ELEVATOR_GOTO}},
        -- "We found an elevator."
        {id = "second", directive = Directive.FIND_ANOTHER_WAY_UP_TO_HAWTHORNE,
            navpoint = Slot.AP_2ND_ELEVATOR_GOTO_2, lines = {line(cue.CUE_25)},
            ends = {trigger = Slot.PT_2ND_ELEVATOR_GOTO_2}},
        -- "Elevator's not working. Power must be out."
        {id = "outage", directive = Directive.FIND_ANOTHER_WAY_UP_TO_HAWTHORNE_F34A8667,
            navpoint = Slot.SLOT_000A_80BDA12A, lines = {line(cue.CUE_26)},
            ends = {clear = "servitors"}},
        -- "Killing the Servitor brought the power back on."
        {id = "power", directive = Directive.RENDEZVOUS_WITH_HAWTHORNE_3133C68E,
            navpoint = Slot.AP_ELEVATOR_ACTIVATE, lines = {line(cue.CUE_29)},
            on_start = function(context)
                move(context, {Slot.D_GENERATOR_SWITCH, Slot.D_CATHEDRAL_LIGHTS}, "power_on")
            end,
            ends = {interact = Slot.ELEVATOR_SWITCH}},
        {id = "clear", directive = Directive.RENDEZVOUS_WITH_HAWTHORNE_4013B409,
            navpoint = Slot.SLOT_000A_80BDA14E,
            on_start = function(context) move(context, {Slot.D_ELEVATOR_SWITCH}, "power_on") end,
            ends = {clear = "defenders"}},
        -- "We need everyone on the elevator!"
        {id = "ride", directive = Directive.RENDEZVOUS_WITH_HAWTHORNE_0F091E2F,
            navpoint = Slot.SLOT_0010_80BDA12A, lines = {line(cue.CUE_32)},
            on_start = function(context)
                move(context, {Slot.D_ELEVATOR_DOOR_MORIA, Slot.D_ELEVATOR}, "open")
            end,
            ends = {trigger = Slot.PT_ELEVATOR_ESCAPE}},
        -- Out of the mine: "Hey, I'm right here! I can literally see you."
        {id = "deliver", directive = Directive.RENDEZVOUS_WITH_HAWTHORNE_595FAD18,
            lines = {line(cue.CUE_37), line(cue.CUE_38, Slot.SLOT_0017_80BDA140)},
            on_start = function(context) move(context, {Slot.D_ELEVATOR_DOOR}, "open") end,
            ends = {trigger = Slot.PT_HAWTHORNE_APPROACH}},
    },
    encounters = {
        devrim, start, entrance, railyard, mine, void, servitors, cathedral, defenders, lift,
        final_rush, hawthorne,
    },
}
