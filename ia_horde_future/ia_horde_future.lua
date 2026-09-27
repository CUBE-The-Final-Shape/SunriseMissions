-- Mercury adventure opening from Dawn; the activity beyond Forest entry remains absent.
-- Portal permission and public-beacon handoff are unverified; this draft cannot complete.
local missions = require("missions")
local mission = require(missions.IA_HORDE_FUTURE)
local campaign = require("lib.campaign")
local Slot = mission.Slot

return campaign.new{
    key = "horde_opening",
    complete = false,
    directive_sensor = Slot.M_DIRECTIVE_SENSOR_80F46D79,
    dialogue_sensor = Slot.M_DIALOG_SENSOR_80F46D79,
    legs = {
        {id = "lighthouse", state = mission.states.STATE_80F466E1_000F_0000_80F466DC},
        {id = "forest", state = mission.states.STATE_80F466E1_000C_0000_80F466D9},
    },
    steps = {
        {id = "opening", directive = mission.Directive.LOOK_FOR_TROUBLE,
            lines = {campaign.line(mission.DialogueCue.M_DIALOG_SENSOR_80F46D79.CUE_0)},
            on_start = function(context)
                context:activate_objects{slots = {Slot.O_INF_ADV_TELE_0, Slot.O_INF_ADV_TELE_1},
                    active = true}
            end,
            barrier = true, ends = {region = "forest"}},
        {id = "unsupported",
            on_start = function(context)
                context:slot(Slot.M_DIRECTIVE_SENSOR_80F46D79):clear_directives()
            end,
            barrier = true, ends = {await = function() return false end}},
    },
}
