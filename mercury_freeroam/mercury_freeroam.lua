-- Mercury patrol, portals and Vance; live behavior remains unverified.
-- Vex Crossroads, faction-war progression and adventure handoff remain absent.
local missions = require("missions")
local mission = require(missions.MERCURY_FREEROAM)
local freeroam = require("lib.freeroam")
local content = require("mercury_freeroam.content")
local sectors = require("mercury_freeroam.sectors")
local population = require("mercury_freeroam.population")
local Slot = mission.Slot
local LIGHTHOUSE = mission.states.STATE_80F4696A_000F_0000_80F46AD5.region_index
local zones = content(mission, freeroam)
for _, zone in ipairs(zones) do
    if zone.region == LIGHTHOUSE then
        zone.patrol = population(mission, freeroam)
        zone.ambient = {freeroam.unit(mission.Squad.SQ_VANCE, Slot.SQ_VANCE, {counts = {1}})}
        local events = {}
        for _, event in ipairs(zone.events or {}) do
            if event.sensor ~= Slot.M_PUBLIC_EVENT_SENSOR_80F5E517 then
                events[#events + 1] = event
            end
        end
        zone.events = events
    end
end

local script = freeroam.new{zones = zones, sectors = sectors(mission, freeroam)}
local enter = script.on_event_region_changed
script.on_event_region_changed = function(context, state, event)
    if event.attempt_generation ~= context.attempt_generation then return end
    enter(context, state, event)
    if context.activity_role ~= "public" or event.region_index ~= LIGHTHOUSE
        or state:variable("mercury.services") == context.attempt_generation then return end
    context:set_variable("mercury.services", context.attempt_generation)
    context:activate_objects{slots = {
        Slot.O_VENDOR_TELEPORTER_0, Slot.O_VENDOR_TELEPORTER_1,
        Slot.O_VENDOR_TELEPORTER_2, Slot.O_VENDOR_TELEPORTER_3,
        Slot.O_CENTER_TELEPORTER, Slot.O_SIDE_TELEPORTER,
        Slot.O_IA_ASCEND, Slot.O_IA_HORDE, Slot.O_IA_INTERCEPT,
    }, active = true}
    context:slot(Slot.SQ_VANCE_IDLE):play_performance{
        state = mission.PerformanceState.SQ_VANCE_IDLE.STATE_010B0F07,
    }
end

return script
