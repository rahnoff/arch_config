xrandr --output Virtual-1 --mode 1360x768
xrdb -merge ~/.config/X11/.Xresources
urxvtd -o -q -f
picom &
exec i3
