-- The European Dead Zone. Open world: authored zone population, respawns and public event sites.
-- content.lua is generated from the packages. sectors.lua sets each Lost Sector's encounter.
-- Live behavior is unverified.
local missions = require("missions")
local mission = require(missions.EDZ_FREEROAM)
local freeroam = require("lib.freeroam")
local content = require("edz_freeroam.content")
local sectors = require("edz_freeroam.sectors")

return freeroam.new{zones = content(mission, freeroam),
    sectors = sectors(mission, freeroam)}
