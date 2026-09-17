# Sunrise Missions

Mission scripts for the Sunrise Destiny 2 offline preservation mod.

- [Scripting Documentation](https://projectsunrise.dev/docs/mission-scripting/)
- [Sunrise](https://github.com/stanuwu/Sunrise)
- [Discord](https://discord.gg/22JS6et5k9)

## Install

The launcher installs these scripts with the mod and updates them for you. That is the normal
route: see the [install guide](https://projectsunrise.dev/guides/installing/).

To work on the scripts yourself, replace that copy with a clone. Sunrise reads the folder directly:

```powershell
cd "<Destiny 2>/bin/x64/Sunrise"
git clone https://github.com/stanuwu/SunriseMissions scripts
```

A manual clone does not update itself. Pull it yourself, or let the launcher take the folder back.

## Layout

One folder per activity, named after the activity. The script inside carries the same name:
`<name>/<name>.lua`. Helpers for one activity sit in its folder and load as
`require("<name>.<helper>")`. Shared helpers live in `lib/`.

| file | holds |
|---|---|
| `lib/mission_lib.lua` | shared helpers |
| `lib/flow.lua` | step graphs, with retained early facts and start conditions |
| `lib/campaign.lua` | the step chain the Red War drafts run on |
| `lib/combat.lua` | shared task group choice |

## Contributing

Pull requests are welcome. Keep the folder and file naming, and keep identities coming from the
`missions` module. Only PR tested and working parts. If your script needs unmerged SDK or API
changes, wait until those are merged.

Everything else like installing the mod, building it, credits and the disclaimers lives in the
[main repository](https://github.com/stanuwu/Sunrise).
