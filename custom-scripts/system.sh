#!/bin/bash
#
# Change some system properties and packages according to my needs
#
set -euxo pipefail

## Replace dbus with dbus-broker
sudo pacman -Sy dbus-broker --needed --noconfirm

sudo systemctl enable dbus-broker
systemctl --user enable dbus-broker

sudo systemctl restart NetworkManager
sudo systemctl restart systemd-networkd

sudo systemctl daemon-reload
echo "A reboot is needed."

## Allow special keys to be sent as user in 'video' group
sudo tee /etc/udev/rules.d/backlight.rules > /dev/null <<EOT
ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video $sys$devpath/brightness", RUN+="/bin/chmod g+w $sys$devpath/brightness"
EOT
