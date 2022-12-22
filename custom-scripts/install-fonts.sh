#!/bin/bash
#
set -euxo pipefail

# Install nerd fonts
sudo pacman -S ttf-firacode-nerd

# Install icons
## papirus
sudo pacman -S papirus-icon-theme

## fix hardcoded paths to icons
git clone https://github.com/Foggalong/hardcode-fixer.git /tmp/hardcode-fixer
cd /tmp/hardcode-fixer
chmod +x fix.sh
sudo ./fix.sh

## fix hardcoded paths to tray icons
yay -S hardcode-tray
sudo -E hardcode-tray --conversion-tool RSVGConvert --size 24 --theme Papirus
sudo pacman -R hardcode-tray