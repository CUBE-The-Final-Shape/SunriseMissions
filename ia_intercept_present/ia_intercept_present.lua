-- Mercury adventure opening from Dawn; the activity beyond Forest entry remains absent.
-- Portal permission and public-beacon handoff are unverified; this draft cannot complete.
local missions = require("missions")
local mission = require(missions.IA_INTERCEPT_PRESENT)
local campaign = require("lib.campaign")
local Slot = mission.Slot

return campaign.new{
    key = "intercept_opening",
    complete = false,
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80F46D8D,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80F46D8D,
    legs = {
        {id = "lighthouse", state = mission.states.STATE_80F467B0_000F_0000_80F467AB},
        {id = "forest", state = mission.states.STATE_80F467B0_000C_0000_80F467A8},
    },
    steps = {
        {id = "opening", directive = mission.Directive.INVESTIGATE_THE_CABAL_SIMULATION_C9E4C596,
            lines = {campaign.line(mission.DialogueCue.M_DIALOG_SENSOR_80F46D8D.CUE_0)},
            on_start = function(context)
                context:activate_objects{slots = {Slot.O_INF_ADV_TELE_0, Slot.O_INF_ADV_TELE_1},
                    active = true}
            end,
            barrier = true, ends = {region = "forest"}},
        {id = "unsupported",
            on_start = function(context)
                context:slot(Slot.M_DIRECTIVE_SENSOR_80F46D8D):clear_directives()
            end,
            barrier = true, ends = {await = function() return false end}},
    },
}
