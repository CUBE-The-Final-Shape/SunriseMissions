-- Beyond Infinity. Native mission logic; live play remains unverified.
-- Absent: lens exposure, Forest faction selection and ambush immunity.
-- Only each scene's start input is sent; t_if_entered and the future echo keys are not.
local missions = require("missions")
local mission = require(missions.ADVENTURE_VOD)
local campaign = require("lib.campaign")
local lib = require("lib.mission_lib")
local unit, line, move = campaign.unit, campaign.line, campaign.move
local Slot, Squad, Directive, Scene = mission.Slot, mission.Squad, mission.Directive, mission.Scene
local Input = mission.SceneInput
local cue = mission.DialogueCue.M_DIALOG_SENSOR
local echo_six = lib.one(Input.SCENE_ECHO_INTRO_SIX_RIGHT.T_ECHO_SIX, "right echo six input")

local function reserve(context, squads)
    lib.place_all(context, squads, context.sdk.squad_modes.reserve)
end
local ambush_front = {
    id = "ambush_front",
    after = "escape_portal",
    objective = Slot.FUTURE_AMBUSH_OBJECTIVE,
    squads = {
        unit(Squad.FUTURE_AMBUSH_FRONT01_SQUAD, Slot.FUTURE_AMBUSH_FRONT01_SQUAD),
        unit(Squad.FUTURE_AMBUSH_FRONT02_SQUAD, Slot.FUTURE_AMBUSH_FRONT02_SQUAD),
        unit(Squad.FUTURE_AMBUSH_FRONT03_SQUAD, Slot.FUTURE_AMBUSH_FRONT03_SQUAD),
        unit(Squad.FUTURE_AMBUSH_FRONT04_SQUAD, Slot.FUTURE_AMBUSH_FRONT04_SQUAD),
        unit(Squad.FUTURE_AMBUSH_FRONT05_SQUAD, Slot.FUTURE_AMBUSH_FRONT05_SQUAD),
        unit(Squad.FUTURE_AMBUSH_FRONT06_SQUAD, Slot.FUTURE_AMBUSH_FRONT06_SQUAD),
    },
}

local ambush_back = {
    id = "ambush_back",
    after = "escape_portal",
    objective = Slot.FUTURE_AMBUSH_OBJECTIVE,
    squads = {
        unit(Squad.FUTURE_AMBUSH_BACK01_SQUAD, Slot.FUTURE_AMBUSH_BACK01_SQUAD),
        unit(Squad.FUTURE_AMBUSH_BACK02_SQUAD, Slot.FUTURE_AMBUSH_BACK02_SQUAD),
        unit(Squad.FUTURE_AMBUSH_BACK03_SQUAD, Slot.FUTURE_AMBUSH_BACK03_SQUAD),
    },
}

return campaign.new{
    key = "vod",
    omit = {Slot.VEX_MACHINE1_OBJECT, Slot.PANOPTES_ALARM_POINT},
    directive_sensor = Slot.M_DIRECTIVE_SENSOR,
    dialogue_sensor = Slot.M_DIALOG_SENSOR,
    legs = {
        {id = "lighthouse", state = mission.states.STATE_80F46015_000F_0000_80F46010,
            arm = {Slot.MERCURY_M_VOD_LIGHTHOUSE_030_TRIGGER}},
        {id = "well", state = mission.states.STATE_80F46015_0013_0000_80F46014,
            arm = {Slot.DIRECTIVE_INITIAL_TRIGGER_80F4648E, Slot.DIRECTIVE_TRIGGER_80F4648E,
                Slot.DIRECTIVE_TRIGGER_80F46499, Slot.PT_BLACKOUT_OFF,
                Slot.ECHO_RINGS2_TRIGGER}},
        {id = "forest", state = mission.states.STATE_80F46015_0008_0000_80F46009,
            arm = {Slot.PT_BEGIN_PAST, Slot.PT_START_PRECIPICE, Slot.PT_IF_ENTERED}},
        {id = "past", state = mission.states.STATE_80F46015_0012_0000_80F46013,
            arm = {Slot.VIGNETTE_START_PLAYER_TRIGGER, Slot.PT_PAST_ECHO,
                Slot.MERCURY_M_VOD_PAST_060_DISABLE_TRIGGER}},
        {id = "future", state = mission.states.STATE_80F46015_0004_0000_80F46005,
            arm = {Slot.PT_PLAYER_ENTERS_SPACE, Slot.PT_PLAYER_APPROACHING_FIRST_ECHO,
                Slot.PT_PLAYER_NEAR_FIRST_ECHO, Slot.PT_PLAYER_NEAR_ECHO,
                Slot.DIRECTIVE_TRIGGER_80F460DA}},
    },
    steps = {
        {id = "find_osiris", directive = Directive.ENTER_THE_INFINITE_FOREST,
            lines = {line(cue.CUE_0)},
            on_start = function(context)
                context:activate_objects{slots = {Slot.LIGHTHOUSE_TELEPORT}, active = true}
            end,
            ends = {trigger = Slot.MERCURY_M_VOD_LIGHTHOUSE_030_TRIGGER, region = "well"}},
        {id = "search", directive = Directive.SEARCH_FOR_OSIRIS,
            navpoint = Slot.DIRECTIVE_POINT_80F4648E,
            lines = {line(cue.CUE_2)},
            on_start = function(context)
                context:activate_objects{slots = {Slot.PF_SYNC_PLATE_O_ALTAR,
                    Slot.LASER_LENSE_OBJECT, Slot.LASER_PLATE_TO_LENSE_OBJECT,
                    Slot.LASER_LENSE_TO_CORE_OBJECT}, active = true}
                move(context, {Slot.LASER_PLATE_TO_LENSE_DEVICE, Slot.LASER_LENSE_DEVICE,
                    Slot.LASER_LENSE_TO_CORE_DEVICE, Slot.ECHO_EXIT_DEVICE,
                    Slot.WELL_LIGHTING_DEVICE}, "open")
            end,
            ends = {trigger = Slot.DIRECTIVE_TRIGGER_80F4648E}},
        {id = "plate", navpoint = Slot.DIRECTIVE_POINT_80F4648E,
            lines = {line(cue.CUE_4)},
            barrier = true, ends = {destroyed = {Slot.LASER_LENSE_OBJECT}}},
        {id = "cast_beam", on_start = function(context)
                reserve(context, {
                    Squad.SQUAD_ECHO_INTRO_FIRST,
                })
            end},
        {id = "beam", directive = Directive.SEARCH_FOR_OSIRIS_B1AD777D,
            scene = Scene.SCENE_ECHO_FIRST,
            on_start = function(context)
                move(context, {Slot.ECHO_BEAM1_DEVICE, Slot.ECHO_RINGS1_DEVICE,
                    Slot.ECHO_RINGS2_DEVICE}, "open")
                move(context, {Slot.ECHO_EXIT_DEVICE}, "close")
            end,
            lines = {line(cue.CUE_6), line(cue.CUE_12), line(cue.CUE_13)},
            ends = {scene = Slot.SCENE_ECHO_FIRST}},
        {id = "cast_send_word", on_start = function(context)
                reserve(context, {
                    Squad.SQUAD_ECHO_INTRO_DBL_ONE,
                    Squad.SQUAD_ECHO_INTRO_DBL_TWO,
                })
            end},
        {id = "send_word", scene = Scene.SCENE_SPLIT_2CHAR,
            lines = {line(cue.CUE_14)},
            ends = {scene = Slot.SCENE_SPLIT_2CHAR}},
        {id = "cast_safety", on_start = function(context)
                reserve(context, {
                    Squad.SQUAD_ECHO_INTRO_FOUR,
                    Squad.SQUAD_ECHO_INTRO_FIVE,
                })
            end},
        {id = "safety", scene = Scene.SCENE_ECHO_INTRO_TWO,
            inputs = lib.list(Input.SCENE_ECHO_INTRO_TWO.T_ECHO_TWO),
            lines = {line(cue.CUE_9), line(cue.CUE_10)},
            ends = {scene = Slot.SCENE_ECHO_INTRO_TWO}},
        {id = "cast_timelines", on_start = function(context)
                reserve(context, {
                    Squad.SQUAD_ECHO_INTRO_SEVEN,
                    Squad.SQUAD_ECHO_INTRO_EIGHT,
                    Squad.SQUAD_ECHO_INTRO_NINE,
                })
            end},
        {id = "timelines", scene = Scene.SCENE_ECHO_INTRO_FOUR_3CHAR,
            lines = {line(cue.CUE_15)},
            ends = {scene = Slot.SCENE_ECHO_INTRO_FOUR_3CHAR}},
        {id = "cast_upper", on_start = function(context)
                reserve(context, {
                    Squad.SQUAD_ECHO_INTRO_TEN,
                    Squad.SQUAD_ECHO_INTRO_TEN_RIGHT,
                })
            end},
        {id = "upper", scene = Scene.SCENE_ECHO_INTRO_SIX,
            inputs = lib.list(Input.SCENE_ECHO_INTRO_SIX.T_ECHO_SIX),
            on_start = function(context)
                local right = context:scene(Scene.SCENE_ECHO_INTRO_SIX_RIGHT)
                right:activate{}
                right:send_event{key = echo_six}
            end,
            lines = {line(cue.CUE_17)},
            ends = {scene = Slot.SCENE_ECHO_INTRO_SIX}},
        {id = "too_late", navpoint = Slot.DIRECTIVE_POINT_80F46499,
            lines = {line(cue.CUE_19)},
            ends = {trigger = Slot.DIRECTIVE_TRIGGER_80F46499, region = "forest"}},
        {id = "precipice", ends = {trigger = Slot.PT_START_PRECIPICE}},
        {id = "cast_reveal", on_start = function(context)
                reserve(context, {
                    Squad.SQUAD_ECHO_IF_REVEAL,
                    Squad.SQ_ECHO_VANISH_ONE,
                    Squad.SQ_ECHO_VANISH_TWO,
                    Squad.SQ_ECHO_VANISH_THREE,
                    Squad.SQ_ECHO_VANISH_FOUR,
                })
            end},
        {id = "reveal", scene = Scene.SCENE_IF_REVEAL,
            inputs = lib.list(Input.SCENE_IF_REVEAL.T_START_SCENE),
            ends = {scene = Slot.SCENE_IF_REVEAL}},
        {id = "retire_reveal", on_start = function(context)
            context:scene(Scene.SCENE_IF_REVEAL):stop{}
        end},
        {id = "past_route", directive = Directive.LEARN_FROM_THE_REFLECTIONS_OF_OSIRIS_9225AEF3,
            lines = {line(cue.CUE_29)},
            on_start = function(context)
                move(context, {Slot.DOOR_WELL_DEVICE}, "open")
                context:slot(Slot.MAP_GENERATOR_SENSOR_80F46103):generate_map{
                    seed = campaign.run_seed(context), enabled = true}
            end,
            ends = {trigger = Slot.PT_IF_ENTERED}},
        {id = "daemon_tutorial", lines = {line(cue.CUE_30)}},
        {id = "past_entrance", lines = {line(cue.CUE_31)},
            on_start = function(context)
                context:activate_objects{slots = {Slot.PAST_ENTRANCE_TELEPORT_OBJECT},
                    active = true}
            end,
            ends = {region = "past"}},
        {id = "cast_study", on_start = function(context)
                reserve(context, {
                    Squad.SQUAD_ECHO_PAST,
                    Squad.SQUAD_ECHO_PAST_B,
                })
                context:activate_objects{slots = {Slot.VEX_MACHINE1_OBJECT}, active = true}
            end},
        {id = "study", directive = Directive.LEARN_FROM_THE_REFLECTIONS_OF_OSIRIS_D60FA7DF,
            scene = Scene.SCENE_PAST_ECHO,
            inputs = lib.list(Input.SCENE_PAST_ECHO.START_TRIGGER),
            lines = {line(cue.CUE_32)},
            ends = {trigger = Slot.PT_PAST_ECHO}},
        {id = "machines", lines = {line(cue.CUE_33)},
            on_start = function(context)
                context:activate_objects{slots = {Slot.VEX_MACHINE2_OBJECT,
                    Slot.VEX_MACHINE3_OBJECT, Slot.VEX_MACHINE4_OBJECT, Slot.VEX_MACHINE5_OBJECT,
                    Slot.VEX_MACHINE_RUMBLE_OBJECT}, active = true}
                move(context, {Slot.VEX_MACHINE2_DEVICE, Slot.VEX_MACHINE3_DEVICE,
                    Slot.VEX_MACHINE4_DEVICE, Slot.VEX_MACHINE5_DEVICE}, "open")
            end,
            ends = {trigger = Slot.VIGNETTE_START_PLAYER_TRIGGER}},
        {id = "guardian", lines = {line(cue.CUE_34)},
            ends = {scene = Slot.SCENE_PAST_ECHO}},
        {id = "return_portal", revisit = true, barrier = true,
            directive = Directive.LEARN_FROM_THE_REFLECTIONS_OF_OSIRIS_BE5F8E8B,
            on_start = function(context)
                context:activate_objects{slots = {Slot.VEX_TELEPORTER_OBJECT,
                    Slot.VEX_TELEPORTER_CORE_OBJECT}, active = true}
                move(context, {Slot.VEX_TELEPORTER_DEVICE}, "open")
            end,
            ends = {region = "forest"}},
        {id = "future_route", directive = Directive.LEARN_FROM_THE_REFLECTIONS_OF_OSIRIS,
            lines = {line(cue.CUE_37), line(cue.CUE_38)},
            on_start = function(context)
                move(context, {Slot.DOOR_FUTURE_DEVICE}, "open")
                context:slot(Slot.MAP_GENERATOR_SENSOR_80F46103):generate_map{
                    seed = campaign.run_seed(context), enabled = true}
                context:activate_objects{slots = {Slot.IF_A_TELEPORT_OBJECT}, active = true}
            end,
            ends = {region = "future"}},
        {id = "cast_vision", on_start = function(context)
                reserve(context, {
                    Squad.SQUAD_ECHO,
                    Squad.SQUAD_INITIAL_ECHO,
                    Squad.SQUAD_BOSS_BAD_GUY,
                })
                context:activate_objects{slots = {Slot.PANOPTES_ALARM_POINT}, active = true}
            end},
        {id = "vision", directive = Directive.LEARN_FROM_THE_REFLECTIONS_OF_OSIRIS_64B46F54,
            scene = Scene.SCENE_FUTURE_ECHO,
            on_start = function(context)
                move(context, {Slot.D_VEX_EYES}, "open")
            end,
            ends = {trigger = Slot.PT_PLAYER_APPROACHING_FIRST_ECHO}},
        {id = "first_reflection", ends = {trigger = Slot.PT_PLAYER_NEAR_ECHO}},
        {id = "future_changed", ends = {scene = Slot.SCENE_FUTURE_ECHO}},
        {id = "escape_portal", directive = Directive.ESCAPE_TO_REALITY,
            on_start = function(context)
                context:activate_objects{slots = {Slot.LIGHTHOUSE_TELEPORT_OBJECT,
                    Slot.LIGHTHOUSE_TELEPORT2_OBJECT}, active = true}
                move(context, {Slot.VEX_TELEPORTER_FX_DEVICE, Slot.VEX_TELEPORTER_FX2_DEVICE},
                    "open")
            end,
            ends = {trigger = Slot.DIRECTIVE_TRIGGER_80F460DA}},
        {id = "escaped", revisit = true, barrier = true,
            directive = Directive.ESCAPE_TO_REALITY_5AD156F5,
            navpoint = Slot.DIRECTIVE_POINT_80F460DA,
            lines = {line(cue.CUE_47)},
            ends = {region = "lighthouse"}},
        {id = "news", directive = Directive.TELL_IKORA_THE_NEWS,
            lines = {line(cue.CUE_48)}},
    },
    encounters = {ambush_front, ambush_back},
}
