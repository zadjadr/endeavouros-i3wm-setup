#!/bin/bash
#
set -euxo pipefail

# Install pacman packages
sudo pacman -Sy --needed --noconfirm \
    bitwarden \
    direnv \
    pass \
    pyenv \
    ruby \
    vagrant \
    virtualbox \
    virtualbox-guest-iso

# Install pip packages
python -m pip install --upgrade pip
python -m pip install --user --upgrade \
    pipenv \
    ruff \
    salt-lint \
    sops

# Install AUR packages
yay -S --removemake --cleanafter --norebuild --noredownload --noconfirm \
    keybase-bin \
    onedrive-abraunegg \
    slack-desktop \
    tfswitch-bin

# Setup onedrive as systemd service
sudo systemctl stop onedrive@$USER.service
sudo systemctl disable onedrive@$USER.service

systemctl --user enable onedrive
systemctl --user start onedrive
systemctl --user status onedrive.service | cat
