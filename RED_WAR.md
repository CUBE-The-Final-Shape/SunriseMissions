# Red War campaign map

One draft script per Red War mission, and the package facts each one rests on. Only Homecoming
has run in game: it loads and runs, but much of it is still wrong or missing.

## Warning
These are only early drafts and are largely broken or missing things. They contain basic
structure but not much beyond that.

## Identity

The campaign has sixteen playable missions. Each one is an activity definition with a scenario,
and the runtime loads `<activity name>/<activity name>.lua` from this directory, so the activity
name is also the script's folder and filename.

| mission | activity | definition | scenario | destination |
|---|---|---|---|---|
| Homecoming | `mission_towerfall` | `0x62D85FB3` | `0x80B500BC` | city_tower_d16_t0 |
| Adieu | `mission_journey` | `0xB913ED3F` | `0x80B5E01F` | arcade_spark |
| Spark | `mission_rise` | `0xC83D621A` | `0x80B5E372` | arcade_spark |
| Combustion | `mission_deadzone` | `0x7A5372B5` | `0x80B9AD31` | edz |
| Hope | `mission_vacancy` | `0xC306CC98` | `0x80B3FC6A` | fleet |
| Riptide | `mission_lights` | `0xBB9E35A6` | `0x80B3ED9A` | fleet |
| Utopia | `mission_reclamation` | `0x988F1948` | `0x80B3F2DF` | fleet |
| Looped | `mission_prospect` | `0x58DC8B41` | `0x80B4335B` | planet_x |
| Six | `mission_calculon` | `0x9D857512` | `0x80B42BAA` | planet_x |
| Sacrilege | `mission_leech` | `0x7DFCAFFC` | `0x80BD275F` | eden |
| Fury | `mission_heist` | `0x88F32E08` | `0x80BD2094` | eden |
| Payback | `mission_thunder` | `0xAE72EF09` | `0x80B9BE52` | edz |
| Unbroken | `mission_revenge` | `0x37F09185` | `0x80B9B781` | edz |
| Larceny | `mission_voyage` | `0x4A1CA2E6` | `0x80BDA2F4` | edz |
| 1AU | `mission_ember` | `0x38F926B2` | `0x80B3C09E` | cabal_ship |
| Chosen | `mission_reunion` | `0x20FE51B3` | `0x80B62030` | arcade_reunion |

Two other definitions carry a Red War display name and no scenario, so neither is playable:
`0xF07A75D3` "Homecoming" and the five `arcade_*` activities, whose description is "Relive the
X experience".