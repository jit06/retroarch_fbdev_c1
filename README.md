# retroarch_fbdev_c1

NOT YET USABLE

Odroid C1/C0 optimized retroarch build based on RetroPie and hardkernel's Ubuntu minimal image

# Features
- fast boot : x seconds to retroarch interface
- consoleblank disabled
- cbvs mode to ntsc (480p)
- display set to 640x480 by default (change it in boot.ini)
- default cpu freq to 1728 (higher = crash during compilation of emulators)
- no boot message
- console cursor enabled by default (throught some fbdev apps disable it)
- /var/log in tmpfs (limited to 20Mb), journald log to ram
- some services disabled : rsyslog, ModemManager, pppd-dns, wpa_supplicant, loadcpufreq


# important things to note
- there is no user except root, password is the default one : odroid
- uhs is enabled by default. Change it if your SDcard is not compatible (boot.ini)
- Copy your roms and bios in /root/RetroPie or change retroarch settings to what ever you prefer
- enable wpa_supplicant if you need wifi : systemctl enable wpa_supplicant
- Retroarch : online updater => update all needed things (database, core info...) and create your game list


# Todo
- Amiga roms => tests AGA
- custom emulator config for speed (n64, dreamcast and playstation, retroarch alsathread, latency to 128)
- themes retroarch
- doom keys
- xrick launch + pad ?
- wold4sdl launch + pad ?
- handle overscan
- list needed package in install script
- auto-adjust fs-size (rc.local ?)
- remove console=tty0 from condev (boot.ini) => no message output
- remove ubuntu message at login
- add splash screen
- launch retroarch at boot