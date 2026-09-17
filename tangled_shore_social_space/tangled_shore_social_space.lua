local missions = require("missions")
local mission = require(missions.TANGLED_SHORE_SOCIAL_SPACE)
local lib = require("lib.mission_lib")
local spider_safehouse = require("tangled_shore.spider_safehouse")

-- Spider's Safehouse as its own activity. One bubble, region 168.
local SAFEHOUSE_STATE =
    lib.one(mission.states.STATE_80FD4401_0015_0000_80FD43FE, "safehouse state")

local build_safehouse = spider_safehouse(mission, SAFEHOUSE_STATE)

-- A reattach reopens this script in a fresh VM, so the mark lives in mission state.
local BUILT_KEY = "safehouse_built"

return {
    on_event_region_changed = function(context, state, event)
        if event.region_index ~= SAFEHOUSE_STATE.region_index
            or state:variable(BUILT_KEY) then
            return
        end
        context:set_variable(BUILT_KEY, true)
        build_safehouse(context)
    end,
}
