#!/bin/sh
rm -rf ~/.vnc; mkdir ~/.vnc
echo "123456\n123456\n" | vncpasswd

cat << EOF > ~/.vnc/xstartup
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
EOF

chmod +x ~/.vnc/xstartup
vncserver
