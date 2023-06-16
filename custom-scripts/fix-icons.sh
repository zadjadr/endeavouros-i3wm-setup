#!/bin/bash
#
set -euxo pipefail

## fix hardcoded paths to icons
SCRIPT_DIR=/tmp/hardcode-fixer
git clone https://github.com/Foggalong/hardcode-fixer.git "$SCRIPT_DIR"

cd "$SCRIPT_DIR"
chmod +x "$SCRIPT_DIR"/fix.sh
sudo "$SCRIPT_DIR"/fix.sh
rm -rf "$SCRIPT_DIR"

## fix hardcoded paths to tray icons
yay -S --removemake --cleanafter --norebuild --noredownload --noconfirm \
    hardcode-tray

sudo -E hardcode-tray --conversion-tool RSVGConvert --size 24 --theme Papirus-Dark
sudo pacman -R hardcode-tray --noconfirm

sudo tee /usr/share/icons/default/index.theme > /dev/null <<EOT
[Icon Theme]
Inherits=Bibata-Modern-Classic
EOT
