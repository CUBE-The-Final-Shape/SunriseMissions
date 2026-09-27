-- Mercury adventure opening from Dawn; the activity beyond Forest entry remains absent.
-- Portal permission and public-beacon handoff are unverified; this draft cannot complete.
local missions = require("missions")
local mission = require(missions.IA_ASCEND_FUTURE)
local campaign = require("lib.campaign")
local Slot = mission.Slot

return campaign.new{
    key = "ascend_opening",
    complete = false,
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80F46D43,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80F46D43,
    legs = {
        {id = "lighthouse", state = mission.states.STATE_80F464F6_000F_0000_80F464F1},
        {id = "forest", state = mission.states.STATE_80F464F6_000C_0000_80F464EE},
    },
    steps = {
        {id = "opening", directive = mission.Directive.TAMPER_WITH_THE_FALLEN_SIMULATION,
            lines = {campaign.line(mission.DialogueCue.M_DIALOG_SENSOR_80F46D43.CUE_0)},
            on_start = function(context)
                context:activate_objects{slots = {Slot.O_INF_ADV_TELE_0, Slot.O_INF_ADV_TELE_1},
                    active = true}
            end,
            barrier = true, ends = {region = "forest"}},
        {id = "unsupported",
            on_start = function(context)
                context:slot(Slot.M_DIRECTIVE_SENSOR_80F46D43):clear_directives()
            end,
            barrier = true, ends = {await = function() return false end}},
    },
}
