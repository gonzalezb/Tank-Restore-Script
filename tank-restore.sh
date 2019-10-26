#!/bin/bash

# Confirming device is connected
echo "Welcome to Firestick Restore Script"
adb devices
echo "Do you see you Firestick Listed?"
read -p "Continue (y/n)?" choice
case "$choice" in 
y|Y ) echo "yes";;
n|N ) echo "no";;
* ) echo "invalid";;
esac

# Doing wizard magic on the Firestick
echo "Pushing recovery to device"
adb push recovery.img /sdcard
echo "Doing Wizard Magic"
adb shell "
su
chmod 777 /cache
chmod 777 /cache/recovery
cd /cache/recovery
echo --update_package=/cache/update.zip > command
dd if=/sdcard/recovery.img of=/dev/block/platform/mtk-msdc.0/by-name/recovery
exit
exit
"

echo "Recovery successfully sent to device"
echo "Wizard Magic Successful"

adb shell "
su
rm -r /cache/*.bin
rm -r /cache/*.zip
exit
exit
"
adb push update.zip /cache
echo "Casting Spells Complete"
echo "Confirm Firestick restart to finish restore"
read -p "Continue (y/n)?" choice
case "$choice" in 
y|Y ) echo "yes";;
n|N ) echo "no";;
* ) echo "invalid";;
esac
echo "Firestick restore complete"
