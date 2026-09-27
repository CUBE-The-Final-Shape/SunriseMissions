-- The Tangled Shore. Open world: authored population per zone, respawns and public event sites.
-- Zones and their content are generated into content.lua from the packages.
-- Not tested in game. A cleared chest grants nothing: no script call reaches an account.
local missions = require("missions")
local mission = require(missions.TANGLED_SHORE_FREEROAM)
local freeroam = require("lib.freeroam")
local content = require("tangled_shore_freeroam.content")
local sectors = require("tangled_shore_freeroam.sectors")

return freeroam.new{zones = content(mission, freeroam),
    sectors = sectors(mission, freeroam)}
