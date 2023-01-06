#!/bin/bash
#
set -euxo pipefail

# Install nerd fonts
sudo pacman -S ttf-firacode-nerd --needed --noconfirm

# Install icons
## papirus
sudo pacman -S papirus-icon-theme --needed --noconfirm
