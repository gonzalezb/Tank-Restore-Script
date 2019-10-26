#!/bin/bash
# Author: Brenden Gonzalez
# Date of edit: 10/26/2019
# Verison: 0.8 Beta
# License: GPL 3.0

# Change color of text to green
echo "$(tput setaf 2)"

# List verison of script
echo "Script Verison: 0.8 Beta"

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

# Progress 20%
echo -ne '#####                         (20%)\r'
sleep 1

# Doing wizard magic on the Firestick
adb push recovery.img /sdcard

# Progress 40%
echo -ne '#########                     (40%)\r'
sleep 1
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

echo -ne '#####################         (80%)\r'
sleep 1
adb shell "
su
rm -r /cache/*.bin
rm -r /cache/*.zip
exit
exit
"
adb push update.zip /cache
echo -ne '##############################(100%)\r'
sleep 1
while true; do
read -p "Please confirm to reboot Firestick to finish restore y/n?" yn
case $yn in
[Yy]* ) break;;
[Nn]* ) exit;;
* ) echo "Please answer y/n?";;
esac
done
adb reboot recovery
echo "Firestick rebooting"
echo "Firestick restore complete"

