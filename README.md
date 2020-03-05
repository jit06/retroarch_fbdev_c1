# retroarch_fbdev_c1

NOT YET USABLE

Odroid C1/C0 optimized retroarch build based on RetroPie and hardkernel's Ubuntu minimal image.
IT uses fbdev (no X) and allow to play confortably a lots of retro consoles including n64 and dreamcast

# Usage
- get official ubunto minimal 18.04 from Hardkernel and start your Odroid C1/C1+/C0 with it.
- clone this repository in /root
- cd /root/retroarch_fbdev_c1
- ./build.sh

It takes several hours to compile and setup everything

# Features
- fast boot : 18 seconds to retroarch interface from cold start
- consoleblank disabled
- cbvs mode to ntsc (480p)
- display set to 720x480 by default (change it in boot.ini)
- default cpu freq to 1728 (higher = crash during compilation of emulators)
- no boot message, no login message
- console cursor enabled by default (throught amiberry disable it...)
- /var/log in tmpfs (limited to 20Mb), journald log to ram
- some services disabled : rsyslog, ModemManager, pppd-dns, wpa_supplicant, loadcpufreq
- handle overscan : simply create /media/boot/overscan and put your value as "x y width height"

# important things to note
- there is no user except root, password is the default one : odroid
- uhs is enabled by default. Change it if your SDcard is not compatible (boot.ini)
- Copy your roms and bios in /root/RetroPie or change retroarch settings to whatever location you prefer
- enable wpa_supplicant if you need wifi : systemctl enable wpa_supplicant
- Retroarch : use online updater to update all needed things (database, core info...) and create your game lists

# Todo
- themes retroarch
- create a image to burn on with auto-adjust fs size (rc.local ?)
- shutdown when retroarch quit
- add the possibility to change constrast and brigthness like overscan 

# known bugs
- doom keys are not very usable with a joypad
- xrick does not start
- wold4sdl does not start
