#!/bin/bash

for output in $(xrandr --prop | grep -E -o -i "^[A-Z\-]+-[0-9]+"); do xrandr --output "$output" --set "scaling mode" "Full aspect"; done

xrandr --newmode "3840x2160_60.00"  712.75  3840 4160 4576 5312  2160 2163 2168 2237 -hsync +vsync
xrandr --newmode "3840x2160_75.00"  904.00  3840 4168 4592 5344  2160 2163 2168 2257 -hsync +vsync

xrandr --addmode DVI-D-0 "3840x2160_60.00" 
xrandr --addmode HDMI-A-0 "3840x2160_60.00" 

xrandr --addmode DVI-D-0 "3840x2160_75.00" 
xrandr --addmode HDMI-A-0 "3840x2160_75.00" 

xrandr --output DVI-D-0 --mode "3840x2160_60.00" --pos 0x0
xrandr --output HDMI-A-0 --mode "3840x2160_60.00" --pos 3840x0

xrdb ~/.Xresources

feh --bg-fill ~/Wallpapers/Enterprise.jpg

compton &

exec i3
