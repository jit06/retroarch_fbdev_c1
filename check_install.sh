#!/bin/bash

LIBRETRO_LIBS=(	atari800_libretro.so \
				mednafen_ngp_libretro.so \
				mednafen_pce_fast_libretro.so \
				mednafen_supergrafx_libretro.so \
				mednafen_wswan_libretro.so \
				cap32_libretro.so \
				fbneo_libretro.so \
				fceumm_libretro.so \
				flycast_libretro.so \
				fuse_libretro.so \
				gambatte_libretro.so \
				genesis_plus_gx_libretro.so \
				handy_libretro.so \
				mame2003_libretro.so \
				mgba_libretro.so \
				mupen64plus_libretro.so \
				nestopia_libretro.so \
				pcsx_rearmed_libretro.so \
				picodrive_libretro.so \
				prboom_libretro.so \
				prosystem_libretro.so \
				snes9x2005_libretro.so \
				snes9x2010_libretro.so \
				stella2014_libretro.so \
				tyrquake_libretro.so \
				vecx_libretro.so \
				amiberry_launcher_libretro.so
			  )

display_error () {
	echo "  Error detected: $1"
}

# check that all libretro libs exists including fake amiberry
for lib in ${LIBRETRO_LIBS[@]}
do
	if [ ! -f /opt/retropie/libretrocores/$lib ]; then
		display_error "missing libretro $lib : check compilation errors"
	fi
done


# check thzat retroarch service has been created
systemctl daemon-reload
if ! systemctl --all --type service | grep -q "retroarch.service"; then
	display_error "retroarch service has not been created"
fi

# check for amiberry fast_copper setting for all games
if ! grep -q "<hardware>FAST_COPPER=TRUE" /opt/retropie/emulators/amiberry/whdboot/game-data/whdload_db.xml ; then
	display_error "Amiberry FAST_COPPER option has not been set correctly in whdload_db.xml"
fi

# check for boot.ini patch
if [ -f /media/boot/boot.ini.rej ]; then
	display_error "boot.ini patch seems to have fail check /media/boot/boot.ini.rej"
fi

# check for journald.conf
if ! grep -q Storage=volatile /etc/systemd/journald.conf; then
	display_error "failed to change some journald.conf settings"
fi 

# check for fstab modifications
if ! grep -q noatime,size=20M /etc/fstab; then
	display_error "failed to add /var/log to fstab"
fi
if ! grep -q noatime,discard /etc/fstab; then
	display_error "failed to change root fs options in fstab"
fi

# check for uboot env var modification
if ! fw_printenv preloadlogo | grep -q boot-logo.bmp ; then
	display_error "failed to change preloadlogo uboot variable"
fi

# check for rc.local customisation
if ! grep -q vpp_brightness /etc/rc.local; then
	display_error "failed to add customisation to /etc/rc.local"
fi

# check for /etc/profile customisation
if ! grep -q terminfo.txt /etc/profile; then
	display_error "failed to add cusotmisation to /etc/profile"
fi

# check for quiet login
if [ ! -f /root/.hushlogin ]; then
	display_error "missing /root/.hushlogin"
fi
