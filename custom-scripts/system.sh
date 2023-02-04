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

echo "A reboot is needed."
