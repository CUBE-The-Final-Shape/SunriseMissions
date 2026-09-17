-- Unbroken. Red War campaign draft; not tested in game.
-- Leg order: islands -> transport -> roost, from the transition spawn sets and the goto triggers.
-- Steps follow the step objects, their lines and the trigger volume positions: the elevator
-- panel, the shaft, the engines, the hangar with Holliday, then Thumos on the bridge.
local missions = require("missions")
local mission = require(missions.MISSION_REVENGE)
local campaign = require("lib.campaign")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive = mission.Slot, mission.Squad, mission.Directive
local cue = mission.DialogueCue.M_DIALOG_SENSOR_80B9BA9F

local depot = {
    id = "depot",
    trigger = Slot.DEPOT_MAIN_SPAWN_TRIGGER,
    objective = Slot.DEPOT_OBJECTIVE,
    squads = {
        unit(Squad.DEPOT_FRONT01_SQUAD, Slot.DEPOT_FRONT01_SQUAD),
        unit(Squad.DEPOT_FRONT02_SQUAD, Slot.DEPOT_FRONT02_SQUAD),
        unit(Squad.DEPOT_LEGIONARY01_SQUAD, Slot.DEPOT_LEGIONARY01_SQUAD),
        unit(Squad.DEPOT_LEGIONARY02_SQUAD, Slot.DEPOT_LEGIONARY02_SQUAD),
        unit(Squad.DEPOT_LEGIONARY03_SQUAD, Slot.DEPOT_LEGIONARY03_SQUAD),
        unit(Squad.DEPOT_SNIPERS01_SQUAD, Slot.DEPOT_SNIPERS01_SQUAD),
        unit(Squad.DEPOT_LEFT01_SQUAD, Slot.DEPOT_LEFT01_SQUAD),
        unit(Squad.DEPOT_LEFT02_SQUAD, Slot.DEPOT_LEFT02_SQUAD),
        unit(Squad.DEPOT_WARBEASTS01_SQUAD, Slot.DEPOT_WARBEASTS01_SQUAD),
        unit(Squad.DEPOT_WARBEASTS02_SQUAD, Slot.DEPOT_WARBEASTS02_SQUAD),
    },
}

local corridors = {
    id = "corridors",
    trigger = Slot.CORRIDORS_TAUNT_PERFORMANCE_TRIGGER,
    objective = Slot.CORRIDORS_OBJECTIVE,
    squads = {
        unit(Squad.CORRIDORS_TAUNT01_SQUAD, Slot.CORRIDORS_TAUNT01_SQUAD),
        unit(Squad.CORRIDORS_INF01_SQUAD, Slot.CORRIDORS_INF01_SQUAD),
        unit(Squad.CORRIDORS_INF02_SQUAD, Slot.CORRIDORS_INF02_SQUAD),
        unit(Squad.CORRIDORS_WARBEASTS01_SQUAD, Slot.CORRIDORS_WARBEASTS01_SQUAD),
    },
}

local engines = {
    id = "engines",
    trigger = Slot.ENGINES_BRUISER_INTRO_SCENE_INIT_TRIGGER,
    objective = Slot.ENGINES_OBJECTIVE,
    squads = {
        unit(Squad.ENGINES_FRONT_INF01A_SQUAD, Slot.ENGINES_FRONT_INF01A_SQUAD),
        unit(Squad.ENGINES_FRONT_INF01B_SQUAD, Slot.ENGINES_FRONT_INF01B_SQUAD),
        unit(Squad.ENGINES_FRONT_INF02_SQUAD, Slot.ENGINES_FRONT_INF02_SQUAD),
        unit(Squad.ENGINES_FRONT_INF03_SQUAD, Slot.ENGINES_FRONT_INF03_SQUAD),
        unit(Squad.ENGINES_FRONT_INF04_SQUAD, Slot.ENGINES_FRONT_INF04_SQUAD),
        unit(Squad.ENGINES_CATWALK01_SQUAD, Slot.ENGINES_CATWALK01_SQUAD),
        unit(Squad.ENGINES_MIDDLE_LEFT01_SQUAD, Slot.ENGINES_MIDDLE_LEFT01_SQUAD),
        unit(Squad.ENGINES_MIDDLE_RIGHT01_SQUAD, Slot.ENGINES_MIDDLE_RIGHT01_SQUAD),
        unit(Squad.ENGINES_BACK_SNIPER01_SQUAD, Slot.ENGINES_BACK_SNIPER01_SQUAD),
        unit(Squad.ENGINES_BACK_SNIPER02_SQUAD, Slot.ENGINES_BACK_SNIPER02_SQUAD),
        unit(Squad.ENGINES_BACK_SUPPORT01_SQUAD, Slot.ENGINES_BACK_SUPPORT01_SQUAD),
        unit(Squad.ENGINES_BACK_ANCHOR01_SQUAD, Slot.ENGINES_BACK_ANCHOR01_SQUAD),
        unit(Squad.ENGINES_BACK_BRUISER01_SQUAD, Slot.ENGINES_BACK_BRUISER01_SQUAD),
        unit(Squad.ENGINES_BACK_BRUISER02_SQUAD, Slot.ENGINES_BACK_BRUISER02_SQUAD),
        unit(Squad.ENGINES_BACK_BRUISER03_SQUAD, Slot.ENGINES_BACK_BRUISER03_SQUAD),
    },
}

-- The hangar shields rise with the ambush.
local hangar = {
    id = "hangar",
    trigger = Slot.HANGAR_INTRO_START_TRIGGER,
    after = "hangar",
    objective = Slot.HANGAR_OBJECTIVE,
    on_start = function(context)
        move(context, {Slot.HANGAR_DOOR_HOLOGRAM_DEVICE, Slot.HANGAR_SHIELD1_DEVICE,
            Slot.HANGAR_SHIELD2_DEVICE, Slot.HANGAR_SHIELD3_DEVICE}, "power_on")
    end,
    squads = {
        unit(Squad.HANGAR_CABAL_TANK01_SQUAD, Slot.HANGAR_CABAL_TANK01_SQUAD),
        unit(Squad.HANGAR_SWITCH_OPERATOR01_SQUAD, Slot.HANGAR_SWITCH_OPERATOR01_SQUAD),
        unit(Squad.HANGAR_SWITCH_GUARD_ANCHOR_SQUAD, Slot.HANGAR_SWITCH_GUARD_ANCHOR_SQUAD),
        unit(Squad.HANGAR_SWITCH_FRONT01_SQUAD, Slot.HANGAR_SWITCH_FRONT01_SQUAD),
        unit(Squad.HANGAR_SWITCH_GUARDS01_SQUAD, Slot.HANGAR_SWITCH_GUARDS01_SQUAD),
        unit(Squad.HANGAR_SWITCH_GUARDS02_SQUAD, Slot.HANGAR_SWITCH_GUARDS02_SQUAD),
        unit(Squad.HANGAR_AMBUSH_START01_SQUAD, Slot.HANGAR_AMBUSH_START01_SQUAD),
        unit(Squad.HANGAR_AMBUSH_START_HEAVY01_SQUAD, Slot.HANGAR_AMBUSH_START_HEAVY01_SQUAD),
        unit(Squad.HANGAR_AMBUSH_A_SQUAD, Slot.HANGAR_AMBUSH_A_SQUAD),
        unit(Squad.HANGAR_AMBUSH_B_SQUAD, Slot.HANGAR_AMBUSH_B_SQUAD),
        unit(Squad.HANGAR_AMBUSH_C_SQUAD, Slot.HANGAR_AMBUSH_C_SQUAD),
        unit(Squad.HANGAR_AMBUSH_D_SQUAD, Slot.HANGAR_AMBUSH_D_SQUAD),
        unit(Squad.HANGAR_AMBUSH_FRONT01_SQUAD, Slot.HANGAR_AMBUSH_FRONT01_SQUAD),
        unit(Squad.HANGAR_AMBUSH_FRONT02_SQUAD, Slot.HANGAR_AMBUSH_FRONT02_SQUAD),
        unit(Squad.HANGAR_AMBUSH_PHALANX01_SQUAD, Slot.HANGAR_AMBUSH_PHALANX01_SQUAD),
        unit(Squad.HANGAR_AMBUSH_PHALANX02_SQUAD, Slot.HANGAR_AMBUSH_PHALANX02_SQUAD),
        unit(Squad.HANGAR_AMBUSH_PHALANX03_SQUAD, Slot.HANGAR_AMBUSH_PHALANX03_SQUAD),
        unit(Squad.HANGAR_AMBUSH_PHALANX04_SQUAD, Slot.HANGAR_AMBUSH_PHALANX04_SQUAD),
        unit(Squad.HANGAR_AMBUSH_BRUISER01_SQUAD, Slot.HANGAR_AMBUSH_BRUISER01_SQUAD),
        unit(Squad.HANGAR_AMBUSH_CATWALK01_SQUAD, Slot.HANGAR_AMBUSH_CATWALK01_SQUAD),
        unit(Squad.HANGAR_AMBUSH_CATWALK02_SQUAD, Slot.HANGAR_AMBUSH_CATWALK02_SQUAD),
        unit(Squad.HANGAR_INF_WAVE02_SQUAD, Slot.HANGAR_INF_WAVE02_SQUAD),
        unit(Squad.HANGAR_BACK_ANCHOR01_SQUAD, Slot.HANGAR_BACK_ANCHOR01_SQUAD),
        unit(Squad.HANGAR_BACK_LOWER01_SQUAD, Slot.HANGAR_BACK_LOWER01_SQUAD),
    },
}

-- A dropship may never report its members gone, so no step waits on it.
local hangar_ships = {
    id = "hangar_ships",
    trigger = Slot.HANGAR_INTRO_START_TRIGGER,
    after = "hangar",
    objective = Slot.HANGAR_OBJECTIVE,
    squads = {
        unit(Squad.HANGAR_CABAL_DROPSHIP01_SQUAD, Slot.HANGAR_CABAL_DROPSHIP01_SQUAD),
    },
}

-- The Fallen skiffs in the sky carry no encounter objective.
local skiffs = {
    id = "skiffs",
    after = "hangar",
    squads = {
        unit(Squad.CARGO_SKY_FALLEN_DROPSHIP01_SQUAD, Slot.CARGO_SKY_FALLEN_DROPSHIP01_SQUAD),
        unit(Squad.CARGO_SKY_FALLEN_DROPSHIP02_SQUAD, Slot.CARGO_SKY_FALLEN_DROPSHIP02_SQUAD),
        unit(Squad.CARGO_SKY_FALLEN_DROPSHIP03_SQUAD, Slot.CARGO_SKY_FALLEN_DROPSHIP03_SQUAD),
        unit(Squad.CARGO_SKY_FALLEN_DROPSHIP04_SQUAD, Slot.CARGO_SKY_FALLEN_DROPSHIP04_SQUAD),
    },
}

local bridgehall = {
    id = "bridgehall",
    trigger = Slot.BRIDGEHALL_SCOUTS_SPAWN_TRIGGER,
    after = "bridge",
    objective = Slot.BRIDGEHALL_OBJECTIVE,
    squads = {
        unit(Squad.BRIDGEHALL_SCOUTS01_SQUAD, Slot.BRIDGEHALL_SCOUTS01_SQUAD),
        unit(Squad.BRIDGEHALL_SCOUTS02_SQUAD, Slot.BRIDGEHALL_SCOUTS02_SQUAD),
        unit(Squad.BRIDGEHALL_ELBOW01_SQUAD, Slot.BRIDGEHALL_ELBOW01_SQUAD),
        unit(Squad.BRIDGEHALL_CHOKE_FRONT01_SQUAD, Slot.BRIDGEHALL_CHOKE_FRONT01_SQUAD),
        unit(Squad.BRIDGEHALL_CHOKE_BACK01_SQUAD, Slot.BRIDGEHALL_CHOKE_BACK01_SQUAD),
        unit(Squad.BRIDGEHALL_GUARDS_INF01_SQUAD, Slot.BRIDGEHALL_GUARDS_INF01_SQUAD),
    },
}

local thumos = {
    id = "thumos",
    trigger = Slot.BRIDGE_BOSS_SPAWN_TRIGGER,
    after = "thumos",
    objective = Slot.BRIDGE_OBJECTIVE,
    squads = {
        unit(Squad.BRIDGE_BOSS_SQUAD, Slot.BRIDGE_BOSS_SQUAD),
        unit(Squad.BRIDGE_GUARDS01_SQUAD, Slot.BRIDGE_GUARDS01_SQUAD),
        unit(Squad.BRIDGE_GUARDS02_SQUAD, Slot.BRIDGE_GUARDS02_SQUAD),
        unit(Squad.BRIDGE_BATTLE_WAVE1A_SQUAD, Slot.BRIDGE_BATTLE_WAVE1A_SQUAD),
        unit(Squad.BRIDGE_BATTLE_WAVE1B_SQUAD, Slot.BRIDGE_BATTLE_WAVE1B_SQUAD),
        unit(Squad.BRIDGE_BATTLE_WAVE1C_SQUAD, Slot.BRIDGE_BATTLE_WAVE1C_SQUAD),
        unit(Squad.BRIDGE_BATTLE_WAVE2A_SQUAD, Slot.BRIDGE_BATTLE_WAVE2A_SQUAD),
        unit(Squad.BRIDGE_BATTLE_WAVE2B_SQUAD, Slot.BRIDGE_BATTLE_WAVE2B_SQUAD),
        unit(Squad.BRIDGE_BATTLE_WAVE2C_SQUAD, Slot.BRIDGE_BATTLE_WAVE2C_SQUAD),
        unit(Squad.BRIDGE_BATTLE_WAVE3A_SQUAD, Slot.BRIDGE_BATTLE_WAVE3A_SQUAD),
        unit(Squad.BRIDGE_BATTLE_WAVE3B_SQUAD, Slot.BRIDGE_BATTLE_WAVE3B_SQUAD),
        unit(Squad.BRIDGE_BATTLE_WAVE3C_SQUAD, Slot.BRIDGE_BATTLE_WAVE3C_SQUAD),
    },
}

local storm = Directive.STORM_THE_COMMAND_DECK

return campaign.new{
    key = "revenge",
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80B9BA9F,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80B9BA9F,
    legs = {
        {id = "islands", state = mission.states.STATE_80B9B781_0027_0000_80B9B62F, arm = {
            Slot.MISSION_REVENGE_TRANSPORT_GOTO_TRIGGER,
        }},
        {id = "transport", state = mission.states.STATE_80B9B781_0037_0000_80B9B640, arm = {
            Slot.MISSION_REVENGE_ELEVATOR_ROOM_REACHED_TRIGGER, Slot.DEPOT_MAIN_SPAWN_TRIGGER,
            Slot.MISSION_REVENGE_ROOST_GOTO_TRIGGER,
        }},
        {id = "roost", state = mission.states.STATE_80B9B781_002B_0000_80B9B636, arm = {
            Slot.CORRIDORS_TAUNT_PERFORMANCE_TRIGGER,
            Slot.ENGINES_BRUISER_INTRO_SCENE_INIT_TRIGGER,
            Slot.MISSION_REVENGE_ROOST_HANGAR_GOTO_TRIGGER, Slot.HANGAR_INTRO_START_TRIGGER,
            Slot.BRIDGEHALL_SCOUTS_SPAWN_TRIGGER,
            Slot.MISSION_REVENGE_ROOST_BRIDGE_GOTO_DIRECTIVE_TRIGGER,
            Slot.BRIDGE_BOSS_SPAWN_TRIGGER,
        }},
    },
    steps = {
        {id = "board", directive = Directive.FIND_THUMOS_THE_UNBROKEN,
            navpoint = Slot.MISSION_REVENGE_TRANSPORT_GOTO_NAV_POINT,
            ends = {trigger = Slot.MISSION_REVENGE_TRANSPORT_GOTO_TRIGGER}},
        {id = "depot", directive = Directive.FIND_THUMOS_THE_UNBROKEN,
            navpoint = Slot.SLOT_0002_80BDA8AC,
            ends = {trigger = Slot.MISSION_REVENGE_ELEVATOR_ROOM_REACHED_TRIGGER}},
        -- The Ghost reads the schematics at the elevator panel.
        {id = "console", directive = Directive.STORM_THE_COMMAND_DECK_64C1B227,
            navpoint = Slot.MISSION_REVENGE_TRANSPORT_ELEVATOR_DIRECTIVE_NAV_POINT,
            on_start = function(context)
                move(context, {Slot.ELEVATOR_PANEL_DEVICE}, "power_on")
            end,
            ends = {ghost_link = Slot.ELEVATOR_PANEL_GHOSTLINK}},
        {id = "shaft", directive = Directive.STORM_THE_COMMAND_DECK_AC4B91B6,
            navpoint = Slot.MISSION_REVENGE_ROOST_GOTO_NAV_POINT,
            on_start = function(context)
                move(context, {Slot.ELEVATOR_DOOR_DEVICE, Slot.ELEVATOR_DEVICE}, "open")
            end,
            ends = {trigger = Slot.MISSION_REVENGE_ROOST_GOTO_TRIGGER}},
        -- "We're almost to the hangar." "Holliday, are you in range for an assist?"
        {id = "push", directive = Directive.STORM_THE_COMMAND_DECK_88C186B8,
            navpoint = Slot.SLOT_000E_80BDA7FF,
            lines = {line(cue.CUE_12, Slot.SLOT_0008_80BDA7FF)},
            on_start = function(context)
                move(context, {Slot.DEVICE_TRANSPORT_DOOR_TAUNT}, "open")
            end,
            ends = {trigger = Slot.MISSION_REVENGE_ROOST_HANGAR_GOTO_TRIGGER}},
        -- Holliday: "Someone order backup?" Its filter's object has nothing to register it.
        {id = "hangar", directive = storm,
            navpoint = Slot.MISSION_REVENGE_ROOST_HANGAR_OPEN_NAV_POINT_80BDA807,
            waypoint = Slot.MISSION_REVENGE_ROOST_HANGAR_OPEN_WAYPOINT_VOLUME_80BDA807,
            lines = {line(cue.CUE_14)},
            on_start = function(context)
                move(context, {Slot.HANGAR_DOOR_ENTRY_DEVICE, Slot.HANGAR_HEAVY_DOOR_DEVICE},
                    "open")
            end,
            ends = {clear = "hangar"}},
        -- "Don't leave the door open." "I've done my part. Now go take care of Thumos."
        {id = "bridge", directive = Directive.STORM_THE_COMMAND_DECK_CC80AD6A,
            navpoint = Slot.MISSION_REVENGE_ROOST_BRIDGE_GOTO_DIRECTIVE_NAV_POINT,
            lines = {line(cue.CUE_18), line(cue.CUE_19)},
            on_start = function(context) move(context, {Slot.HANGAR_EXIT_DOOR_DEVICE}, "open") end,
            ends = {trigger = Slot.MISSION_REVENGE_ROOST_BRIDGE_GOTO_DIRECTIVE_TRIGGER}},
        {id = "thumos", directive = Directive.BREAK_THUMOS_THE_UNBROKEN,
            navpoint = Slot.SLOT_0002_80BDA80F,
            on_start = function(context)
                move(context, {Slot.BRIDGE_MAIN_DOOR_DEVICE, Slot.BRIDGE_GATING_DOOR_DEVICE,
                    Slot.BRIDGE_BOSS_ELEVATOR_DEVICE}, "open")
            end,
            ends = {clear = "thumos"}},
        -- "Whew! Got the key codes, and Thumos is dead."
        {id = "codes", lines = {line(cue.CUE_21)}},
    },
    encounters = {depot, corridors, engines, hangar, hangar_ships, skiffs, bridgehall, thumos},
}
