-- Tower Approach. Plays the bookend cutscene to check whether it is Homecoming's missing briefing.
-- Not a mission: nothing follows the cutscene.
local missions = require("missions")
local mission = require(missions.CINE_110_TWR)
local lib = require("lib.mission_lib")

-- The bookend is the only cutscene in bubble 3's second state.
local BOOKEND_STATE =
    lib.one(mission.states.STATE_80B4A0EA_0003_0001_80B4A0FC, "bookend cutscene state")
local BOOKEND = lib.one(mission.Slot.CIN_110_TWR_BOOKEND_CINEMATIC, "bookend cinematic")

local PHASE_KEY = "bookend"
local PLAYING, ENDED = 1, 2

-- The client holds the cutscene region, so only the start is owed.
local function start(context, state, region)
    if region ~= BOOKEND_STATE.region_index or state:variable(PHASE_KEY) ~= nil then return end
    context:set_variable(PHASE_KEY, PLAYING)
    context:slot(BOOKEND):set_cinematic_active{active = true}
end

local function stop(context, state)
    if state:variable(PHASE_KEY) ~= PLAYING then return end
    context:set_variable(PHASE_KEY, ENDED)
    context:slot(BOOKEND):set_cinematic_active{active = false}
end

return {
    initial_state = BOOKEND_STATE,
    on_event_region_changed = function(context, state, event)
        start(context, state, event.region_index)
    end,
    on_event_client_state_changed = function(context, state, event)
        if event.entered == true then start(context, state, event.held_region_index) end
    end,
    -- End, skip and a refused start all arrive here.
    on_event_cinematic_terminated = function(context, state, event)
        if lib.is_slot(context, event, BOOKEND) then stop(context, state) end
    end,
    -- A reattach lands in the world, so a cutscene still marked playing is ended.
    on_load = function(context, state)
        stop(context, state)
    end,
}
