#!/usr/bin/env bash

sed -i 's/getty/getty -a vagrant/' /etc/init/tty1.conf
initctl stop tty1
initctl start tty1

apt-get update
apt-get install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11 unity-greeter alsa alsa-tools chromium-browser browser-plugin-lightspark

adduser vagrant audio
amixer sset Master 0dB unmute
amixer sset "Master Mono" 0dB unmute
amixer sset PCM 0dB unmute

cat > /etc/lightdm/lightdm.conf <<EOF
[SeatDefaults]
greeter-session=unity-greeter
allow-guest=false
autologin-user=vagrant
EOF

cat > /usr/share/xsessions/safety.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=safety
Comment=Safety
Exec=chromium-browser https://www.youtube.com/watch?v=IacSW-rmxsc
EOF

service lightdm restart
