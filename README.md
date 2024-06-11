# Bigpicture-Detector

Python daemon to automate switching from PC to TV when launching Steam in big picture mode.  
Supports X11 and gnome-wayland

It will autodetect your primary display as desktop mode screen, and your secondary display as gamemode screen.  
Also it will switch audio devices on the one you provided with launch arguments.

This script will reset your system to desktop mode at exit.

## Primary use case

This script is meant to be ran when using single monitor and TV plugged in.  
Using a dual screen plus a TV might lead to random result.  
I made this script for my own use, and i'll not address issue about other configuration than this one.

## Dependencies

- `wmctrl` for window detection
- `pactl` for audio device manipulation
- `xrandr` for screen detection and manipulation under X11
- `gnome-randr` (bundled) in path for gnome-wayland support

## Usage

- `--gamemode-audio, -ga`
- `--desktopmode-audio, -da`

Both args should be filled with device description. You can get it from `pactl list sinks | grep device.description`

Output should look like this:

```bash
flora@fedora:~/Projects$ pactl list sinks | grep device.description
        device.description = "CORSAIR VOID ELITE Wireless Gaming Dongle"
```

If you plan to switch to HDMI audio, be sure to turn your HDMI monitor before running this command, else it wont be listed here.

Final command should look like: `bigpicture-detector -ga "Navi 31 HDMI/DP Audio" -da "CORSAIR VOID ELITE Wireless Gaming Dongle"`

## To do

Will probably do one day but low priority

- Add feature to disable audio switching
- Add KDE Plasma support
