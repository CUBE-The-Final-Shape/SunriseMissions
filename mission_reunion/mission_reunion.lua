-- Chosen. Red War campaign draft; not tested in game.
-- Leg order: gavel -> judge -> jury, from the transition spawn sets gavel_to_judge and
-- judge_to_jury. Steps follow the step objects, their lines and the trigger volume positions:
-- two barriers Hawthorne drops, the rooftops and the portal, Ghaul's ship, then his three phases.
local missions = require("missions")
local mission = require(missions.MISSION_REUNION)
local campaign = require("lib.campaign")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive = mission.Slot, mission.Squad, mission.Directive
local cue = mission.DialogueCue.M_DIALOG_SENSOR_80B6244E

local rooftops = {
    id = "rooftops",
    trigger = Slot.ROOFTOPS_FIRST_SET_LEFT_PLAYER_TRIGGER,
    objective = Slot.REUNION_JUDGE_ROOFTOPS_OBJECTIVE,
    squads = {
        unit(Squad.ROOFTOPS_HELIPAD_ANCHOR_A_SQUAD, Slot.ROOFTOPS_HELIPAD_ANCHOR_A_SQUAD),
        unit(Squad.ROOFTOPS_HELIPAD_DROPSHIP_A_SQUAD, Slot.ROOFTOPS_HELIPAD_DROPSHIP_A_SQUAD),
        unit(Squad.ROOFTOPS_HELIPAD_SUPPORT_A_SQUAD, Slot.ROOFTOPS_HELIPAD_SUPPORT_A_SQUAD),
        unit(Squad.ROOFTOPS_HELIPAD_SUPPORT_B_SQUAD, Slot.ROOFTOPS_HELIPAD_SUPPORT_B_SQUAD),
        unit(Squad.ROOFTOPS_HELIPAD_SUPPORT_C_SQUAD, Slot.ROOFTOPS_HELIPAD_SUPPORT_C_SQUAD),
        unit(Squad.ROOFTOPS_HELIPAD_SUPPORT_D_SQUAD, Slot.ROOFTOPS_HELIPAD_SUPPORT_D_SQUAD),
        unit(Squad.ROOFTOPS_GARDEN_SUPPORT_A_SQUAD, Slot.ROOFTOPS_GARDEN_SUPPORT_A_SQUAD),
        unit(Squad.ROOFTOP_BARRELS_BONUS_SQUAD, Slot.ROOFTOP_BARRELS_BONUS_SQUAD),
        unit(Squad.ROOFTOPS_SCHELL_SUPPORT_A_SQUAD, Slot.ROOFTOPS_SCHELL_SUPPORT_A_SQUAD),
        unit(Squad.ROOFTOPS_SCHELL_SUPPORT_B_SQUAD, Slot.ROOFTOPS_SCHELL_SUPPORT_B_SQUAD),
        unit(Squad.SQUAD_CABAL_PUNCHER, Slot.SQUAD_CABAL_PUNCHER),
        unit(Squad.SQUAD_CABAL_RUNUP_1, Slot.SQUAD_CABAL_RUNUP_1),
        unit(Squad.SQUAD_CABAL_RUNUP_2, Slot.SQUAD_CABAL_RUNUP_2),
        unit(Squad.SQUAD_CABAL_RUNUP_3, Slot.SQUAD_CABAL_RUNUP_3),
        unit(Squad.SQUAD_EXPLODING_CABAL, Slot.SQUAD_EXPLODING_CABAL),
        unit(Squad.SQUAD_DROPSHIP, Slot.SQUAD_DROPSHIP),
        unit(Squad.SQUAD_FAKE_DROPSHIP, Slot.SQUAD_FAKE_DROPSHIP),
        unit(Squad.SQUAD_MOSQUITO_1, Slot.SQUAD_MOSQUITO_1),
    },
}

-- Zavala, Ikora and Cayde hold the far rooftop with the teleporter.
local vanguard = {
    id = "vanguard",
    trigger = Slot.ROOFTOPS_GUARDIAN_TRIO_VIGNETTE_START_PT,
    objective = Slot.REUNION_JUDGE_ROOFTOPS_OBJECTIVE,
    squads = {
        unit(Squad.SQUAD_ZAVALA, Slot.SQUAD_ZAVALA),
        unit(Squad.SQUAD_IKORA, Slot.SQUAD_IKORA),
        unit(Squad.SQUAD_CAYDE, Slot.SQUAD_CAYDE),
    },
}

local kennel = {
    id = "kennel",
    trigger = Slot.KENNEL_ENTRY_PLAYER_TRIGGER,
    objective = Slot.REUNION_JUDGE_KENNEL_OBJECTIVE,
    squads = {
        unit(Squad.KENNEL_MELEE_A_SQUAD, Slot.KENNEL_MELEE_A_SQUAD),
        unit(Squad.KENNEL_MELEE_B_SQUAD, Slot.KENNEL_MELEE_B_SQUAD),
        unit(Squad.KENNEL_MELEE_C_SQUAD, Slot.KENNEL_MELEE_C_SQUAD),
        unit(Squad.KENNEL_MELEE_D_SQUAD, Slot.KENNEL_MELEE_D_SQUAD),
        unit(Squad.KENNEL_MELEE_E_SQUAD, Slot.KENNEL_MELEE_E_SQUAD),
        unit(Squad.KENNEL_ANCHOR_A_SQUAD, Slot.KENNEL_ANCHOR_A_SQUAD),
        unit(Squad.KENNEL_ANCHOR_B_SQUAD, Slot.KENNEL_ANCHOR_B_SQUAD),
    },
}

local colonnade = {
    id = "colonnade",
    trigger = Slot.INTERIOR_ASCENT_EARLY_PLAYER_TRIGGER,
    objective = Slot.REUNION_JURY_INTERIOR_OBJECTIVE,
    squads = {
        unit(Squad.INTERIOR_COLONNADE_ANCHOR_A_SQUAD, Slot.INTERIOR_COLONNADE_ANCHOR_A_SQUAD),
        unit(Squad.INTERIOR_COLONNADE_SUPPORT_A_SQUAD, Slot.INTERIOR_COLONNADE_SUPPORT_A_SQUAD),
        unit(Squad.INTERIOR_COLONNADE_SUPPORT_B_SQUAD, Slot.INTERIOR_COLONNADE_SUPPORT_B_SQUAD),
        unit(Squad.INTERIOR_COLONNADE_DEFENSE_A_SQUAD, Slot.INTERIOR_COLONNADE_DEFENSE_A_SQUAD),
        unit(Squad.INTERIOR_COLONNADE_DEFENSE_B_SQUAD, Slot.INTERIOR_COLONNADE_DEFENSE_B_SQUAD),
    },
}

-- Ghaul and the dropships carry no encounter objective.
local ghaul = {
    id = "ghaul",
    after = "phase_1",
    squads = {
        unit(Squad.GHAUL_SQUAD, Slot.GHAUL_SQUAD),
    },
}

-- A dropship may never report its members gone, so no step waits on it.
local ghaul_ships = {
    id = "ghaul_ships",
    after = "phase_1",
    squads = {
        unit(Squad.DROPSHIP_RIGHT_SQUAD, Slot.DROPSHIP_RIGHT_SQUAD),
        unit(Squad.DROPSHIP_RIGHT_BACK_SQUAD, Slot.DROPSHIP_RIGHT_BACK_SQUAD),
        unit(Squad.DROPSHIP_LEFT_SQUAD, Slot.DROPSHIP_LEFT_SQUAD),
        unit(Squad.DROPSHIP_LEFT_BACK_SQUAD, Slot.DROPSHIP_LEFT_BACK_SQUAD),
    },
}

local phase_1 = {
    id = "phase_1",
    after = "phase_1",
    objective = Slot.REUNION_JUDGE_ARENA_PHASE_1_OBJECTIVE,
    squads = {
        unit(Squad.PHASE_1_100_SUPPORT_A_SQUAD, Slot.PHASE_1_100_SUPPORT_A_SQUAD),
        unit(Squad.PHASE_1_90_SUPPORT_A_SQUAD, Slot.PHASE_1_90_SUPPORT_A_SQUAD),
        unit(Squad.PHASE_1_90_SUPPORT_B_SQUAD, Slot.PHASE_1_90_SUPPORT_B_SQUAD),
        unit(Squad.PHASE_1_80_SUPPORT_A_SQUAD, Slot.PHASE_1_80_SUPPORT_A_SQUAD),
        unit(Squad.PHASE_1_80_SUPPORT_B_SQUAD, Slot.PHASE_1_80_SUPPORT_B_SQUAD),
        unit(Squad.PHASE_1_70_SUPPORT_A_SQUAD, Slot.PHASE_1_70_SUPPORT_A_SQUAD),
        unit(Squad.PHASE_1_70_SUPPORT_B_SQUAD, Slot.PHASE_1_70_SUPPORT_B_SQUAD),
    },
}

local phase_2 = {
    id = "phase_2",
    after = "phase_2",
    objective = Slot.REUNION_JUDGE_ARENA_PHASE_2_OBJECTIVE,
    squads = {
        unit(Squad.PHASE_2_60_SUPPORT_A_SQUAD, Slot.PHASE_2_60_SUPPORT_A_SQUAD),
        unit(Squad.PHASE_2_60_SUPPORT_B_SQUAD, Slot.PHASE_2_60_SUPPORT_B_SQUAD),
        unit(Squad.PHASE_2_50_SUPPORT_A_SQUAD, Slot.PHASE_2_50_SUPPORT_A_SQUAD),
        unit(Squad.PHASE_2_50_SUPPORT_B_SQUAD, Slot.PHASE_2_50_SUPPORT_B_SQUAD),
        unit(Squad.PHASE_2_40_SUPPORT_A_SQUAD, Slot.PHASE_2_40_SUPPORT_A_SQUAD),
        unit(Squad.PHASE_2_40_SUPPORT_B_SQUAD, Slot.PHASE_2_40_SUPPORT_B_SQUAD),
    },
}

local phase_3 = {
    id = "phase_3",
    after = "phase_3",
    objective = Slot.REUNION_JUDGE_ARENA_PHASE_3_OBJECTIVE,
    squads = {
        unit(Squad.PHASE_3_30_SUPPORT_A_SQUAD, Slot.PHASE_3_30_SUPPORT_A_SQUAD),
        unit(Squad.PHASE_3_30_SUPPORT_B_SQUAD, Slot.PHASE_3_30_SUPPORT_B_SQUAD),
        unit(Squad.PHASE_3_20_SUPPORT_A_SQUAD, Slot.PHASE_3_20_SUPPORT_A_SQUAD),
        unit(Squad.PHASE_3_20_SUPPORT_B_SQUAD, Slot.PHASE_3_20_SUPPORT_B_SQUAD),
    },
}

local hold = Directive.RENDEZVOUS_WITH_THE_VANGUARD_6CC87F2A
local press = Directive.RENDEZVOUS_WITH_THE_VANGUARD
local way_out = Directive.SAVE_THE_TRAVELER

return campaign.new{
    key = "reunion",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80B6244E,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80B6244E,
    legs = {
        {id = "gavel", state = mission.states.STATE_80B62030_0000_0000_80B62024, arm = {
            Slot.GAVEL_INTERSECTION_GOTO_PLAYER_TRIGGER, Slot.GAVEL_030_DIALOG_PLAYER_TRIGGER,
            Slot.GAVEL_ARENA_1_ENTRY_PLAYER_TRIGGER, Slot.GAVEL_040_DIALOG_PLAYER_TRIGGER,
            Slot.GAVEL_ARENA_1_EXIT_PLAYER_TRIGGER, Slot.GAVEL_ARENA_2_EXIT_PLAYER_TRIGGER,
        }},
        {id = "judge", state = mission.states.STATE_80B62030_0001_0000_80B62026, arm = {
            Slot.ROOFTOPS_FIRST_SET_LEFT_PLAYER_TRIGGER,
            Slot.ROOFTOPS_GUARDIAN_TRIO_VIGNETTE_START_PT, Slot.PT_PLAY_PRE_VIGNETTE_DIALOG,
            Slot.JUDGE_ROOFTOP_TELEPORT_START_PLAYER_TRIGGER, Slot.KENNEL_ENTRY_PLAYER_TRIGGER,
            Slot.JUDGE_SHIP_KENNEL_EXIT_PLAYER_TRIGGER,
        }},
        {id = "jury", state = mission.states.STATE_80B62030_0002_0000_80B62027, arm = {
            Slot.INTERIOR_ASCENT_EARLY_PLAYER_TRIGGER, Slot.JURY_SHIP_INTERIOR_EXIT_PLAYER_TRIGGER,
            Slot.JURY_SHIP_EXTERIOR_EXIT_PLAYER_TRIGGER,
        }},
    },
    steps = {
        -- "Guardian! Are you still with us?"
        {id = "ruins", directive = Directive.RENDEZVOUS_WITH_THE_VANGUARD_CF65C5DF,
            navpoint = Slot.SLOT_001D_80B62265, lines = {line(cue.CUE_0)},
            ends = {trigger = Slot.GAVEL_INTERSECTION_GOTO_PLAYER_TRIGGER}},
        {id = "barrier_1", directive = hold, navpoint = Slot.SLOT_001C_80B62265,
            ends = {trigger = Slot.GAVEL_030_DIALOG_PLAYER_TRIGGER}},
        -- "Power's down! Go, before the Legion turns it back on!"
        {id = "press_1", directive = press, navpoint = Slot.GAVEL_ARENA_1_ENTRY_NAV_POINT,
            lines = {line(cue.CUE_5)},
            on_start = function(context) move(context, {Slot.BARRIER_1_DEVICE}, "open") end,
            ends = {trigger = Slot.GAVEL_ARENA_1_ENTRY_PLAYER_TRIGGER}},
        -- "We're through." Then "Hawthorne, we're blocked again."
        {id = "barrier_2", directive = hold, navpoint = Slot.SLOT_0019_80B62237,
            lines = {line(cue.CUE_8), line(cue.CUE_9, Slot.SLOT_001C_80B62237)},
            ends = {trigger = Slot.GAVEL_040_DIALOG_PLAYER_TRIGGER}},
        -- "Move it. Barrier's down!" Then Cayde is flanked at the teleporter.
        {id = "press_2", directive = press, navpoint = Slot.GAVEL_ARENA_1_EXIT_NAV_POINT,
            lines = {line(cue.CUE_10), line(cue.CUE_14)},
            on_start = function(context) move(context, {Slot.BARRIER_2_DEVICE}, "open") end,
            ends = {trigger = Slot.GAVEL_ARENA_1_EXIT_PLAYER_TRIGGER}},
        {id = "ruins_2", directive = Directive.RENDEZVOUS_WITH_THE_VANGUARD_DF9E33B5,
            navpoint = Slot.GAVEL_ARENA_2_EXIT_NAV_POINT,
            ends = {trigger = Slot.GAVEL_ARENA_2_EXIT_PLAYER_TRIGGER}},
        -- "Ikora and I have reached the rally point, but Cayde is still wrestling with it."
        {id = "rally", directive = Directive.RENDEZVOUS_WITH_THE_VANGUARD_7EF1F8E7,
            navpoint = Slot.JUDGE_BUBBLE_GOTO_NAV_POINT, lines = {line(cue.CUE_18)},
            ends = {region = "judge"}},
        -- The Traveler, then Zavala's farewell, then Cayde at the teleporter.
        {id = "rooftops", directive = Directive.RENDEZVOUS_WITH_THE_VANGUARD_91FFFCBC,
            navpoint = Slot.JUDGE_ROOFTOP_TELEPORT_START_NAV_POINT,
            lines = {line(cue.CUE_19, Slot.SLOT_001C_80B625B8),
                line(cue.CUE_23, Slot.SLOT_0007_80B625B8),
                line(cue.CUE_26, Slot.SLOT_0009_80B625B8)},
            ends = {trigger = Slot.PT_PLAY_PRE_VIGNETTE_DIALOG}},
        -- "We can't make the jump. It's all on you now." "For the Vanguard, and the Traveler."
        {id = "portal", directive = Directive.SAVE_THE_TRAVELER_976805BB,
            navpoint = Slot.JUDGE_ROOFTOP_TELEPORT_START_NAV_POINT,
            lines = {line(cue.CUE_31), line(cue.CUE_33)},
            on_start = function(context)
                move(context, {Slot.D_TELEPORTER_FX_OBJECT, Slot.D_TELEPORTER_LIGHT}, "power_on")
            end,
            ends = {trigger = Slot.JUDGE_ROOFTOP_TELEPORT_START_PLAYER_TRIGGER}},
        -- "You're on Ghaul's command ship. Be brave. For all of us."
        {id = "kennel", directive = way_out, navpoint = Slot.KENNEL_AWAKEN_A_NAV_POINT,
            lines = {line(cue.CUE_39)},
            on_start = function(context) move(context, {Slot.KENNEL_ENTRY_DOOR_DEVICE}, "open") end,
            ends = {clear = "kennel"}},
        {id = "airlock", directive = Directive.SAVE_THE_TRAVELER_D02E986A,
            navpoint = Slot.JUDGE_SHIP_KENNEL_EXIT_NAV_POINT,
            on_start = function(context)
                move(context, {Slot.KENNEL_AIRLOCK_DOOR_DEVICE}, "open")
            end,
            ends = {trigger = Slot.JUDGE_SHIP_KENNEL_EXIT_PLAYER_TRIGGER}},
        {id = "out", directive = Directive.SAVE_THE_TRAVELER_24529118,
            navpoint = Slot.JURY_BUBBLE_GOTO_NAV_POINT,
            ends = {region = "jury"}},
        -- "There's the Traveler. We're getting close."
        {id = "interior", directive = Directive.SAVE_THE_TRAVELER_4E75A426,
            navpoint = Slot.JURY_SHIP_INTERIOR_EXIT_NAV_POINT,
            lines = {line(cue.CUE_47, Slot.JURY_015_DIALOG_TRIGGER_VOLUME)},
            on_start = function(context)
                move(context, {Slot.INTERIOR_ELEVATOR_DEVICE}, "open")
            end,
            ends = {trigger = Slot.JURY_SHIP_INTERIOR_EXIT_PLAYER_TRIGGER}},
        -- "It can't be..."
        {id = "prepare", directive = Directive.DEFEAT_GHAUL_D85F9098,
            navpoint = Slot.JURY_SHIP_EXTERIOR_EXIT_NAV_POINT,
            lines = {line(cue.CUE_52, Slot.SLOT_0003_80B62824)},
            ends = {trigger = Slot.JURY_SHIP_EXTERIOR_EXIT_PLAYER_TRIGGER}},
        -- "You won't escape me again!" "Your Traveler should have chosen me."
        {id = "phase_1", directive = Directive.DEFEAT_GHAUL,
            navpoint = Slot.JURY_ARENA_PHONE_BOOTH_NAV_POINT_80B62804,
            lines = {line(cue.CUE_58), line(cue.CUE_61)},
            on_start = function(context)
                move(context, {Slot.TRAVELER_CAGE_DEVICE, Slot.PHONE_BOOTH_DEVICE,
                    Slot.WELL_OF_LIGHT_ENTRY_LEFT_SCRIPT_PREFAB_WELL_OF_LIGHT_DEVICE,
                    Slot.WELL_OF_LIGHT_ENTRY_RIGHT_SCRIPT_PREFAB_WELL_OF_LIGHT_DEVICE,
                    Slot.WELL_OF_LIGHT_PIT_LEFT_BACK_SCRIPT_PREFAB_WELL_OF_LIGHT_DEVICE,
                    Slot.WELL_OF_LIGHT_PIT_LEFT_FRONT_SCRIPT_PREFAB_WELL_OF_LIGHT_DEVICE,
                    Slot.WELL_OF_LIGHT_PIT_RIGHT_BACK_SCRIPT_PREFAB_WELL_OF_LIGHT_DEVICE,
                    Slot.WELL_OF_LIGHT_PIT_RIGHT_FRONT_SCRIPT_PREFAB_WELL_OF_LIGHT_DEVICE},
                    "power_on")
            end,
            ends = {clear = "phase_1"}},
        -- "More... I need more." "You failed your Traveler."
        {id = "phase_2", directive = Directive.DEFEAT_GHAUL_6A16FA25,
            navpoint = Slot.JURY_ARENA_PHONE_BOOTH_NAV_POINT_80B6280B,
            lines = {line(cue.CUE_73), line(cue.CUE_62)},
            ends = {clear = "phase_2"}},
        -- "THE LIGHT!" "I pity you."
        {id = "phase_3", directive = Directive.DEFEAT_GHAUL_FBBEAA0A,
            navpoint = Slot.JURY_ARENA_PHONE_BOOTH_NAV_POINT_80B62812,
            lines = {line(cue.CUE_75), line(cue.CUE_65)},
            ends = {clear = {"phase_3", "ghaul"}}},
        -- "No. Nooooooo!"
        {id = "fall", lines = {line(cue.CUE_81)}},
    },
    encounters = {
        rooftops, vanguard, kennel, colonnade, ghaul, ghaul_ships, phase_1, phase_2, phase_3,
    },
}
