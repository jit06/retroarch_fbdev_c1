![Gamodroid](https://www.bluemind.org/wp-content/uploads/2017/08/logo_gamodroid_c0.png#center)

![Gamodroid](https://github.com/jit06/retroarch_fbdev_c1/blob/master/skin/Splash/splash.png#center)

Gamodroid (retroarch_fbdev_c1) is an Odroid C1/C0 optimized retroarch build distribution. It is based on RetroPie and hardkernel's Ubuntu minimal image and use exclusively fbdev (no Xorg).

It allows to quickly play confortably a lots of retro consoles including some N64 and Dreamcast games in full speed (eg. MarioKart, Mario64, CrazyTaxy, Sonic adventure...).

Gamodroid has been designed for lowres display (cbvs or 480p), suitable for small displays and true NTSC composite display.

Finally, It provides a way to scrap roms (with skyscraper) to generated retroarch playlists with thumbnails and videos previews.

# Main Features
- fast boot : 14 seconds to retroarch interface from cold start
- custom XMB theme and layout with video preview (press start to view it)
- consoleblank disabled
- cbvs mode set to ntsc (60fps) 
- display set to 720x480 by default
- default cpu freq to 1728Mhz
- silent boot
- console cursor enabled by default (throught amiberry disable it...)
- easy overscan / constrast / brightness settings   
- libretro launcher for amiberry, so Amiga games (lha) can be started throught retroarch
- fbneo dat files ar present in /root/.config/retroarch to get good naming with retroarch scraper


# Todo (in no particular order)
- integrate accelerated video player for video preview
- integrate my gpio_joypad as systemd service
- add mupen64plus-next (for now, it crashes after rom load)
- integrate bash launcher for retroarch and ad menu entries for changing contrast, brightness, cpu freq and display (cbvs / hdmi)
- list known n64 and dreamcast games that run correctly
- Amiberry does not exit with retroarch exit combo
- try to make boot even faster
