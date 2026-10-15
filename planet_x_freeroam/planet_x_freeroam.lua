-- Nessus. Open world: authored population per zone, respawns and public event sites.
-- content.lua is generated from the packages. sectors.lua sets each Lost Sector's encounter.
-- Live behavior is unverified.
local missions = require("missions")
local mission = require(missions.PLANET_X_FREEROAM)
local freeroam = require("lib.freeroam")
local content = require("planet_x_freeroam.content")
local sectors = require("planet_x_freeroam.sectors")

return freeroam.new{zones = content(mission, freeroam),
    sectors = sectors(mission, freeroam)}
