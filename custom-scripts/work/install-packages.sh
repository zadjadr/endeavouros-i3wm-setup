#!/bin/bash
#
set -euxo pipefail

# Install pacman packages
sudo pacman -Sy --needed --noconfirm \
    pass \
    python-dotenv \
    bitwarden \
    ruby

# Install pip packages
python -m pip install --user --upgrade \
    pipenv \
    sops \
    salt-lint

# Install AUR packages
yay -S --removemake --cleanafter --norebuild --noredownload --noconfirm \
    tfswitch-bin \
    keybase-bin \
    slack-desktop \
    onedrive-abraunegg

# Setup onedrive as systemd service
sudo systemctl stop onedrive@$USER.service
sudo systemctl disable onedrive@$USER.service

systemctl --user enable onedrive
systemctl --user start onedrive
systemctl --user status onedrive.service
