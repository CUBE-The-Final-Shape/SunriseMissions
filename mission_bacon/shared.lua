-- scripts/mission_bacon/shared.lua
local lib = require("lib.mission_lib")

return function(mission)
    local Slot, Directive = mission.Slot, mission.Directive
    return {
		glacier_region = lib.one(mission.states.STATE_80F6A028_0005_0000_80F6A984, "arrival state"),  -- 40 | Glacial drift
		miniheat_region = lib.one(mission.states.STATE_80F6A028_0008_0000_80F6A99B, "dynamo approach state"), -- 64 | Dynamo approach
		bray_region = lib.one(mission.states.STATE_80F6A028_0001_0000_80F6A01C, "braytech futurecapes state"), -- 8 | Braytech Futurecapes
		miniras_region = lib.one(mission.states.STATE_80F6A028_0009_0000_80F6A99C, "aurora reach state"), -- 72 | Aurora Reach
		rasputin_region = lib.one(mission.states.STATE_80F6A028_000A_0000_80F6A9A8, "mindlab: rasputin state"), -- 80 | Mindlab: Rasputin
		outro_state_region = lib.one(mission.states.STATE_80F6A028_0003_0001_80F6A01F, "outro cutscene state"), -- unsure | Outro cutscene
		
		music = lib.one(Slot.M_MUSIC_SENSOR_80F6A396, "music sensor"),
		dialog = lib.one(Slot.M_DIALOG_SENSOR_80F6A396, "dialog sensor"),
		
		hard_wipes = lib.one(Slot.HARD_WIPE_GLOBALS, "hard wipes"),
		
		goals = lib.one(Slot.M_DIRECTIVE_SENSOR_80F6A396, "goal sensor"),
		goal_goto_bray = lib.one(Directive.CLEAR_A_PATH_TO_CLOVIS_BRAY, "intro goal"),
		goal_secure_bray = lib.one(Directive.SECURE_BRAYTECH_FUTURESCAPE, "futurescapes goal"),
		goal_secure_bray_CC40FDF7 = lib.one(Directive.SECURE_BRAYTECH_FUTURESCAPE_CC40FDF7, "futurescapes goal with element"),
		goal_secure_bray_FF11C73B = lib.one(Directive.SECURE_BRAYTECH_FUTURESCAPE_FF11C73B, "futurescapes cleared goal"),
		goal_ascend_F9396C1F = lib.one(Directive.ASCEND_TO_RASPUTIN_F9396C1F, "rasputin intro goal"),
		goal_ascend = lib.one(Directive.ASCEND_TO_RASPUTIN, "rasputin 2nd goal"),
		goal_ascend_77B8EA63 = lib.one(Directive.ASCEND_TO_RASPUTIN_77B8EA63, "rasputin 3rd goal"),
		goal_ascend_F1426ED1 = lib.one(Directive.ASCEND_TO_RASPUTIN_F1426ED1, "rasputin cleared goal"),
		
		bookend_cinematic = lib.one(Slot.PF_CINEMATIC_BOOKEND_CINEMATIC, "bookend cinematic"),
	}
end