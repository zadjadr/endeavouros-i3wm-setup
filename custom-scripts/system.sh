#!/bin/bash
#
# Change some system properties and packages according to my needs
#
set -euxo pipefaiL

## Replace dbus with dbus-broker
sudo pacman -Sy dbus-broker --needed --noconfirm

sudo systemctl stop dbus
sudo systemctl disable dbus

sudo systemctl enable dbus-broker
systemctl --user enable dbus-broker

echo "A reboot is needed."
