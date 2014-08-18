#!/usr/bin/env bash

apt-get update
apt-get install -y alsa alsa-tools cclive mplayer2


adduser vagrant video
adduser vagrant audio
amixer sset Master 0dB unmute
amixer sset "Master Mono" 0dB unmute
amixer sset PCM 0dB unmute

cat > /home/vagrant/.bash_profile <<EOF
# Created by bootstrap.sh
if [ ! -e safety.3gpp ]; then
  cclive -O safety.3gpp https://www.youtube.com/watch?v=IacSW-rmxsc
fi
if [ ! -e login.3gpp ]; then
  cclive -O login.3gpp https://www.youtube.com/watch?v=7nQ2oiVqKHw
fi
if [ "\`tty\`" == "/dev/tty1" ] && [ ! -f .noreplay ]; then
  touch .noreplay
  mplayer -really-quiet -fs -vo fbdev safety.3gpp 2>/dev/null
else
  mplayer -really-quiet -vo none login.3gpp 2>/dev/null
fi
EOF
chown vagrant /home/vagrant/.bash_profile

# Autologin to console
sed -i 's/getty/getty -a vagrant/' /etc/init/tty1.conf
initctl stop tty1
initctl start tty1

