#!/usr/bin/env bash

apt-get update
apt-get install -y alsa alsa-tools cclive mplayer2


adduser vagrant video
adduser vagrant audio
amixer sset Master 0dB unmute
amixer sset "Master Mono" 0dB unmute
amixer sset PCM 0dB unmute

# Autologin to console
sed -i 's/getty/getty -a vagrant/' /etc/init/tty1.conf
initctl stop tty1
initctl start tty1

cat > /home/vagrant/.bash_profile <<EOF
# Created by bootstrap.sh
if [ ! -e /vagrant/safety.3gpp ]; then
  cclive -O /vagrant/safety.3gpp https://www.youtube.com/watch?v=IacSW-rmxsc
fi
if [ "\`tty\`" == "/dev/tty1" ] && [ ! -f /dev/shm/.noreplay ]; then
  touch /dev/shm/.noreply
  mplayer -fs -vo fbdev /vagrant/safety.3gpp
fi;
EOF
chown vagrant /home/vagrant/.bash_profile
