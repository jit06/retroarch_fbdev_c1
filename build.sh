#!/bin/bash

# where to install RetroPie-Setup
RETROPIE_SETUP_PATH=/root/RetroPie-Setup
# build path for this build script
ODROIDC1_BUILD_PATH=/root/retroarch_fbdev_c1/

source "$ODROIDC1_BUILD_PATH/retroarch_packages.sh"
source "$ODROIDC1_BUILD_PATH/system_prepare.sh"
source "$ODROIDC1_BUILD_PATH/system_optimize.sh"
source "$ODROIDC1_BUILD_PATH/system_splash.sh"
source "$ODROIDC1_BUILD_PATH/retroarch_install.sh"
source "$ODROIDC1_BUILD_PATH/retroarch_optimize.sh"

# update base system and install needed packages
system_prepare
# tweak for fast boot and fewer disk write
system_optimize
# create uInitrd with splash image
system_splash
# compile retroarch and emulator cores
retroarch_install
# change some settings to make emulators faster on the C1/C0
retroarch_optimize

# clean up
sudo apt-get clean

echo ""
echo "============================================"
echo "if everything went ok, you should reboot now"
echo "============================================"
