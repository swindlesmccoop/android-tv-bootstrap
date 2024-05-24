#!/bin/sh

if ! command -v adb > /dev/null 2>&1; then
    printf "adb not installed or not in PATH. Terminating.\n"
    exit 1
fi

DEVICE_COUNT="$(adb devices | wc -l)"

if [ "$DEVICE_COUNT" = "2" ]; then
	printf "Please connect your Shield device using adb. For instructions, see CONNECTING.md.\n"
	exit 1
fi

if ! [ "$DEVICE_COUNT" = "3" ]; then
	printf "More than one device found. Please disconnect everything except for the Shield.\n"
	exit 1
fi

if ! adb devices -l | grep "SHIELD_Android_TV" > /dev/null 2>&1; then
	printf "Please connect your Shield device using adb. For instructions, see CONNECTING.md.\n"
	exit 1
fi	

if ! adb shell true > /dev/null 2>&1; then
	printf "Could not run command on Shield device. Check if computer is trusted on Shield device. Terminating.\n"
	exit 1
fi


#disable ads, bloat, trash, spyware, etc
disable() {
	adb shell pm disable-user --user 0 $1
}

uninstall() {
	adb shell pm uninstall --user 0 $1
}

printf "All checks were successful and everything is ready to go. This is your last chance to back out now. Do you wish to continue? (Y/n): "
read -r CONTINUE

[ "$CONTINUE" != "y" ] && printf "Aborting.\n" && exit

disable android.autoinstalls.config.nvidia
disable com.amazon.amazonvideo.livingroom.nvidia
disable com.android.cts.ctsshim
disable com.android.cts.priv.ctsshim
disable com.android.dreams.basic
disable com.android.feedback
disable com.android.gallery3d
disable com.android.hotwordenrollment.okgoogle
disable com.android.hotwordenrollment.xgoogle
disable com.android.htmlviewer
disable com.android.keychain
disable com.android.printspooler
disable com.android.providers.calendar
disable com.android.providers.contacts
disable com.android.providers.userdictionary
disable com.android.se
disable com.android.settings.intelligence
disable com.google.android.apps.inputmethod.zhuyin
disable com.google.android.backdrop
disable com.google.android.backuptransport
disable com.google.android.feedback
disable com.google.android.gms
disable com.google.android.inputmethod.korean
disable com.google.android.inputmethod.pinyin
disable com.google.android.leanbacklauncher.recommendations
disable com.google.android.partnersetup
disable com.google.android.speech.pumpkin
disable com.google.android.syncadapters.calendar
disable com.google.android.syncadapters.contacts
disable com.google.android.tts
disable com.google.android.tv
disable com.google.android.tv.bugreportsender
disable com.google.android.tv.frameworkpackagestubs
disable com.google.android.tvrecommendations #gives stock launcher with just apps
disable com.google.android.tvtutorials
disable com.google.android.videos
disable com.nvidia.NvAccSt
disable com.nvidia.NvCPLUpdater
disable com.nvidia.SHIELD.Platform.Analyser
disable com.nvidia.benchmarkblocker
disable com.nvidia.beyonder.server
disable com.nvidia.developerwidget
disable com.nvidia.diagtools
disable com.nvidia.enhancedlogging
disable com.nvidia.factorybundling
disable com.nvidia.feedback
disable com.nvidia.hotwordsetup
disable com.nvidia.hotworksetup
disable com.nvidia.ocs
disable com.nvidia.ota
disable com.nvidia.shield.appselector
disable com.nvidia.shield.ask
disable com.nvidia.shield.nvcustomize
disable com.nvidia.shield.registration
disable com.nvidia.shield.remote.server
disable com.nvidia.shield.remotediagnostic
disable com.nvidia.shieldbeta
disable com.nvidia.shieldtech.hooks
disable com.nvidia.shieldtech.proxy
disable com.nvidia.stats
uninstall air.com.vudu.air.DownloaderTablet
uninstall com.amazon.amazonvideo.livingroom
uninstall com.amazon.music.tv
uninstall com.android.gallery3d
uninstall com.google.android.play.games
uninstall com.google.android.videos
uninstall com.google.android.youtube.tv
uninstall com.google.android.youtube.tvmusic
uninstall com.imdbtv.livingroom
uninstall com.netflix.ninja
uninstall com.nvidia.tegrazone3 # Nvidia Games
uninstall com.plexapp.android
uninstall com.plexapp.mediaserver.smb
disable com.android.vending # Play Store
#disable com.google.android.katniss #not disabled, needs to be enabled to sign into smarttube
#disable com.google.android.gsf
#disable com.google.android.marvin.talkback #this is not getting disabled because it is needed for button remapper

printf "\nWould you like to install recommended replacement apps? (Y/n): "
read -r REPLACE
[ "$REPLACE" != "y" ] && echo "Finished successfully!" && exit

#install better apps
printf "\nDownloading F-Droid (FOSS app storefront)...\n"
curl -LO "https://f-droid.org/F-Droid.apk"
adb install "F-Droid.apk"

printf "\nDownloading Aurora Store (Play Store replacement)...\n"
AURORA_VER="4.4.4"
curl -LO "https://auroraoss.com/downloads/AuroraStore/Release/AuroraStore-${AURORA_VER}.apk"
adb install "AuroraStore-${AURORA_VER}.apk"

printf "\nDownloading SmartTube Beta (YouTube replacement)...\n"
SMARTTUBE_VER="21.92"
curl -LO "https://github.com/yuliskov/SmartTube/releases/download/21.92/SmartTube_beta_${SMARTTUBE_VER}_arm64-v8a.apk"
adb install "SmartTube_beta_${SMARTTUBE_VER}_arm64-v8a.apk"

printf "Everything should be finished. Device needs to reboot. Reboot now? (Y/n): "
read -r REBOOT
[ "$REBOOT" = "y" ] && adb reboot
