#!/bin/bash
# TODO implement this as a pacman hook to install after every update to sway
#
sudo tee /usr/share/wayland-session/sway.desktop > /dev/null <<EOT
[Desktop Entry]
Name=Sway
Comment=An i3-compatible Wayland compositor
Exec=sway --unsupported-gpu
Type=Application
EOT

# deactivate sddm
sudo systemctl stop sddm
sudo systemctl disable sddm

sudo pacman -Rs sddm eos-sddm-theme
