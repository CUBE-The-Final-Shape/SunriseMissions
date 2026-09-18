-- Titan. Open world: authored population per zone, respawns and public event sites.
-- Zones and their content are generated into content.lua from the packages.
-- Not tested in game. A cleared chest grants nothing: no script call reaches an account.
local missions = require("missions")
local mission = require(missions.FLEET_FREEROAM)
local freeroam = require("lib.freeroam")
local content = require("fleet_freeroam.content")

return freeroam.new{zones = content(mission, freeroam)}
