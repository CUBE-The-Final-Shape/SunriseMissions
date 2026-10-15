# Mercury and Homecoming port gaps

This compares the scripts with Dawn commit `3fd5b8f1324f1face4cdcc4befdcad924a56f1fc`.
The changes use Sunrise's native mission API. No client memory access, hooks or patches were added.
Live play remains unverified. A listed gap means the current port lacks that behavior; it does
not mean a server implementation is impossible.

Native squad profile support restores 105 support and scenery source requests through the
generated SDK certificate. Their original encounter gates remain in place.

## Ported changes

| mission | changes |
|---|---|
| The Gateway (`mission_abs`) | Reinforcements also start when the preceding group clears. The shelf and final platform preload together. The module spawns at its objective. Vance's squad is reserved before his scene. |
| Tree of Probabilities (`strike_pact`, `mission_pact`) | Only the gate defense blocks the first portal. The portal activates after that clear. The Gladiator and Thuun bind their named combatants. Forest defense starts after any accepted approach trigger. Boss exits require the health threshold and room clear, then wait for the next room's arrival. Route dialogue follows its own triggers. |
| A Garden World (`strike_bond`, `mission_bond`) | Blocks and golem lenses prepare at their steps. Golem lens destruction precedes the golem clear. Both golems in each boss phase receive scenes. Dendron binds his named combatant. Ordinary add clears no longer replace boss health thresholds. The partial campaign ending cannot award completion. |
| Beyond Infinity (`adventure_vod`) | Scene casts reserve their authored squads explicitly. Mixed casts activate their props. Both upper reflections start. The reveal stops before the return trip. Returning to the Forest or Lighthouse needs a new region report. |
| Omega (`mission_scot`) | Ikora's squad is reserved before her scene. Island and Crown waves wait for their arrival triggers. Clearing the support waves cannot award mission completion. |
| Homecoming (`mission_towerfall`) | The two hangar doors have separate hostile clear gates. The plaza has three assaults. The bazaar clear excludes Ikora and gates pickup. Ship populations prepare before approach. Turbine destruction lowers the matching light and drives the first two report lines. Reactor shutdown and four escape explosion scenes are requested through native slots. |
| Mercury Lighthouse (`mercury_freeroam`) | Patrol recipes select exact generated fallback variants. |

Homecoming retains its original opening cinematic. Amanda's pickup and the ending use their
authored cinematic states. Tests cover all three transitions.

All Forest generators still override only the seed and enabled flag. Dawn's numeric worker
inputs and anchor tables were not copied. The native default contract is documented in
`RE/72 "Type 37 preserves the authored worker defaults"` in the parent workspace.

## Remaining behavior

| mission | absent or partial behavior |
|---|---|
| The Gateway | Module vulnerability; final cannon launch policy; marchers' movement; exact gate-contact positioning; Vance's turn, speech completion, ascent and lighting cues. The existing scene request does not establish those intermediate events. |
| Tree of Probabilities | Eight of ten Forest exit defenders have no generated `Squad` entry. Harvester passenger delivery and departure are absent. Thuun's retreat movement, crossing immunity, scene cast ownership, room task assignment, music and checkpoints remain partial. Campaign scan dialogue has no playback-completion gate. |
| A Garden World | Lens vulnerability; golem release inputs and tether immunity; Dendron's carriage movement, parked states, shield ownership and cover cycles; early boss death interrupting unfinished shield phases. The campaign scanner, tree cues, Panoptes wipe, Sagira capture and final movie are incomplete. |
| Beyond Infinity | Plate capture/charge authority and lens exposure; reflection volume gates; scene inputs other than each scene's start input; scene speech-completion gates; the Forest's two route recipes and faction selection; precise portal device poses; ambush shields. Basic scene activation is not parity with the full authored scene. |
| Omega | Panoptes combat; reveal camera ownership; arm movement and island transfers; Crown charge pickup, dunk and eye phases; Osiris rescue; final cinematic and Mercury handoff. The retained enemy waves are a partial route. |
| Homecoming | Cayde, Shaxx, Centurion and Ikora scene entry choreography; frame combat-release inputs; Zavala arrival, Ward, death and revival; armory weapon rewards; carrier flights and impact sequences; mission music; exact scene-cast ownership and native scene-subtree receipts. The civilian and explosion scene requests need live validation. |
| Mercury Lighthouse | Vex Crossroads, faction-war progression and the adventure handoff. |

The current Lua API can send a named scene event, but it does not report Dawn's native scene
subtree observations. Type-53 dialogue has no playback-completion event in the current SDK.
Timers or unrelated clears do not substitute for those observations.

`scene:activate{spawn = true}` requires each extracted dependency to resolve to one exact
type-2 combatant and its source squad. The Mercury casts use explicit reserve-mode squad
placement instead. Mixed casts activate their authored type-4 objects separately.

## Evidence and review scope

Source paths below are relative to the pinned Dawn checkout. Local constants resolve against
the installed generated SDK. Source policy alone does not prove live behavior in this build.

| surface | status | inspected source |
|---|---|---|
| Gateway step graph | read | `Dawn/scripts/gateway.lua` |
| Gateway bindings and runtime | read | `Dawn/src/state/activity/gateway/bindings.h`, `runtime.cpp` |
| Gateway catalog and controller | partial | Catalog identities were compared where the script uses them; the full controller was not read. |
| Pact strike and campaign step graphs | read | `Dawn/scripts/strike_pact.lua`, `mission_pact.lua` |
| Pact native bindings | partial | `Dawn/src/state/activity/strike_pact/bindings.h` |
| Pact runtime and catalogs | partial | `runtime.h`; Forest recipe and defense; ledge population and ship lifecycle; boss room and cast sections. Full controller and hook bodies were not read. |
| Bond strike and campaign step graphs | read | `Dawn/scripts/strike_bond.lua`, `mission_bond.lua` |
| Bond native behavior | partial | `Dawn/src/state/activity/strike_bond/authority.h`, `forest_binding.h`, and lens/ending/boss binding sections. Full controller and hook bodies were not read. |
| Beyond Infinity step graph | read | `Dawn/scripts/beyond_infinity.lua` |
| Beyond Infinity native behavior | partial | `authority.h`, `runtime.h`, runtime event functions, faction-selection table and scene-cast catalog sections. Full controller and hook bodies were not read. |
| Omega step graph | read | `Dawn/scripts/omega.lua` |
| Omega native behavior | partial | `omega_mission_catalog.h`, `omega_mission_runtime.h`, `omega_progression.cpp`. Full mission state and client hook bodies were not read. |
| Homecoming native progression | read | `Dawn/src/state/activity/vanilla/homecoming/mission.h` and the progression constructor in `mission.cpp` |
| Homecoming scene support | partial | Scene-action declarations, scene validation tool, selected catalog identities and arrival milestone predicates. Native observer and hook bodies were not read in full. |
| Local helper and native API | read | Campaign helper, scene activation/event API, scene dependency and cast resolution, combatant binding and map-generator argument readers |
| Mercury fallback source identities | read | Installed `activity_sdk.pack`, generated mission constants, and exact type-66 descriptor rows for the 27 source choices |
| Live mission play | not read | No game was launched. |

The installed Homecoming packages confirm these scene resource links and input keys:

| scene | resource | graph | input |
|---|---|---|---|
| Shaxx | `0x80B8277D` | `0x80BEB7EF` | `0x6F51AC66` |
| Cayde | `0x80B8273C` | `0x80C3DEF5` | `0x6F51AC66` |
| Ikora | `0x80B8250B` | `0x80C3DD7D` | `0x6F51AC66`, `0x84FFD4F6`, `0x0B78A21A` |

These are identities, not proof of the input's timing or full effect. They are not sent by
the port. The resource's graph link is at `+0xC0`; the input keys were read from that graph's
event definitions. The SDK scene descriptors provide the resource tags.

The Lighthouse fallback variants match the original scenario, object, source slot, spawner and
occurrence. Their rule tags match the explicitly requested type-66 rule. Each retained variant
has all six runnable flags, exact requested actor profiles and a complete exact anchor set.
This is a script identity fix; the native runnable checks remain unchanged.

## Validation

Run from the parent workspace:

```text
python prod_client_tooling/tests/dawn_mercury_script_test.py
python prod_client_tooling/tests/dawn_homecoming_script_test.py
python prod_client_tooling/tests/dawn_campaign_native_test.py
```

The Mercury tests cover seven script walks, reinforcement fallback, independent combat gates,
fresh return-region reports, native patrol fallback validation and withheld completion for partial
endings. Homecoming tests cover
the cinematic route, two hangar gates, three plaza assaults and distinct turbine reports.
The fixtures validate script behavior and generated identities. They do not emulate actor AI,
scene internals, transport delivery or live client behavior.
