#!/bin/bash
#
set -euxo pipefail

sudo pacman -Sy

# Install nerd fonts & emojis
sudo pacman -S ttf-firacode-nerd noto-fonts-emoji --needed --noconfirm

# Install icons
## papirus
sudo pacman -S papirus-icon-theme --needed --noconfirm

gsettings set org.gnome.desktop.interface icon-theme 'ePapirus-Dark'
gsettings set org.gnome.desktop.interface gtk-theme "Arc-Dark"
