#!/bin/bash
#
set -euxo pipefail

# Install nerd fonts
sudo pacman -S ttf-firacode-nerd --needed --noconfirm

# Install icons
## papirus
sudo pacman -S papirus-icon-theme --needed --noconfirm

## fix hardcoded paths to icons
git clone https://github.com/Foggalong/hardcode-fixer.git /tmp/hardcode-fixer

SCRIPT_DIR=/tmp/hardcode-fixer
cd "$SCRIPT_DIR"
chmod +x "$SCRIPT_DIR"/fix.sh
sudo "$SCRIPT_DIR"/fix.sh

## fix hardcoded paths to tray icons
yay -S --removemake --cleanafter --norebuild --noredownload \
    hardcode-tray

sudo -E hardcode-tray --conversion-tool RSVGConvert --size 24 --theme Papirus
sudo pacman -R hardcode-tray --noconfirm