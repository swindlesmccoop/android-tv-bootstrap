# Getting Connected

## Installing adb
Grab the latest release of the [Android developer platform tools](https://developer.android.com/tools/releases/platform-tools) for your operating system. This package is also available in many distro package repos, so check for that first and only grab the zip file if necessary.

### If installing from package manager:
- Check that adb is in `$PATH` simply by typing it into the terminal. If it is, you can skip to `Enabling Wireless Debugging`

### If installing manually:
1. Extract the platform tools to somewhere where they are going to stay
2. Run the command `export PATH=$PATH:[full path to platform tools directory]` - example:
```bash
export PATH=$PATH:/usr/local/platform-tools
```
3. Type `adb` into the terminal. If the command runs then you are good to go to the next section. Do not close this terminal, or else you will have to run the command again for the script to find adb.

## Enabling Wireless Debugging
1. Go to `Settings > Device Preferences > About`, then scroll down to the Build numper and keep clicking it until you have developer options enabled
2. Go back one level and scroll all the way down to developer options
3. Enter developer settings, then scroll down and enable network debugging
4. Go to terminal and type `adb connect [first ip address shown on network debugging setting]`
  - This may fail at first, check your screen and hit the checkbox to remember your PC, then hit allow and then enter the command again
5. Go down two settings and disable adb authorization timeout, this way you can always connect as long as it is on
6. That's it! You can now run the main script and everything should work.