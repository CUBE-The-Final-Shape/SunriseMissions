-- Spider's safehouse, region 168. No timers, so no suspend and no resume.
local lib = require("lib.mission_lib")
local spider_safehouse = require("tangled_shore.spider_safehouse")

return function(mission)
    local state = lib.one(mission.states.STATE_80FC9645_0015_0000_80FC95F9, "safehouse state")
    local build = spider_safehouse(mission, state)

    return {
        tag = "s",
        state = state,
        enter = function(context, scope, salt)
            build(context)
        end,
    }
end
