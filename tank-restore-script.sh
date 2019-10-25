#!/bin/bash
# Author: Brenden Gonzalez
# Date-Made: 10/25/2019
# Verison: 0.1Alpha
# Tested: No

# Legal disclaimer
echo "PROCEED AT YOUR OWN RISK I AM NOT RESPONSIBLE FOR ANY DAMAGE DONE TO YOUR DEVICE"
read -p "Would you like to Continue (y/n)?" choice
case "$choice" in 
  y|Y ) echo "yes";;
  n|N ) echo "no";;
  * ) echo "invalid";;
esac


# This checks for the firestick via adb
echo "Checking for ADB devices"
adb devices -l | find "device product:" >nul
if errorlevel 1 (
    echo Firestick not connected
) else (
    echo Firestick Found!
    ..............
)


# Pushing recovery img to firestick
echo "pushing Recovery to Firestick"
adb push recovery.img /sdcard
if errorlevel 1 (
echo Recovery failed to write to Firestick!
) else (
echo Recovery succesfully written to Firestick!
)


# Changing file permissions
echo "Accessing device shell"
echo "Please grant superuser access when prompted on screen!"
adb shell "
su
chmod 777 /cache
chmod 777 /cache/recovery
cd /cache/recovery
exit
exit
"
echo "Permissions where succesfully changed"


# Installing recovery.img to system partition
adb shell "
su
echo --update_package=/cache/update.zip > command
dd if=/sdcard/recovery.img of=/dev/block/platform/mtk-msdc.0/by-name/recovery
exit
exit
"
echo "Recovery was succesfully flashed to Firestick!"


# Clearing cache/pushing update.zip
echo "Uploading update.zip to firestick"
echo "You may be asked to grant superuser access again"
adb shell "
su
rm -f /cache/*.bin
rm -f /cache/*.zip
exit
exit
"
adb push update.zip /cache


# Rebooting to recovery to finish update
"Script is finished would you like to reboot to finish restore process"
read -p "Would you like to Continue (y/n)?" choice
case "$choice" in 
  y|Y ) echo "yes";;
  n|N ) echo "no";;
  * ) echo "invalid";;
esac
echo "Firestick successfully restored to stock"