#!/bin/bash
#
set -euxo pipefail

# Install pacman packages
sudo pacman -Sy --needed --noconfirm \
    atuin \
    bitwarden \
    direnv \
    pass \
    pyenv \
    ruby \
    sops \
    vagrant \
    virtualbox \
    virtualbox-guest-iso

# Install pip packages
for pak in pipenv ruff salt-lint black; do
    pipx install $pak;
done

# Install AUR packages
yay -S --removemake --cleanafter --norebuild --noredownload --noconfirm \
    keybase-bin \
    onedrive-abraunegg \
    slack-desktop \
    tfswitch-bin

# Setup onedrive as systemd service
sudo systemctl stop onedrive@$USER.service
sudo systemctl disable onedrive@$USER.service
sudo systemctl daemon-reload

systemctl --user enable onedrive
systemctl --user start onedrive
systemctl --user status onedrive.service | cat
