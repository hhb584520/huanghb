#!/bin/sh
rm -rf ~/.vnc; mkdir ~/.vnc
echo "123456\n123456\n" | vncpasswd

cat << EOF > ~/.vnc/xstartup
#!/bin/bash
export LC_ALL="en_US.UTF-8"
DESK_TYPE=gnome
export XKL_XMODMAP_DISABLE=1
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup [ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &
vncconfig -nowin &
gnome-session &
gnome-panel &
gnome-settings-daemon &
metacity &
nautilus -n &
gnome-terminal &
EOF

chmod 755 ~/.vnc/xstartup
vnc4server -geometry 1920x1080 -depth 16 &
#vnc4server -geometry 2560x1440 -depth 16 &
echo "vnc password is 123456"

# vncconfig -nowin &
# pkill vncconfig
