-- scripts/mission_bacon/miniras.lua
local lib = require("lib.mission_lib")

return function(mission)
	local Slot = mission.Slot
	return {
		door = lib.one(Slot.DOOR_DEVICE, "miniras door"),
		
		at_locate_entrance = lib.one(Slot.PT_LOCATE_ENTRANCE, "locate entrance trigger"),
		at_end_phase = lib.one(Slot.PT_END_PHASE_80F6A1DD, "miniras end phae trigger"),
		
		line_sensor_15 = lib.one(mission.DialogueCue.M_DIALOG_SENSOR_80F6A396.CUE_15, "sensor line 15"),
		line_sensor_18 = lib.one(mission.DialogueCue.M_DIALOG_SENSOR_80F6A396.CUE_18, "sensor line 18"),
		
		initial_nav = lib.one(Slot.AP_RASPUTIN_ALARM_SOURCE, "initial navpoint"),
		goto_rasputin_nav = lib.one(Slot.NP_GOTO_RASPUTIN, "goto rasputin navpoint"),
		alt_nav = lib.one(Slot.SLOT_0009_80F6A1DD, "alt navpoint"),
	}
end