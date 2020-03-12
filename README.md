# retroarch_fbdev_c1

NOT YET USABLE

Odroid C1/C0 optimized retroarch build scripts based on RetroPie and hardkernel's Ubuntu minimal image.
It uses fbdev (no X) and allows to play confortably a lots of retro consoles including n64 and dreamcast.

It has been designed for lowres display (cbvs / 720x480)

# Usage
- get official ubuntu minimal 18.04 from Hardkernel and start your Odroid C1/C1+/C0 with it.
- clone this repository in /root
- cd /root/retroarch_fbdev_c1
- ./build.sh
- reboot
- in retroarch: use online updater to update all but cores before doing anything else
- Copy your roms and bios in /root/RetroPie or change retroarch settings or mount any usbkey or sdcard to /root/Retropie (ssh is enabled)

Note that it takes several hours to compile and setup everything

# Main Features
- fast boot : 14 seconds to retroarch interface from cold start
- consoleblank disabled
- cbvs mode set to ntsc (60fps) 
- display set to 720x480 by default (you can change it in build script, but logo and splash image won't have the right size)
- default cpu freq to 1728 (higher = crash during compilation of emulators)
- no boot message, no login message
- console cursor enabled by default (throught amiberry disable it...)
- /var/log in tmpfs (limited to 20Mb), journald log to ram
- some services disabled : rsyslog, ModemManager, pppd-dns, wpa_supplicant, loadcpufreq
- handle overscan : simply create /media/boot/overscan and put your value as "x y width height"
- handle display constrast : simply create /media/boot/contrast and write a positive or negative interger
- handle display brightness : simply create /media/boot/brightness and write a positive or negative interger
- libretro launcher for amiberry so Amiga games (lha) can be started throught retroarch

# important things to note
- there is no else user than root, password is the default one : odroid
- uhs is enabled by default. Change it if your SDcard is not compatible (boot.ini)
- enable wpa_supplicant if you need wifi : systemctl enable wpa_supplicant
- Amiga emulator (amiberry) is configured to use .lha games (whdload)
- tty1 is disabled, use another one or use ssh

# Todo
- themes retroarch
- create rebuild imnage with auto-adjust fs size (rc.local ?)
- shutdown when retroarch quit
