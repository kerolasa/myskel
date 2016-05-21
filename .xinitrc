setxkbmap gb
setterm -blank 0 -powersave off -powerdown 0
xset s off
xrdb -merge "$HOME/.Xdefaults"
exec /usr/bin/awesome
