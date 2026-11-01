-- scripts/mission_bacon/glacier.lua
local lib = require("lib.mission_lib")

return function(mission)
	local Slot = mission.Slot
	return {
		line_open = lib.one(mission.DialogueCue.M_DIALOG_SENSOR_80F6A396.CUE_1, "opening line"),
		line_open_cont = lib.one(mission.DialogueCue.M_DIALOG_SENSOR_80F6A396.CUE_2, "opening cont. line"),
		
		navpoint = lib.one(Slot.NP_GOTO_BRAY_80F6A1AB, "opening navpoint"),
		
		at_intro_directive = lib.one(Slot.PT_INTRO_DIRECTIVE, "intro directive trigger"),
		at_endphase = lib.one(Slot.PT_ENDPHASE, "endphase trigger"),
		at_endphase_alt = lib.one(Slot.PT_ENDPHASE_ALT, "endphase alt trigger"),
		
		o_seraph_tower_0 = lib.one(Slot.O_SERAPH_TOWER0_80F73E47, "seraph tower 0"),
		o_seraph_tower_1 = lib.one(Slot.O_SERAPH_TOWER1_80F73E47, "seraph tower 1"),
		o_seraph_tower_2 = lib.one(Slot.O_SERAPH_TOWER2_80F73E47, "seraph tower 2"),
		o_seraph_tower_3 = lib.one(Slot.O_SERAPH_TOWER3_80F73E47, "seraph tower 3"),
		o_seraph_tower_4 = lib.one(Slot.O_SERAPH_TOWER4_80F73E47, "seraph tower 4"),
		o_javelin_floor0_80F73E47 = lib.one(Slot.O_JAVELIN_FLOOR0_80F73E47, "javelin floor 0"),
		o_javelin_floor1_80F73E47 = lib.one(Slot.O_JAVELIN_FLOOR1_80F73E47, "javelin floor 1"),
		o_javelin_floor2_80F73E47 = lib.one(Slot.O_JAVELIN_FLOOR2_80F73E47, "javelin floor 2"),
		o_javelin_floor3_80F73E47 = lib.one(Slot.O_JAVELIN_FLOOR3_80F73E47, "javelin floor 3"),
		o_javelin_floor4_80F73E47 = lib.one(Slot.O_JAVELIN_FLOOR4_80F73E47, "javelin floor 4"),
	}
end
--[[
	Intro dialog: M_ENGAGEMENT_SENSOR_80F6A19A
	Going left side: M_ENGAGEMENT_SENSOR_80F6A1B8
]]