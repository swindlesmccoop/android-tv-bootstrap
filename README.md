# Android TV Bootstrapper
This script should get rid of all of the nonsense on Android TV devices, disable garbage and bloat, get rid of Google services and telemetry, and more. Due to the scope of this project, it's impossible to get rid of *everything*, but this should definitely help. Simply run `./bootstrap.sh` and you should be good to go - if not, the script will tell you steps you need to take.

If something goes wrong, you can always factory reset, [even if it does not boot](https://nvidia.custhelp.com/app/answers/detail/a_id/4052/related/1)

## Supported devices
- Nvidia Shield TV Pro 2019

## What this does

### Adds (asks before installing)
- Aurora Store
  - PlayStore replacement
- F-Droid
  - FOSS app repository
  - Tip: add the IzzyOnDroid repo
- SmartTube
  - YouTube replacement
  - Decent UI
  - Has casting support
  - SponsorBlock and adblock enabled by default

### Removes/disables
- Home screen advertisements (now it just shows apps)
- All pre-installed apps forced on you
- Google stuff
  - Google sign-in
  - Voice control
  - Play services
  - Play Store
  - Etc...
- Nvidia stuff
  - Nvidia Games
  - Nvidia telemetry stuff
  - Etc...
- Amazon stuff
