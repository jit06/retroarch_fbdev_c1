# retroarch_fbdev_c1

NOT YET USABLE

Odroid C1/C0 optimized retroarch build based on RetroPie and hardkernel's Ubuntu minimal image

# Features
- fast boot : x seconds to retroarch interface
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
- Copy your roms and bios in /root/RetroPie or change retroarch settings to what ever you prefer
- enable wpa_supplicant if you need wifi : systemctl enable wpa_supplicant
- Retroarch : online updater => update all needed things (database, core info...) and create your game list
- to display splash image before kernel start (uboot) uncomment the corresponding lines in boot.ini


# Todo
- custom emulator config for speed (n64, dreamcast and playstation, retroarch alsathread, latency to 128)
- themes retroarch
- doom keys
- xrick launch + pad ?
- wold4sdl launch + pad ?
- auto-adjust fs-size (rc.local ?)
- shutdown when retroarch quit
- add the possibility to change constrast and brigthness like overscan 
