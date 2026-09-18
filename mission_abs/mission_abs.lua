-- The Gateway. Ported from the Dawn fork's step graph; not tested in game.
-- One leg, region 120. The player lands on the Mercury shelf, clears three platforms to the
-- Lighthouse, finds the Forest gate shut, defends the Lighthouse and meets Brother Vance.
-- Dawn read the player's position out of the client to decide the volumes. Here each volume is
-- an armed player trigger or a watched player monitor, so the client reports it.
local missions = require("missions")
local mission = require(missions.MISSION_ABS)
local campaign = require("lib.campaign")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive, Scene = mission.Slot, mission.Squad, mission.Directive, mission.Scene
local cue = mission.DialogueCue.M_DIALOG_SENSOR_80F4742C

-- The Vex column crossing the shelf. It is dressed, not fought, so it carries no objective and
-- never counts toward a clear. Its march comes from the authored actors, not from the host.
local marchers = {
    id = "marchers",
    squads = {
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_A_CENTER_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_A_CENTER_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_A_CENTER_FRONT_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_A_CENTER_FRONT_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_A_LEFT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_A_LEFT_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_A_RIGHT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_A_RIGHT_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_B_CENTER_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_B_CENTER_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_B_CENTER_FRONT_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_B_CENTER_FRONT_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_B_LEFT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_B_LEFT_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_B_RIGHT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_B_RIGHT_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_C_CENTER_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_C_CENTER_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_C_CENTER_FRONT_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_C_CENTER_FRONT_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_C_LEFT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_C_LEFT_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_C_RIGHT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_C_RIGHT_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_D_CENTER_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_D_CENTER_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_D_CENTER_FRONT_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_D_CENTER_FRONT_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_D_LEFT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_D_LEFT_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_D_RIGHT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_D_RIGHT_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_E_CENTER_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_E_CENTER_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_E_CENTER_FRONT_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_E_CENTER_FRONT_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_E_LEFT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_E_LEFT_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_E_RIGHT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_E_RIGHT_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_F_CENTER_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_F_CENTER_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_F_CENTER_FRONT_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_F_CENTER_FRONT_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_F_LEFT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_F_LEFT_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_F_RIGHT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_F_RIGHT_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_G_CENTER_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_G_CENTER_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_G_CENTER_FRONT_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_G_CENTER_FRONT_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_G_LEFT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_G_LEFT_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_G_RIGHT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_G_RIGHT_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_H_CENTER_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_H_CENTER_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_H_CENTER_FRONT_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_H_CENTER_FRONT_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_H_LEFT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_H_LEFT_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_H_RIGHT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_H_RIGHT_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_I_CENTER_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_I_CENTER_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_I_CENTER_FRONT_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_I_CENTER_FRONT_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_I_LEFT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_I_LEFT_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_I_RIGHT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_I_RIGHT_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_J_CENTER_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_J_CENTER_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_J_CENTER_FRONT_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_J_CENTER_FRONT_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_J_LEFT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_J_LEFT_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_J_RIGHT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_J_RIGHT_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_K_CENTER_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_K_CENTER_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_K_CENTER_FRONT_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_K_CENTER_FRONT_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_K_LEFT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_K_LEFT_BACK_SQUAD),
        unit(Squad.VEX_MARCHING_WITH_PHASE_BLOCKS_K_RIGHT_BACK_SQUAD,
             Slot.VEX_MARCHING_WITH_PHASE_BLOCKS_K_RIGHT_BACK_SQUAD),
    },
}

-- First platform. The reinforcement wave comes in when the player reaches its own monitor.
local recess = {
    id = "recess",
    trigger = Slot.LEADUP_RECESS_ENCOUNTER_START_PLAYER_TRIGGER,
    objective = Slot.LEADUP_RECESS_OBJECTIVE,
    squads = {
        unit(Squad.LEADUP_RECESS_ANCHOR_A_SQUAD, Slot.LEADUP_RECESS_ANCHOR_A_SQUAD),
        unit(Squad.LEADUP_RECESS_SUPPORT_A_A_SQUAD, Slot.LEADUP_RECESS_SUPPORT_A_A_SQUAD),
        unit(Squad.LEADUP_RECESS_SUPPORT_A_B_SQUAD, Slot.LEADUP_RECESS_SUPPORT_A_B_SQUAD),
        unit(Squad.LEADUP_RECESS_SUPPORT_A_C_SQUAD, Slot.LEADUP_RECESS_SUPPORT_A_C_SQUAD),
        unit(Squad.LEADUP_RECESS_SUPPORT_B_A_SQUAD, Slot.LEADUP_RECESS_SUPPORT_B_A_SQUAD),
        unit(Squad.LEADUP_RECESS_SUPPORT_B_B_SQUAD, Slot.LEADUP_RECESS_SUPPORT_B_B_SQUAD),
        unit(Squad.LEADUP_RECESS_SUPPORT_B_C_SQUAD, Slot.LEADUP_RECESS_SUPPORT_B_C_SQUAD),
    },
}

local recess_reinforce = {
    id = "recess_reinforce",
    monitor = Slot.LEADUP_RECESS_REINFORCE_PLAYER_MONITOR,
    objective = Slot.LEADUP_RECESS_OBJECTIVE,
    squads = {
        unit(Squad.LEADUP_RECESS_SUPPORT_C_SQUAD, Slot.LEADUP_RECESS_SUPPORT_C_SQUAD),
    },
}

-- Second platform.
local shelf = {
    id = "shelf",
    trigger = Slot.LEADUP_SHELF_ENTRY_PLAYER_TRIGGER,
    objective = Slot.LEADUP_SHELF_OBJECTIVE,
    squads = {
        unit(Squad.LEADUP_SHELF_MELEE_A_A_SQUAD, Slot.LEADUP_SHELF_MELEE_A_A_SQUAD),
        unit(Squad.LEADUP_SHELF_MELEE_A_B_SQUAD, Slot.LEADUP_SHELF_MELEE_A_B_SQUAD),
        unit(Squad.LEADUP_SHELF_MELEE_A_C_SQUAD, Slot.LEADUP_SHELF_MELEE_A_C_SQUAD),
        unit(Squad.LEADUP_SHELF_MELEE_B_A_SQUAD, Slot.LEADUP_SHELF_MELEE_B_A_SQUAD),
        unit(Squad.LEADUP_SHELF_MELEE_B_B_SQUAD, Slot.LEADUP_SHELF_MELEE_B_B_SQUAD),
        unit(Squad.LEADUP_SHELF_MELEE_B_C_SQUAD, Slot.LEADUP_SHELF_MELEE_B_C_SQUAD),
        unit(Squad.LEADUP_SHELF_SUPPORT_A_SQUAD, Slot.LEADUP_SHELF_SUPPORT_A_SQUAD),
        unit(Squad.LEADUP_SHELF_SUPPORT_B_SQUAD, Slot.LEADUP_SHELF_SUPPORT_B_SQUAD),
    },
}

local shelf_reinforce = {
    id = "shelf_reinforce",
    monitor = Slot.LEADUP_SHELF_REINFORCE_PLAYER_MONITOR,
    objective = Slot.LEADUP_SHELF_OBJECTIVE,
    squads = {
        unit(Squad.LEADUP_SHELF_MELEE_C_SQUAD, Slot.LEADUP_SHELF_MELEE_C_SQUAD),
        unit(Squad.LEADUP_SHELF_MELEE_D_SQUAD, Slot.LEADUP_SHELF_MELEE_D_SQUAD),
    },
}

-- Third platform, the one the last man cannon leaves from.
local platform_end = {
    id = "platform_end",
    trigger = Slot.LEADUP_END_COMMIT_PLAYER_TRIGGER,
    objective = Slot.LEADUP_END_OBJECTIVE,
    squads = {
        unit(Squad.LEADUP_END_ANCHOR_A_SQUAD, Slot.LEADUP_END_ANCHOR_A_SQUAD),
        unit(Squad.LEADUP_END_RANGED_A_SQUAD, Slot.LEADUP_END_RANGED_A_SQUAD),
        unit(Squad.LEADUP_END_RANGED_B_SQUAD, Slot.LEADUP_END_RANGED_B_SQUAD),
    },
}

local end_reinforce = {
    id = "end_reinforce",
    trigger = Slot.LEADUP_END_REINFORCE_PLAYER_TRIGGER,
    objective = Slot.LEADUP_END_OBJECTIVE,
    squads = {
        unit(Squad.LEADUP_END_SUPPORT_A_SQUAD, Slot.LEADUP_END_SUPPORT_A_SQUAD),
        unit(Squad.LEADUP_END_SUPPORT_B_SQUAD, Slot.LEADUP_END_SUPPORT_B_SQUAD),
    },
}

-- The approach to the Lighthouse. Both groups stand before the player lands.
local outskirts = {
    id = "outskirts",
    after = "cannon",
    objective = Slot.GATE_GOTO_OUTSKIRTS_OBJECTIVE,
    squads = {
        unit(Squad.GATE_GOTO_OUTSKIRTS_EAST_SUPPORT_A_SQUAD,
             Slot.GATE_GOTO_OUTSKIRTS_EAST_SUPPORT_A_SQUAD),
        unit(Squad.GATE_GOTO_OUTSKIRTS_EAST_SUPPORT_B_SQUAD,
             Slot.GATE_GOTO_OUTSKIRTS_EAST_SUPPORT_B_SQUAD),
        unit(Squad.GATE_GOTO_OUTSKIRTS_EAST_SUPPORT_C_SQUAD,
             Slot.GATE_GOTO_OUTSKIRTS_EAST_SUPPORT_C_SQUAD),
        unit(Squad.GATE_GOTO_OUTSKIRTS_EAST_SUPPORT_D_SQUAD,
             Slot.GATE_GOTO_OUTSKIRTS_EAST_SUPPORT_D_SQUAD),
        unit(Squad.GATE_GOTO_OUTSKIRTS_WEST_SUPPORT_A_SQUAD,
             Slot.GATE_GOTO_OUTSKIRTS_WEST_SUPPORT_A_SQUAD),
        unit(Squad.GATE_GOTO_OUTSKIRTS_WEST_SUPPORT_B_SQUAD,
             Slot.GATE_GOTO_OUTSKIRTS_WEST_SUPPORT_B_SQUAD),
        unit(Squad.GATE_GOTO_OUTSKIRTS_WEST_SUPPORT_C_SQUAD,
             Slot.GATE_GOTO_OUTSKIRTS_WEST_SUPPORT_C_SQUAD),
        unit(Squad.GATE_GOTO_OUTSKIRTS_WEST_SUPPORT_D_SQUAD,
             Slot.GATE_GOTO_OUTSKIRTS_WEST_SUPPORT_D_SQUAD),
    },
}

-- The Hydra holding the Forest gate stands with this group.
local gate_center = {
    id = "gate_center",
    after = "cannon",
    objective = Slot.GATE_GOTO_LIGHTHOUSE_CENTER_OBJECTIVE,
    squads = {
        unit(Squad.GATE_GOTO_LIGHTHOUSE_CENTER_ANCHOR_A_SQUAD,
             Slot.GATE_GOTO_LIGHTHOUSE_CENTER_ANCHOR_A_SQUAD),
        unit(Squad.GATE_GOTO_LIGHTHOUSE_CENTER_SUPPORT_A_SQUAD,
             Slot.GATE_GOTO_LIGHTHOUSE_CENTER_SUPPORT_A_SQUAD),
        unit(Squad.GATE_GOTO_LIGHTHOUSE_CENTER_SUPPORT_B_SQUAD,
             Slot.GATE_GOTO_LIGHTHOUSE_CENTER_SUPPORT_B_SQUAD),
        unit(Squad.GATE_GOTO_LIGHTHOUSE_CENTER_EAST_SUPPORT_A_SQUAD,
             Slot.GATE_GOTO_LIGHTHOUSE_CENTER_EAST_SUPPORT_A_SQUAD),
        unit(Squad.GATE_GOTO_LIGHTHOUSE_CENTER_EAST_SUPPORT_B_SQUAD,
             Slot.GATE_GOTO_LIGHTHOUSE_CENTER_EAST_SUPPORT_B_SQUAD),
        unit(Squad.GATE_GOTO_LIGHTHOUSE_CENTER_EAST_SUPPORT_C_SQUAD,
             Slot.GATE_GOTO_LIGHTHOUSE_CENTER_EAST_SUPPORT_C_SQUAD),
        unit(Squad.GATE_GOTO_LIGHTHOUSE_CENTER_EAST_SUPPORT_D_SQUAD,
             Slot.GATE_GOTO_LIGHTHOUSE_CENTER_EAST_SUPPORT_D_SQUAD),
        unit(Squad.GATE_GOTO_LIGHTHOUSE_CENTER_WEST_SUPPORT_A_SQUAD,
             Slot.GATE_GOTO_LIGHTHOUSE_CENTER_WEST_SUPPORT_A_SQUAD),
        unit(Squad.GATE_GOTO_LIGHTHOUSE_CENTER_WEST_SUPPORT_B_SQUAD,
             Slot.GATE_GOTO_LIGHTHOUSE_CENTER_WEST_SUPPORT_B_SQUAD),
        unit(Squad.GATE_GOTO_LIGHTHOUSE_CENTER_WEST_SUPPORT_C_SQUAD,
             Slot.GATE_GOTO_LIGHTHOUSE_CENTER_WEST_SUPPORT_C_SQUAD),
        unit(Squad.GATE_GOTO_LIGHTHOUSE_CENTER_WEST_SUPPORT_D_SQUAD,
             Slot.GATE_GOTO_LIGHTHOUSE_CENTER_WEST_SUPPORT_D_SQUAD),
    },
}

-- The way back to the Lighthouse after the gate refuses the player.
local return_outskirts = {
    id = "return_outskirts",
    after = "bring_sagira",
    objective = Slot.TOWER_RETURN_OUTSKIRTS_OBJECTIVE,
    squads = {
        unit(Squad.TOWER_RETURN_OUTSKIRTS_EAST_SUPPORT_A_SQUAD,
             Slot.TOWER_RETURN_OUTSKIRTS_EAST_SUPPORT_A_SQUAD),
        unit(Squad.TOWER_RETURN_OUTSKIRTS_EAST_SUPPORT_B_SQUAD,
             Slot.TOWER_RETURN_OUTSKIRTS_EAST_SUPPORT_B_SQUAD),
        unit(Squad.TOWER_RETURN_OUTSKIRTS_EAST_SUPPORT_C_SQUAD,
             Slot.TOWER_RETURN_OUTSKIRTS_EAST_SUPPORT_C_SQUAD),
        unit(Squad.TOWER_RETURN_OUTSKIRTS_EAST_SUPPORT_D_SQUAD,
             Slot.TOWER_RETURN_OUTSKIRTS_EAST_SUPPORT_D_SQUAD),
        unit(Squad.TOWER_RETURN_OUTSKIRTS_EAST_RANGED_A_SQUAD,
             Slot.TOWER_RETURN_OUTSKIRTS_EAST_RANGED_A_SQUAD),
        unit(Squad.TOWER_RETURN_OUTSKIRTS_EAST_RANGED_B_SQUAD,
             Slot.TOWER_RETURN_OUTSKIRTS_EAST_RANGED_B_SQUAD),
        unit(Squad.TOWER_RETURN_OUTSKIRTS_WEST_SUPPORT_A_SQUAD,
             Slot.TOWER_RETURN_OUTSKIRTS_WEST_SUPPORT_A_SQUAD),
        unit(Squad.TOWER_RETURN_OUTSKIRTS_WEST_SUPPORT_B_SQUAD,
             Slot.TOWER_RETURN_OUTSKIRTS_WEST_SUPPORT_B_SQUAD),
        unit(Squad.TOWER_RETURN_OUTSKIRTS_WEST_SUPPORT_C_SQUAD,
             Slot.TOWER_RETURN_OUTSKIRTS_WEST_SUPPORT_C_SQUAD),
        unit(Squad.TOWER_RETURN_OUTSKIRTS_WEST_SUPPORT_D_SQUAD,
             Slot.TOWER_RETURN_OUTSKIRTS_WEST_SUPPORT_D_SQUAD),
        unit(Squad.TOWER_RETURN_OUTSKIRTS_WEST_RANGED_A_SQUAD,
             Slot.TOWER_RETURN_OUTSKIRTS_WEST_RANGED_A_SQUAD),
        unit(Squad.TOWER_RETURN_OUTSKIRTS_WEST_RANGED_B_SQUAD,
             Slot.TOWER_RETURN_OUTSKIRTS_WEST_RANGED_B_SQUAD),
    },
}

local return_center = {
    id = "return_center",
    after = "bring_sagira",
    objective = Slot.TOWER_RETURN_LIGHTHOUSE_CENTER_OBJECTIVE,
    squads = {
        unit(Squad.TOWER_RETURN_LIGHTHOUSE_CENTER_ANCHOR_A_SQUAD,
             Slot.TOWER_RETURN_LIGHTHOUSE_CENTER_ANCHOR_A_SQUAD),
        unit(Squad.TOWER_RETURN_LIGHTHOUSE_CENTER_SUPPORT_A_SQUAD,
             Slot.TOWER_RETURN_LIGHTHOUSE_CENTER_SUPPORT_A_SQUAD),
        unit(Squad.TOWER_RETURN_LIGHTHOUSE_CENTER_SUPPORT_B_SQUAD,
             Slot.TOWER_RETURN_LIGHTHOUSE_CENTER_SUPPORT_B_SQUAD),
        unit(Squad.TOWER_RETURN_LIGHTHOUSE_CENTER_MELEE_A_SQUAD,
             Slot.TOWER_RETURN_LIGHTHOUSE_CENTER_MELEE_A_SQUAD),
        unit(Squad.TOWER_RETURN_LIGHTHOUSE_CENTER_MELEE_B_SQUAD,
             Slot.TOWER_RETURN_LIGHTHOUSE_CENTER_MELEE_B_SQUAD),
        unit(Squad.TOWER_RETURN_LIGHTHOUSE_CENTER_MELEE_C_SQUAD,
             Slot.TOWER_RETURN_LIGHTHOUSE_CENTER_MELEE_C_SQUAD),
        unit(Squad.TOWER_RETURN_LIGHTHOUSE_CENTER_MELEE_D_SQUAD,
             Slot.TOWER_RETURN_LIGHTHOUSE_CENTER_MELEE_D_SQUAD),
        unit(Squad.TOWER_RETURN_LIGHTHOUSE_CENTER_EAST_SUPPORT_A_SQUAD,
             Slot.TOWER_RETURN_LIGHTHOUSE_CENTER_EAST_SUPPORT_A_SQUAD),
        unit(Squad.TOWER_RETURN_LIGHTHOUSE_CENTER_EAST_SUPPORT_B_SQUAD,
             Slot.TOWER_RETURN_LIGHTHOUSE_CENTER_EAST_SUPPORT_B_SQUAD),
        unit(Squad.TOWER_RETURN_LIGHTHOUSE_CENTER_WEST_SUPPORT_A_SQUAD,
             Slot.TOWER_RETURN_LIGHTHOUSE_CENTER_WEST_SUPPORT_A_SQUAD),
        unit(Squad.TOWER_RETURN_LIGHTHOUSE_CENTER_WEST_SUPPORT_B_SQUAD,
             Slot.TOWER_RETURN_LIGHTHOUSE_CENTER_WEST_SUPPORT_B_SQUAD),
    },
}

-- Three waves at the Lighthouse door. Each wave must fall before the next is sent.
local wave_one = {
    id = "wave_one",
    after = "contact",
    objective = Slot.TOWER_FINALE_WAVE_1_OBJECTIVE,
    squads = {
        unit(Squad.TOWER_FINALE_WAVE_1_SUPPORT_A_SQUAD, Slot.TOWER_FINALE_WAVE_1_SUPPORT_A_SQUAD),
        unit(Squad.TOWER_FINALE_WAVE_1_SUPPORT_B_SQUAD, Slot.TOWER_FINALE_WAVE_1_SUPPORT_B_SQUAD),
        unit(Squad.TOWER_FINALE_WAVE_1_SUPPORT_C_SQUAD, Slot.TOWER_FINALE_WAVE_1_SUPPORT_C_SQUAD),
        unit(Squad.TOWER_FINALE_WAVE_1_SUPPORT_D_SQUAD, Slot.TOWER_FINALE_WAVE_1_SUPPORT_D_SQUAD),
    },
}

local wave_two = {
    id = "wave_two",
    after = "wave_two",
    objective = Slot.TOWER_FINALE_WAVE_2_OBJECTIVE,
    squads = {
        unit(Squad.TOWER_FINALE_WAVE_2_MELEE_A_SQUAD, Slot.TOWER_FINALE_WAVE_2_MELEE_A_SQUAD),
        unit(Squad.TOWER_FINALE_WAVE_2_MELEE_B_SQUAD, Slot.TOWER_FINALE_WAVE_2_MELEE_B_SQUAD),
        unit(Squad.TOWER_FINALE_WAVE_2_MELEE_C_SQUAD, Slot.TOWER_FINALE_WAVE_2_MELEE_C_SQUAD),
        unit(Squad.TOWER_FINALE_WAVE_2_RANGED_A_SQUAD, Slot.TOWER_FINALE_WAVE_2_RANGED_A_SQUAD),
        unit(Squad.TOWER_FINALE_WAVE_2_RANGED_B_SQUAD, Slot.TOWER_FINALE_WAVE_2_RANGED_B_SQUAD),
        unit(Squad.TOWER_FINALE_WAVE_2_VIGNETTE_A_SQUAD,
             Slot.TOWER_FINALE_WAVE_2_VIGNETTE_A_SQUAD),
    },
}

-- The Minotaur that guards the module. Its support is a separate group so it never holds the
-- wave open.
local wave_three = {
    id = "wave_three",
    after = "wave_three",
    objective = Slot.TOWER_FINALE_WAVE_3_OBJECTIVE,
    squads = {
        unit(Squad.TOWER_FINALE_WAVE_3_ANCHOR_A_SQUAD, Slot.TOWER_FINALE_WAVE_3_ANCHOR_A_SQUAD),
    },
}

local wave_three_support = {
    id = "wave_three_support",
    after = "wave_three",
    objective = Slot.TOWER_FINALE_WAVE_3_OBJECTIVE,
    squads = {
        unit(Squad.TOWER_FINALE_WAVE_3_SUPPORT_A_SQUAD, Slot.TOWER_FINALE_WAVE_3_SUPPORT_A_SQUAD),
        unit(Squad.TOWER_FINALE_WAVE_3_SUPPORT_B_SQUAD, Slot.TOWER_FINALE_WAVE_3_SUPPORT_B_SQUAD),
        unit(Squad.TOWER_FINALE_WAVE_3_SUPPORT_C_SQUAD, Slot.TOWER_FINALE_WAVE_3_SUPPORT_C_SQUAD),
        unit(Squad.TOWER_FINALE_WAVE_3_SUPPORT_D_SQUAD, Slot.TOWER_FINALE_WAVE_3_SUPPORT_D_SQUAD),
        unit(Squad.TOWER_FINALE_WAVE_3_SUPPORT_F_SQUAD, Slot.TOWER_FINALE_WAVE_3_SUPPORT_F_SQUAD),
        unit(Squad.TOWER_FINALE_WAVE_3_SUPPORT_G_SQUAD, Slot.TOWER_FINALE_WAVE_3_SUPPORT_G_SQUAD),
    },
}

return campaign.new{
    key = "gateway",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80F4742C,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80F4742C,
    legs = {
        {id = "lighthouse", state = mission.states.STATE_80F46DB0_000F_0000_80F46DAB,
            arm = {
                Slot.LEADUP_RECESS_ENCOUNTER_START_PLAYER_TRIGGER,
                Slot.LEADUP_SHELF_ENTRY_PLAYER_TRIGGER,
                Slot.LEADUP_END_COMMIT_PLAYER_TRIGGER,
                Slot.LEADUP_END_REINFORCE_PLAYER_TRIGGER,
                Slot.LEADUP_END_MANCANNON_LANDING_PLAYER_TRIGGER,
                Slot.LIGHTHOUSE_DIRECTIVE_VANCE_MEET_PLAYER_TRIGGER,
                Slot.PT_PLAYER_IN_LIGHTHOUSE,
                Slot.PT_PLAYER_NEAR_VANCE,
            },
            -- Each of these also registers the object that carries its step's map marker.
            watch = {
                Slot.MERCURY_M_ABS_LIGHTHOUSE_010_VO_PLAYER_MONITOR,
                Slot.LEADUP_RECESS_REINFORCE_PLAYER_MONITOR,
                Slot.LEADUP_SHELF_REINFORCE_PLAYER_MONITOR,
                Slot.BATTLE_INTRO_COMMIT_PLAYER_MONITOR,
                Slot.GATE_GOTO_CUBE_STAIRS_TOP_PLAYER_MONITOR,
                Slot.INFINITE_FOREST_ENTRANCE_PLAYER_MONITOR,
                Slot.ABS_LIGHTHOUSE_TOWER_RETURN_PLAYER_MONITOR,
                Slot.TOWER_FINALE_COMMIT_PLAYER_MONITOR,
                Slot.LIGHTHOUSE_DIRECTIVE_VANCE_GOTO_PLAYER_MONITOR,
            }},
    },
    steps = {
        -- Ikora: "There is a Vex gateway near your location."
        {id = "landing", directive = Directive.FIND_A_GATEWAY_INTO_THE_INFINITE_FOREST,
            navpoint = Slot.LIGHTHOUSE_DIRECTIVE_TOWER_GOTO_LEADUP_END_NAV_POINT,
            lines = {line(cue.CUE_1)},
            ends = {trigger = Slot.LEADUP_RECESS_ENCOUNTER_START_PLAYER_TRIGGER}},
        {id = "recess", directive = Directive.FIND_A_GATEWAY_INTO_THE_INFINITE_FOREST,
            ends = {clear = {"recess", "recess_reinforce"}}},
        -- The two man cannons open together once the first platform is clear.
        {id = "shelf", directive = Directive.FIND_A_GATEWAY_INTO_THE_INFINITE_FOREST,
            on_start = function(context)
                move(context, {Slot.LEADUP_COLLAPSE_EXIT_MANCANNON_DEVICE,
                    Slot.LEADUP_RECESS_EXIT_MANCANNON_DEVICE}, "open")
            end,
            ends = {clear = {"shelf", "shelf_reinforce"}}},
        {id = "platform_end", directive = Directive.FIND_A_GATEWAY_INTO_THE_INFINITE_FOREST,
            ends = {clear = {"platform_end", "end_reinforce"}}},
        -- Vance greets the player as the last cannon opens, and it throws them to the mainland.
        {id = "cannon", directive = Directive.FIND_A_GATEWAY_INTO_THE_INFINITE_FOREST,
            lines = {line(cue.CUE_2)},
            on_start = function(context)
                move(context, {Slot.LEADUP_SHELF_EXIT_MANCANNON_DEVICE}, "open")
            end,
            ends = {trigger = Slot.LEADUP_END_MANCANNON_LANDING_PLAYER_TRIGGER}},
        {id = "forest_goal", directive = Directive.FIND_A_GATEWAY_INTO_THE_INFINITE_FOREST_F7A5BB63,
            navpoint = Slot.INFINITE_FOREST_ENTRANCE_PULSE_NAV_POINT,
            ends = {monitor = Slot.BATTLE_INTRO_COMMIT_PLAYER_MONITOR}},
        -- "The gateway to the Infinite Forest."
        {id = "battle", directive = Directive.FIND_A_GATEWAY_INTO_THE_INFINITE_FOREST_F7A5BB63,
            lines = {line(cue.CUE_3)},
            ends = {monitor = Slot.GATE_GOTO_CUBE_STAIRS_TOP_PLAYER_MONITOR}},
        -- "Here it is. Well, I'm ready if you are." Dawn played this at a hard-coded X position;
        -- the authored monitor at the top of the stairs is the same place.
        {id = "at_gate", directive = Directive.FIND_A_GATEWAY_INTO_THE_INFINITE_FOREST_F7A5BB63,
            lines = {line(cue.CUE_4)},
            ends = {monitor = Slot.INFINITE_FOREST_ENTRANCE_PLAYER_MONITOR}},
        -- The gate refuses the player: "We can't get through. Bring her to me."
        {id = "blocked", directive = Directive.FIND_A_GATEWAY_INTO_THE_INFINITE_FOREST_F7A5BB63,
            lines = {line(cue.CUE_5)}},
        {id = "bring_sagira", directive = Directive.BRING_SAGIRA_TO_BROTHER_VANCE_FA35EDEE,
            navpoint = Slot.ABS_LIGHTHOUSE_TOWER_RETURN_NAV_POINT,
            ends = {monitor = Slot.ABS_LIGHTHOUSE_TOWER_RETURN_PLAYER_MONITOR}},
        {id = "return", directive = Directive.BRING_SAGIRA_TO_BROTHER_VANCE_B4D880CB,
            navpoint = Slot.ABS_LIGHTHOUSE_TOWER_RETURN_NAV_POINT,
            ends = {monitor = Slot.TOWER_FINALE_COMMIT_PLAYER_MONITOR}},
        -- "Descendants. These aren't normal Vex."
        {id = "contact", directive = Directive.BRING_SAGIRA_TO_BROTHER_VANCE_B4D880CB,
            lines = {line(cue.CUE_6)}, barrier = true,
            ends = {clear = "wave_one"}},
        {id = "wave_two", directive = Directive.BRING_SAGIRA_TO_BROTHER_VANCE_B4D880CB,
            barrier = true, ends = {clear = "wave_two"}},
        {id = "wave_three", directive = Directive.BRING_SAGIRA_TO_BROTHER_VANCE_B4D880CB,
            barrier = true, ends = {clear = "wave_three"}},
        -- "There! Take out the module!" Dawn made the module damageable with a client detour, so
        -- whether the stock client lets it be shot here is untested.
        {id = "module", directive = Directive.BRING_SAGIRA_TO_BROTHER_VANCE_80FD8B67,
            lines = {line(cue.CUE_7)}, barrier = true,
            ends = {destroyed = {Slot.TOWER_FINALE_TARGET_OBJECT}}},
        -- The gate shield drops and the Lighthouse opens.
        {id = "unlocked", directive = Directive.BRING_SAGIRA_TO_BROTHER_VANCE_B10D6455,
            navpoint = Slot.LIGHTHOUSE_DIRECTIVE_VANCE_GOTO_NAV_POINT,
            lines = {line(cue.CUE_8)},
            on_start = function(context)
                move(context, {Slot.LIGHTHOUSE_ACTUAL_VEX_GATE_BOTTOM_SHIELD_DEVICE}, "close")
            end,
            ends = {trigger = Slot.PT_PLAYER_IN_LIGHTHOUSE}},
        -- The Ghost, then Vance: "Come closer."
        {id = "invitation", directive = Directive.BRING_SAGIRA_TO_BROTHER_VANCE,
            navpoint = Slot.LIGHTHOUSE_DIRECTIVE_VANCE_MEET_NAV_POINT,
            lines = {line(cue.CUE_9), line(cue.CUE_10)},
            ends = {trigger = Slot.PT_PLAYER_NEAR_VANCE}},
        -- The closing conversation is one authored scene and owns its own lines.
        {id = "conversation", scene = Scene.SCENE_BROTHER_VANCE_INTRO,
            ends = {scene = Slot.SCENE_BROTHER_VANCE_INTRO}},
    },
    encounters = {
        marchers, recess, recess_reinforce, shelf, shelf_reinforce, platform_end, end_reinforce,
        outskirts, gate_center, return_outskirts, return_center,
        wave_one, wave_two, wave_three, wave_three_support,
    },
}
