#!/bin/bash

# Confirming you would like to proceed
while true; do
read -p "Welcome to Firestick Restore would you like to proceed y/n?" yn
case $yn in
[Yy]* ) break;;
[Nn]* ) exit;;
* ) echo "Please answer y/n?";;
esac
done

# checking for adb device
adb devices
while true; do
read -p "Is your firestick listed y/n?" yn
case $yn in
[Yy]* ) break;;
[Nn]* ) exit;;
* ) echo "Please answer y/n?";;
esac
done

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
