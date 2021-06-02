#/bin/bash

# build path for this build script
ODROIDC1_BUILD_PATH=/root/retroarch_fbdev_c1

echo ""
echo "============================================"
echo " install custom asound.conf                 "
echo "============================================"
cp $ODROIDC1_BUILD_PATH/configs/asound.conf /etc/

