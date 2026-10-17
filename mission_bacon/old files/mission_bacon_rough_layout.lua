--[[
context:slot(Slot.M_MUSIC_SENSOR_80F6A396):set_music_section{section = X}
	Section:
	1, intro music
	2, no music
	3, combat music
	4, ana vignette
	5, pt_locate_entrance, rasputin_reveal
	6, combat music
	7, no music
	8, combat music, spear?
	9, combat music
	10, no music
	11, eerie music
--------
INTRO REGION
--------
context:slot(Slot.PT_INTRO_DIRECTIVE):fire_trigger()
context:slot(Slot.PT_ENDPHASE):fire_trigger()
context:slot(Slot.PT_ENDPHASE_ALT):fire_trigger()
context:slot(Slot.PT_GOTO_BRAY_RIGHT):fire_trigger()
context:slot(Slot.PT_GOTO_BRAY_LEFT):fire_trigger()
context:slot(Slot.PT_SPAWN_DROPSHIPS_RIGHT):fire_trigger()
context:slot(Slot.PT_SPAWN_DROPSHIPS_LEFT):fire_trigger()

context:slot(dialog_sensor):play_dialogue_cue{cue = cues.CUE_1}

context:slot(Slot.M_DIRECTIVE_SENSOR_80F6A396):set_directive{
		directive = Directive.CLEAR_A_PATH_TO_CLOVIS_BRAY,
		navpoint = context:slot(Slot.NP_GOTO_BRAY_80F6A1AB),
}

context:slot(dialog_sensor):play_dialogue_cue{cue = cues.CUE_2}

-- Some directive update needed

--------
BRAYTECH FUTURESCAPES
--------

context:slot(Slot.PT_SEED_PROPS):fire_trigger()
context:slot(Slot.PT_BYPASS_RIGHT):fire_trigger()
context:slot(Slot.PT_BYPASSED_LEFT):fire_trigger()
context:slot(Slot.PT_GOTO_BRAY_RIGHT):fire_trigger()
context:slot(Slot.PT_GOTO_BRAY_LEFT):fire_trigger()
context:slot(Slot.PT_SPAWN_DROPSHIPS_RIGHT):fire_trigger()
context:slot(Slot.PT_SPAWN_DROPSHIPS_LEFT):fire_trigger()

context:slot(Slot.PT_ACTIVATE_BOSS_WAYPOINT):fire_trigger()
context:slot(Slot.PT_START_BALCONY_MONITOR):fire_trigger()

context:slot(Slot.O_MINI_RAS_DOOR):set_object_active{active = true}
context:slot(Slot.O_SERAPH_TOWER0_80F739EA):set_object_active{active = true}
context:slot(Slot.O_SERAPH_TOWER1_80F739EA):set_object_active{active = true}
context:slot(Slot.O_SERAPH_TOWER2_80F739EA):set_object_active{active = true}
context:slot(Slot.O_SERAPH_TOWER3_80F739EA):set_object_active{active = true}
context:slot(Slot.O_SERAPH_TOWER4_80F739EA):set_object_active{active = true}
context:slot(Slot.O_AVOIDANCE_0_80F739EA):set_object_active{active = true}
context:slot(Slot.O_AVOIDANCE_1_80F739EA):set_object_active{active = true}
context:slot(Slot.O_AVOIDANCE_2_80F739EA):set_object_active{active = true}
context:slot(Slot.O_AVOIDANCE_3_80F739EA):set_object_active{active = true}
context:slot(Slot.O_AVOIDANCE_4_80F739EA):set_object_active{active = true}

place_squads(context, ARENAS[1], "squad_intro")
place_squads(context, ARENAS[1], "squad_a")
place_squads(context, ARENAS[1], "squad_b")
place_squads(context, ARENAS[1], "squad_c")
place_squads(context, ARENAS[1], "squad_reinforce_a1")
place_squads(context, ARENAS[1], "squad_reinforce_a2")
place_squads(context, ARENAS[1], "squad_reinforce_b")
place_squads(context, ARENAS[1], "squad_reinforce_c")
place_squads(context, ARENAS[1], "squad_boss")

-- On arena cleared
context:slot(Slot.PT_SIGNAL_ANA):fire_trigger()
	-- On PT_SIGNAL_ANA triggered
	context:slot(Slot.O_START_VIGNETTE):set_object_active{active = true}
	context:slot(Slot.O_LARGE_NUTBLOCKER):set_object_active{active = true}
	context:slot(Slot.O_LARGE_NUTBLOCKER_2):set_object_active{active = true}

	context:slot(Slot.O_SMALL_NUTBLOCKER):set_object_active{active = true}
	context:slot(Slot.O_SMALL_NUTBLOCKER_2):set_object_active{active = true}

	context:slot(Slot.M_MUSIC_SENSOR_80F6A396):set_music_section{section = 4}

	context:scene(mission.Scene.SCN_ANA_POWER_UP_BRAY):activate{} -- Nutblockers need to be active for the scene to function
	context:squad(mission.Squad.SQ_ANA_VIGNETTE):place{}
	context:scene(mission.Scene.SCN_ANA_POWER_UP_BRAY):send_event{key = 0x8803483C} -- start vignette
	
	-- After cue 13
	context:slot(Slot.O_MINI_RAS_DOOR):transition{
		transition = context.sdk.device_transitions.open,
	}
	
	context:slot(Slot.PT_END_PHASE_80F6A179):fire_trigger()
		-- On PT_END_PHASE_80F6A179 triggered
		context:slot(dialog_sensor):play_dialogue_cue{cue = cues.CUE_14}
	
	--After scene
	context:slot(Slot.M_DIRECTIVE_SENSOR_80F6A396):set_directive{
		directive = Directive.CLEAR_A_PATH_TO_CLOVIS_BRAY,
		navpoint = context:slot(Slot.SLOT_0015_80F6A179),
	}

--------
AURORA REACH
--------
context:slot(Slot.DOOR_DEVICE):transition{
	transition = context.sdk.device_transitions.open,
}

context:slot(Slot.PT_LOCATE_ENTRANCE):fire_trigger()
	-- On PT_LOCATE_ENTRANCE
	context:slot(Slot.M_MUSIC_SENSOR_80F6A396):set_music_section{section = 2}
	-- delayed dialouge ca 5 sec
	context:slot(dialog_sensor):play_dialogue_cue{cue = cues.CUE_15}

context:slot(Slot.PT_END_PHASE_80F6A1DD):fire_trigger()
	-- On PT_END_PHASE_80F6A1DD
	context:slot(dialog_sensor):play_dialogue_cue{cue = cues.CUE_18}

--------
MINDLAB: RASPUTIN
--------
context:slot(Slot.PT_SPAWN_LOWER_ENCOUNTERS):fire_trigger()
	-- On PT_SPAWN_LOWER_ENCOUNTERS
	place_squads(context, ARENAS[2], "lower_encounter")
	
context:slot(Slot.PT_MUS_HIVE_ATTACK):fire_trigger()
	-- On PT_MUS_HIVE_ATTACK
	context:slot(Slot.M_MUSIC_SENSOR_80F6A396):set_music_section{section = ?}
	
context:slot(Slot.PT_ELEVATOR_SEED_PROPS):fire_trigger()
context:slot(Slot.PT_ELEVATOR_SPAWN_WIZARDS):fire_trigger()
	-- On PT_ELEVATOR_SPAWN_WIZARDS
	place_squads(context, ARENAS[2], "elevator_wizards")
	
context:slot(Slot.PT_ELEVATOR_SPAWN_MELEE):fire_trigger()
	-- On PT_ELEVATOR_SPAWN_MELEE
	place_squads(context, ARENAS[2], "elevator_melee")
	
context:slot(Slot.PT_ASCENSION_ELEVATOR):fire_trigger()
	-- On PT_ASCENSION_ELEVATOR
	place_squads(context, ARENAS[3], "pipes_front")

context:slot(Slot.PT_SPAWN_OVERRIDES_OFF):fire_trigger()
	-- On PT_SPAWN_OVERRIDES_OFF
	context:slot(dialog_sensor):play_dialogue_cue{cue = cues.CUE_19}
	
context:slot(Slot.PT_PIPES_SPAWN_BACK):fire_trigger()
	-- On PT_PIPES_SPAWN_BACK
	place_squads(context, ARENAS[3], "pipes_back")

context:slot(Slot.PT_SPAWN_OVERRIDES_ON):fire_trigger()

context:slot(Slot.PT_HIVE_MUSIC_END):fire_trigger()
context:slot(Slot.PT_ASCENSION_CABLE):fire_trigger()
context:slot(Slot.PT_ASCENSION_CABLE_2):fire_trigger()
context:slot(Slot.PT_SPAWN_SPEAR_INTRO):fire_trigger()


context:slot(Slot.PT_LEFT_HIVE_MUSIC_END):fire_trigger()
context:slot(Slot.PT_LEFT_ASCENSION_CABLE):fire_trigger()
context:slot(Slot.PT_LEFT_ASCENSION_CABLE_2):fire_trigger()
context:slot(Slot.PT_SPAWN_SPEAR_INTRO_ALT):fire_trigger()

	-- On PT_ASCENSION_CABLE or PT_LEFT_ASCENSION_CABLE
	context:slot(dialog_sensor):play_dialogue_cue{cue = cues.CUE_20}
	
	-- On PT_ASCENSION_CABLE_2 or PT_LEFT_ASCENSION_CABLE_2
	context:slot(dialog_sensor):play_dialogue_cue{cue = cues.CUE_21}
	
	-- On PT_SPAWN_SPEAR_INTRO or PT_SPAWN_SPEAR_INTRO_ALT
	place_squads(context, ARENAS[4])
	context:slot(dialog_sensor):play_dialogue_cue{cue = cues.CUE_22}
	-- wait x sec
	context:slot(Slot.O_JAVELIN_SPAWNER_LANDING):set_object_active{active = true}
	context:slot(Slot.O_JAVELIN_VFX):set_object_active{active = true}
	context:slot(Slot.M_MUSIC_SENSOR_80F6A396):set_music_section{section = ?}
	context:slot(dialog_sensor):play_dialogue_cue{cue = cues.CUE_23}
	place_squads(context, ARENAS[5])


	-- On Javelin pickup
	context:slot(Slot.HARD_WIPE_GLOBALS):set_darkness_zone{enabled = true}
	context:slot(Slot.PT_HOOK_TROOPER_FALLBACK):fire_trigger()
		-- PT_HOOK_TROOPER_FALLBACK
		context:slot(Slot.D_JAVELIN_DOOR):transition{
			transition = context.sdk.device_transitions.open,
		}
		
context:slot(Slot.O_JAVELIN_SPAWNER_LOWER):set_object_active{active = true}
context:slot(Slot.O_JAVELIN_SPAWNER_UPPER):set_object_active{active = true}
-- These should be on repeating timers until arena 6 is cleared

context:slot(Slot.PT_HOOK_SPAWN_THRALL):fire_trigger()
context:slot(Slot.PT_HOOK_SPAWN_THRALL_1):fire_trigger()

context:slot(Slot.PT_THRONE_SPAWN_ENCOUNTER):fire_trigger()
	-- On PT_THRONE_SPAWN_ENCOUNTER
	place_squads(context, ARENAS[6], "assault_trooper")
	place_squads(context, ARENAS[6], "assault_crusader")
	place_squads(context, ARENAS[6], "assault_thrall")
	place_squads(context, ARENAS[6], "assault_ultra")
	place_squads(context, ARENAS[6], "assault_sniper")
	place_squads(context, ARENAS[6], "assault_boomer")

context:slot(Slot.PT_SPAWN_LOWER_ENEMIES_GATE):fire_trigger()
context:slot(Slot.PT_ASCENSION_LEFT):fire_trigger()
context:slot(Slot.PT_THRONE_WAKE_COMBATANTS):fire_trigger()

	-- On arena 6 cleared
	context:slot(Slot.D_DOOR_1):transition{
		transition = context.sdk.device_transitions.open,
	}
	
context:slot(Slot.PT_MACHINE_GOD):fire_trigger()
	-- On PT_MACHINE_GOD
	context:slot(dialog_sensor):play_dialogue_cue{cue = cues.CUE_24}
		-- After cue 24
		local key = context:select_state(mission.states.STATE_80F6A028_0003_0001_80F6A01F)
		context:set_variable("move_request", key.value)
		context:slot(Slot.PF_CINEMATIC_BOOKEND_CINEMATIC):set_cinematic_active{active = true}
		]]