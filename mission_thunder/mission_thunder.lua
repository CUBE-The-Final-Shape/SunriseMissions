-- Payback. Red War campaign draft; not tested in game.
-- Leg order: gorge -> tunnels -> islands, from the transition spawn sets and the step objects.
-- Steps follow the lines: the blast door, the retracted bridge, then the carrier's generators,
-- its Goliath and its fuel conduit.
local missions = require("missions")
local mission = require(missions.MISSION_THUNDER)
local campaign = require("lib.campaign")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive = mission.Slot, mission.Squad, mission.Directive
local cue = mission.DialogueCue.M_DIALOG_SENSOR_80B9BF46

local intro = {
    id = "intro",
    trigger = Slot.PT_INTRO_PSION01,
    objective = Slot.OBJ_INTRO,
    squads = {
        unit(Squad.SQ_INTRO_HAWK01, Slot.SQ_INTRO_HAWK01),
        unit(Squad.SQ_INTRO_FRIENDLIES01, Slot.SQ_INTRO_FRIENDLIES01),
        unit(Squad.SQ_INTRO_LEGIONARIES01, Slot.SQ_INTRO_LEGIONARIES01),
        unit(Squad.SQ_INTRO_LEGIONARY02, Slot.SQ_INTRO_LEGIONARY02),
        unit(Squad.SQ_INTRO_PHALANX00, Slot.SQ_INTRO_PHALANX00),
        unit(Squad.SQ_INTRO_PHALANX01, Slot.SQ_INTRO_PHALANX01),
        unit(Squad.SQ_INTRO_PSION01, Slot.SQ_INTRO_PSION01),
        unit(Squad.SQ_INTRO_PSION02, Slot.SQ_INTRO_PSION02),
        unit(Squad.SQ_INTRO_PSION03, Slot.SQ_INTRO_PSION03),
        unit(Squad.SQ_INTRO_PSION04, Slot.SQ_INTRO_PSION04),
        unit(Squad.SQ_INTRO_CENTURION01, Slot.SQ_INTRO_CENTURION01),
        unit(Squad.SQ_INTRO_CENTURION02, Slot.SQ_INTRO_CENTURION02),
    },
}

local nux = {
    id = "nux",
    trigger = Slot.PT_NUX,
    objective = Slot.OBJ_NUX,
    squads = {
        unit(Squad.SQ_NUX_LEGIONARIES01, Slot.SQ_NUX_LEGIONARIES01),
        unit(Squad.SQ_NUX_PHALANX01, Slot.SQ_NUX_PHALANX01),
        unit(Squad.SQ_NUX_PSION01, Slot.SQ_NUX_PSION01),
        unit(Squad.SQ_NUX_CENTURION01, Slot.SQ_NUX_CENTURION01),
        unit(Squad.SQ_NUX_COLOSSUS, Slot.SQ_NUX_COLOSSUS),
    },
}

-- The cylinder groups carry no encounter objective.
local cylinder = {
    id = "cylinder",
    trigger = Slot.PT_CYLINDER,
    on_start = function(context) move(context, {Slot.D_TUNNELS_CYLINDER_DOOR01}, "open") end,
    squads = {
        unit(Squad.SQ_INTERCEPTOR01, Slot.SQ_INTERCEPTOR01),
        unit(Squad.SQ_BACK_LEFT_UPPER02, Slot.SQ_BACK_LEFT_UPPER02),
        unit(Squad.SQ_BACK_LEFT_UPPER03, Slot.SQ_BACK_LEFT_UPPER03),
        unit(Squad.SQ_CYLINDER_INTRO_LEFT01, Slot.SQ_CYLINDER_INTRO_LEFT01),
        unit(Squad.SQ_CYLINDER_INTERCEPTOR01, Slot.SQ_CYLINDER_INTERCEPTOR01),
        unit(Squad.SQ_CYLINDER_INTERCEPTOR02, Slot.SQ_CYLINDER_INTERCEPTOR02),
        unit(Squad.SQ_CYLINDER_INTERCEPTOR03, Slot.SQ_CYLINDER_INTERCEPTOR03),
        unit(Squad.SQ_CYLINDER_INTERCEPTOR05, Slot.SQ_CYLINDER_INTERCEPTOR05),
        unit(Squad.SQ_CYLINDER_PLATFORM01, Slot.SQ_CYLINDER_PLATFORM01),
        unit(Squad.SQ_CYLINDER_PLATFORM02, Slot.SQ_CYLINDER_PLATFORM02),
        unit(Squad.SQ_CYLINDER_PLATFORM03, Slot.SQ_CYLINDER_PLATFORM03),
        unit(Squad.SQ_CYLINDER_PLATFORM04, Slot.SQ_CYLINDER_PLATFORM04),
        unit(Squad.SQ_CYLINDER_AREA_TURRET01, Slot.SQ_CYLINDER_AREA_TURRET01),
        unit(Squad.SQ_CYLINDER_AREA_A01, Slot.SQ_CYLINDER_AREA_A01),
        unit(Squad.SQ_CYLINDER_AREA_A02, Slot.SQ_CYLINDER_AREA_A02),
        unit(Squad.SQ_CYLINDER_AREA_B01, Slot.SQ_CYLINDER_AREA_B01),
        unit(Squad.SQ_CYLINDER_AREA_C01, Slot.SQ_CYLINDER_AREA_C01),
        unit(Squad.SQ_CYLINDER_DROPSHIP01, Slot.SQ_CYLINDER_DROPSHIP01),
        unit(Squad.SQ_CYLINDER_DROPSHIP01_SQUAD, Slot.SQ_CYLINDER_DROPSHIP01_SQUAD),
        unit(Squad.SQ_CYLINDER_DROPSHIP02, Slot.SQ_CYLINDER_DROPSHIP02),
        unit(Squad.SQ_CYLINDER_DROPSHIP02_SQUAD, Slot.SQ_CYLINDER_DROPSHIP02_SQUAD),
        unit(Squad.SQ_CYLINDER_DROPSHIP_SNIPER01, Slot.SQ_CYLINDER_DROPSHIP_SNIPER01),
        unit(Squad.SQ_CYLINDER_DROPSHIP_SNIPER01_SQUAD,
             Slot.SQ_CYLINDER_DROPSHIP_SNIPER01_SQUAD),
        unit(Squad.SQ_CYLINDER_DROPSHIP_ATTACK, Slot.SQ_CYLINDER_DROPSHIP_ATTACK),
        unit(Squad.SQ_CYLINDER_DROPSHIP_AMBIENT00, Slot.SQ_CYLINDER_DROPSHIP_AMBIENT00),
        unit(Squad.SQ_CYLINDER_DROPSHIP_AMBIENT01, Slot.SQ_CYLINDER_DROPSHIP_AMBIENT01),
        unit(Squad.SQ_CYLINDER_DROPSHIP_AMBIENT02, Slot.SQ_CYLINDER_DROPSHIP_AMBIENT02),
        unit(Squad.SQ_CYLINDER_HAWK02, Slot.SQ_CYLINDER_HAWK02),
        unit(Squad.SQ_CYLINDER_HAWK03, Slot.SQ_CYLINDER_HAWK03),
        unit(Squad.SQ_CYLINDER_NOISE, Slot.SQ_CYLINDER_NOISE),
    },
}

local door = {
    id = "door",
    trigger = Slot.PT_DOOR_80BDA22D,
    objective = Slot.OBJ_DOOR,
    squads = {
        unit(Squad.SQ_DOOR_TURRET, Slot.SQ_DOOR_TURRET),
        unit(Squad.SQ_DOOR_GLADIATOR, Slot.SQ_DOOR_GLADIATOR),
        unit(Squad.SQ_DOOR_LEGIONARY01, Slot.SQ_DOOR_LEGIONARY01),
        unit(Squad.SQ_DOOR_PHALANX01, Slot.SQ_DOOR_PHALANX01),
        unit(Squad.SQ_DOOR_PSION01, Slot.SQ_DOOR_PSION01),
        unit(Squad.SQ_DOOR_PYRO01, Slot.SQ_DOOR_PYRO01),
        unit(Squad.SQ_DOOR_BFG, Slot.SQ_DOOR_BFG),
    },
}

local ramps = {
    id = "ramps",
    trigger = Slot.PT_RAMPS,
    on_start = function(context)
        move(context, {Slot.D_TUNNELS_RAMPS_BACK_DOOR01}, "open")
    end,
    squads = {
        unit(Squad.SQ_RAMPS_INTRO_PHALANX, Slot.SQ_RAMPS_INTRO_PHALANX),
        unit(Squad.SQ_RAMPS_INTRO_SNIPER, Slot.SQ_RAMPS_INTRO_SNIPER),
        unit(Squad.SQ_RAMPS_MID_LEGIONARY, Slot.SQ_RAMPS_MID_LEGIONARY),
        unit(Squad.SQ_RAMPS_MID_CENTURION, Slot.SQ_RAMPS_MID_CENTURION),
        unit(Squad.SQ_RAMPS_BACK_LEGIONARY, Slot.SQ_RAMPS_BACK_LEGIONARY),
        unit(Squad.SQ_RAMPS_BACK_PHALANX, Slot.SQ_RAMPS_BACK_PHALANX),
        unit(Squad.SQ_RAMPS_BACK_SNIPER, Slot.SQ_RAMPS_BACK_SNIPER),
        unit(Squad.SQ_RAMPS_BACK_BRUISER, Slot.SQ_RAMPS_BACK_BRUISER),
        unit(Squad.SQ_RAMPS_BACK_WARBEAST, Slot.SQ_RAMPS_BACK_WARBEAST),
        unit(Squad.SQ_RAMPS_INTERCEPTOR01, Slot.SQ_RAMPS_INTERCEPTOR01),
        unit(Squad.SQ_RAMPS_INTERCEPTOR02, Slot.SQ_RAMPS_INTERCEPTOR02),
        unit(Squad.SQ_RAMPS_INTERCEPTOR03, Slot.SQ_RAMPS_INTERCEPTOR03),
        unit(Squad.SQ_RAMPS_INTERCEPTOR04, Slot.SQ_RAMPS_INTERCEPTOR04),
        unit(Squad.SQ_RAMPS_INTERCEPTOR05, Slot.SQ_RAMPS_INTERCEPTOR05),
        unit(Squad.SQ_RAMPS_INTERCEPTOR06, Slot.SQ_RAMPS_INTERCEPTOR06),
        unit(Squad.SQ_RAMPS_DROPSHIP010, Slot.SQ_RAMPS_DROPSHIP010),
        unit(Squad.SQ_RAMPS_GOLIATH, Slot.SQ_RAMPS_GOLIATH),
        unit(Squad.SQ_RAMPS_BRIDGE_DEFENSE01, Slot.SQ_RAMPS_BRIDGE_DEFENSE01),
        unit(Squad.SQ_RAMPS_BRIDGE_DEFENSE02, Slot.SQ_RAMPS_BRIDGE_DEFENSE02),
        unit(Squad.SQ_RAMPS_BRIDGE_SNIPER01, Slot.SQ_RAMPS_BRIDGE_SNIPER01),
        unit(Squad.SQ_RAMPS_BRIDGE_SNIPER02, Slot.SQ_RAMPS_BRIDGE_SNIPER02),
        unit(Squad.SQ_RAMPS_BRIDGE_SNIPER03, Slot.SQ_RAMPS_BRIDGE_SNIPER03),
        unit(Squad.SQ_RAMPS_BRIDGE_SNIPER04, Slot.SQ_RAMPS_BRIDGE_SNIPER04),
        unit(Squad.SQ_RAMPS_BRIDGE_DEFENSE_INTERCEPTOR,
             Slot.SQ_RAMPS_BRIDGE_DEFENSE_INTERCEPTOR),
        unit(Squad.SQ_RAMPS_BRIDGE_DEFENSE_WARBEAST, Slot.SQ_RAMPS_BRIDGE_DEFENSE_WARBEAST),
    },
}

-- The bridge defenders wait for the bridge.
local bridge = {
    id = "bridge",
    trigger = Slot.PT_BRIDGE_80BDA22D,
    after = "across",
    squads = {
        unit(Squad.SQ_BRIDGE_INTRO_GLADIATOR, Slot.SQ_BRIDGE_INTRO_GLADIATOR),
        unit(Squad.SQ_BRIDGE_GLADIATOR_PLATFORM, Slot.SQ_BRIDGE_GLADIATOR_PLATFORM),
        unit(Squad.SQ_BRIDGE_PSION01_PLATFORM, Slot.SQ_BRIDGE_PSION01_PLATFORM),
        unit(Squad.SQ_BRIDGE_BRIDGE_LEFT01, Slot.SQ_BRIDGE_BRIDGE_LEFT01),
        unit(Squad.SQ_BRIDGE_BRIDGE_RIGHT01, Slot.SQ_BRIDGE_BRIDGE_RIGHT01),
        unit(Squad.SQ_BRIDGE_BRIDGE_RIGHT02, Slot.SQ_BRIDGE_BRIDGE_RIGHT02),
        unit(Squad.SQ_BRIDGE_UPPER01, Slot.SQ_BRIDGE_UPPER01),
        unit(Squad.SQ_BRIDGE_UPPER02, Slot.SQ_BRIDGE_UPPER02),
        unit(Squad.SQ_BRIDGE_INTERCEPTOR_FRONT, Slot.SQ_BRIDGE_INTERCEPTOR_FRONT),
        unit(Squad.SQ_BRIDGE_INTERCEPTOR_LEFT, Slot.SQ_BRIDGE_INTERCEPTOR_LEFT),
        unit(Squad.SQ_BRIDGE_INTERCEPTOR_RIGHT, Slot.SQ_BRIDGE_INTERCEPTOR_RIGHT),
        unit(Squad.SQ_BRIDGE_GOLIATH_LEFT, Slot.SQ_BRIDGE_GOLIATH_LEFT),
        unit(Squad.SQ_BRIDGE_GOLIATH_RIGHT, Slot.SQ_BRIDGE_GOLIATH_RIGHT),
        unit(Squad.SQ_BRIDGE_DROPSHIP010_SQUAD01, Slot.SQ_BRIDGE_DROPSHIP010_SQUAD01),
        unit(Squad.SQ_BRIDGE_DROPSHIP010_SQUAD02, Slot.SQ_BRIDGE_DROPSHIP010_SQUAD02),
        unit(Squad.SQ_BRIDGE_MOSQUITO, Slot.SQ_BRIDGE_MOSQUITO),
    },
}

local core1 = {
    id = "core1",
    trigger = Slot.PT_CORE1,
    squads = {
        unit(Squad.SQ_CORE1_INTERCEPTOR01, Slot.SQ_CORE1_INTERCEPTOR01),
        unit(Squad.SQ_CORE1_INTERCEPTOR02, Slot.SQ_CORE1_INTERCEPTOR02),
        unit(Squad.SQ_CORE1_INTERCEPTOR03, Slot.SQ_CORE1_INTERCEPTOR03),
        unit(Squad.SQ_CORE1_LEGIONARY01, Slot.SQ_CORE1_LEGIONARY01),
        unit(Squad.SQ_CORE1_GLADIATOR, Slot.SQ_CORE1_GLADIATOR),
        unit(Squad.SQ_CORE1_CENTURION, Slot.SQ_CORE1_CENTURION),
        unit(Squad.SQ_CORE1_PYRO, Slot.SQ_CORE1_PYRO),
        unit(Squad.SQ_CORE1_MOSQUITO, Slot.SQ_CORE1_MOSQUITO),
    },
}

local core2 = {
    id = "core2",
    trigger = Slot.PT_CORE2,
    squads = {
        unit(Squad.SQ_CORE2_INTERCEPTOR01, Slot.SQ_CORE2_INTERCEPTOR01),
        unit(Squad.SQ_CORE2_INTERCEPTOR02, Slot.SQ_CORE2_INTERCEPTOR02),
        unit(Squad.SQ_CORE2_INTERCEPTOR03, Slot.SQ_CORE2_INTERCEPTOR03),
        unit(Squad.SQ_CORE2_LEGIONARY01, Slot.SQ_CORE2_LEGIONARY01),
        unit(Squad.SQ_CORE2_GLADIATOR, Slot.SQ_CORE2_GLADIATOR),
        unit(Squad.SQ_CORE2_CENTURION, Slot.SQ_CORE2_CENTURION),
        unit(Squad.SQ_CORE2_PYRO, Slot.SQ_CORE2_PYRO),
        unit(Squad.SQ_CORE2_MOSQUITO, Slot.SQ_CORE2_MOSQUITO),
    },
}

-- The engine fliers come with the Goliath once the shield is down.
local engine = {
    id = "engine",
    after = "goliath",
    squads = {
        unit(Squad.SQ_ENGINE_INTERCEPTOR01, Slot.SQ_ENGINE_INTERCEPTOR01),
        unit(Squad.SQ_ENGINE_INTERCEPTOR02, Slot.SQ_ENGINE_INTERCEPTOR02),
        unit(Squad.SQ_ENGINE_INTERCEPTOR03, Slot.SQ_ENGINE_INTERCEPTOR03),
        unit(Squad.SQ_ENGINE_INTERCEPTOR04, Slot.SQ_ENGINE_INTERCEPTOR04),
        unit(Squad.SQ_ENGINE_DROPSHIP01, Slot.SQ_ENGINE_DROPSHIP01),
        unit(Squad.SQ_ENGINE_MOSQUITO_CENTER, Slot.SQ_ENGINE_MOSQUITO_CENTER),
        unit(Squad.SQ_ENGINE_MOSQUITO_LEFT01, Slot.SQ_ENGINE_MOSQUITO_LEFT01),
        unit(Squad.SQ_ENGINE_MOSQUITO_LEFT02, Slot.SQ_ENGINE_MOSQUITO_LEFT02),
        unit(Squad.SQ_ENGINE_MOSQUITO_RIGHT01, Slot.SQ_ENGINE_MOSQUITO_RIGHT01),
        unit(Squad.SQ_ENGINE_MOSQUITO_RIGHT02, Slot.SQ_ENGINE_MOSQUITO_RIGHT02),
        unit(Squad.SQ_ENGINE_MOSQUITO_RIGHT03, Slot.SQ_ENGINE_MOSQUITO_RIGHT03),
    },
}

local goliath = {
    id = "goliath",
    after = "goliath",
    squads = {unit(Squad.SQ_ENGINE_GOLIATH01, Slot.SQ_ENGINE_GOLIATH01)},
}

local advance = Directive.ADVANCE_TO_THE_RED_LEGION_CARRIER_D2B126C5

return campaign.new{
    key = "thunder",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80B9BF46,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80B9BF46,
    legs = {
        {id = "gorge", state = mission.states.STATE_80B9BE52_0023_0000_80B9BE6D, arm = {
            Slot.PLAYER_TRIGGER_80BDB0D6,
        }},
        {id = "tunnels", state = mission.states.STATE_80B9BE52_003D_0000_80B9BF5D, arm = {
            Slot.PT_INTRO_PSION01, Slot.PLAYER_TRIGGER_80BDB875, Slot.PT_NUX, Slot.PT_CYLINDER,
            Slot.PT_DOOR_80BDA22D, Slot.PLAYER_TRIGGER_80BDB856, Slot.PT_RAMPS,
            Slot.PT_THUNDER_TUNNELS_BRIDGE01, Slot.PT_BRIDGE_80BDA22D,
            Slot.PLAYER_TRIGGER_80BDB839, Slot.PLAYER_TRIGGER_80BDB864,
        }},
        {id = "islands", state = mission.states.STATE_80B9BE52_0027_0000_80B9BF39, arm = {
            Slot.PLAYER_TRIGGER_80BDB300, Slot.PT_CORE1, Slot.PT_CORE2,
            Slot.PT_ISLANDS_025_DIALOG,
        }},
    },
    steps = {
        {id = "gorge", directive = Directive.GET_TO_THE_SHIPYARDS_IN_THE_RED_LEGION_BASE_B1DC86E7,
            navpoint = Slot.NAV_POINT_80BDB0D6,
            ends = {trigger = Slot.PLAYER_TRIGGER_80BDB0D6}},
        {id = "holliday", directive = Directive.GET_TO_THE_SHIPYARDS_IN_THE_RED_LEGION_BASE,
            navpoint = Slot.NAV_POINT_80BDB875,
            ends = {trigger = Slot.PLAYER_TRIGGER_80BDB875}},
        -- Holliday: "Holler my way if you need another one of these armored beauties."
        {id = "force", directive = advance, navpoint = Slot.SLOT_0019_80BDB856,
            lines = {line(cue.CUE_18)},
            ends = {trigger = Slot.PT_DOOR_80BDA22D}},
        -- "Don't think we're going to be able to shoot our way through that door."
        {id = "door", directive = Directive.ADVANCE_TO_THE_RED_LEGION_CARRIER_83ACFCA2,
            navpoint = Slot.SLOT_001A_80BDB856,
            lines = {line(cue.CUE_22), line(cue.CUE_23)},
            ends = {interact = Slot.O_TUNNELS_THUNDER_BARRIER_SWITCH}},
        -- "Heads up! That carrier's spinning up its engines."
        {id = "carrier", directive = advance, navpoint = Slot.NAV_POINT_80BDB856,
            lines = {line(cue.CUE_25)},
            on_start = function(context)
                move(context, {Slot.D_TUNNELS_THUNDER_BARRIER01, Slot.D_TUNNELS_THUNDER_BARRIER02,
                    Slot.D_TUNNELS_DOOR_DOOR01, Slot.D_TUNNELS_DOOR_DOOR02,
                    Slot.D_TUNNELS_DOOR_DOOR03}, "open")
                move(context, {Slot.D_TUNNELS_DOOR_HOLO}, "power_on")
            end,
            ends = {trigger = Slot.PLAYER_TRIGGER_80BDB856}},
        -- "Of course the Red Legion have tanks too."
        {id = "ramps", directive = Directive.ADVANCE_TO_THE_RED_LEGION_CARRIER_433D7F22,
            navpoint = Slot.SLOT_0010_80BDB82E,
            lines = {line(cue.CUE_26, Slot.TV_TUNNELS_037_DIALOG)},
            ends = {trigger = Slot.PT_THUNDER_TUNNELS_BRIDGE01}},
        -- "They've retracted the bridge." "Let's find the control room."
        {id = "bridge", directive = Directive.ADVANCE_TO_THE_RED_LEGION_CARRIER_4013DBF9,
            navpoint = Slot.SLOT_0011_80BDB82E,
            lines = {line(cue.CUE_27), line(cue.CUE_28)},
            ends = {interact = Slot.O_TUNNELS_THUNDER_BRIDGE_SWITCH}},
        -- "That should give us a way across."
        {id = "across", directive = Directive.ADVANCE_TO_THE_RED_LEGION_CARRIER_EDED4747,
            navpoint = Slot.NAV_POINT_80BDB839, lines = {line(cue.CUE_29)},
            on_start = function(context)
                move(context, {Slot.D_TUNNELS_THUNDER_BRIDGE_LEVER,
                    Slot.D_TUNNELS_THUNDER_BRIDGE_LIGHTS}, "power_on")
                move(context, {Slot.D_TUNNELS_THUNDER_BRIDGE01, Slot.D_TUNNELS_THUNDER_BRIDGE02},
                    "open")
            end,
            ends = {trigger = Slot.PLAYER_TRIGGER_80BDB839}},
        -- "We're almost out of the tunnels and coming up on the carrier."
        {id = "exit", directive = Directive.ADVANCE_TO_THE_RED_LEGION_CARRIER_840D405D,
            navpoint = Slot.NAV_POINT_80BDB864,
            lines = {line(cue.CUE_30, Slot.TV_TUNNELS_100_DIALOG_80BDB864)},
            ends = {trigger = Slot.PLAYER_TRIGGER_80BDB864}},
        {id = "islands", directive = Directive.ADVANCE_TO_THE_RED_LEGION_CARRIER,
            navpoint = Slot.NAV_POINT_80BDB300,
            ends = {trigger = Slot.PLAYER_TRIGGER_80BDB300}},
        -- "They're shielding the carrier!" "See those generators?"
        {id = "generators", directive = Directive.DISABLE_THE_RED_LEGION_CARRIER_S_SHIELD,
            navpoint = Slot.SLOT_000B_80BDB2E9,
            lines = {line(cue.CUE_32), line(cue.CUE_33, Slot.SLOT_0005_80BDB2E9)},
            ends = {destroyed = {
                Slot.CABAL_ISLANDS_SHIELD_GEN_DAMAGEABLE_1_SHIELD_GEN_CORE_OBJECT,
                Slot.CABAL_ISLANDS_SHIELD_GEN_DAMAGEABLE_2_SHIELD_GEN_CORE_OBJECT,
            }}},
        -- "Shield's down, but the ship's about to launch without us!"
        {id = "goliath", directive = Directive.GROUND_THE_RED_LEGION_CARRIER,
            navpoint = Slot.SLOT_0001_80BDB2F2, lines = {line(cue.CUE_36)},
            ends = {clear = "goliath"}},
        {id = "conduit", directive = Directive.GROUND_THE_RED_LEGION_CARRIER_51DBEF21,
            navpoint = Slot.ENGINE_ACTIVITYPOINT,
            ends = {destroyed = {Slot.SPECOPS_ISLANDS_ENGINE_O_WEAKPOINT}}},
        -- "The carrier's grounded. Now let's find Thumos."
        {id = "grounded", lines = {line(cue.CUE_37)}},
    },
    encounters = {intro, nux, cylinder, door, ramps, bridge, core1, core2, engine, goliath},
}
