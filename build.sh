#!/bin/bash

# where to install RetroPie-Setup
RETROPIE_SETUP_PATH=/root/RetroPie-Setup
# build path for this build script
ODROIDC1_BUILD_PATH=/root/retroarch_fbdev_c1

source "$ODROIDC1_BUILD_PATH/retroarch_packages.sh"
source "$ODROIDC1_BUILD_PATH/system_prepare.sh"
source "$ODROIDC1_BUILD_PATH/system_splash.sh"
source "$ODROIDC1_BUILD_PATH/retroarch_install.sh"
source "$ODROIDC1_BUILD_PATH/retroarch_optimize.sh"

# clean lock, just in case...
rm -Rf /var/lib/dpkg/lock-frontend /var/lib/apt/lists/lock /var/cache/apt/archives/lock /var/lib/dpkg/lock

# update base system and install needed packages
system_prepare
# create uInitrd with splash image
system_splash
# compile retroarch and emulator cores
retroarch_install
# change some settings to make emulators faster on the C1/C0
retroarch_optimize

# clean up
systemctl stop apt-daily.timer
systemctl disable apt-daily.timer
systemctl mask apt-daily.service
systemctl disable apt-daily-upgrade wpa_supplicant
systemctl daemon-reload
apt-get clean

echo ""
echo "============================================"
echo " execute some tests to check for errors...  "
echo "============================================"
$ODROIDC1_BUILD_PATH/check_install.sh

echo ""
echo "============================================"
echo "if there is no error, you should reboot now "
echo "============================================"
