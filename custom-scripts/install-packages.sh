#!/bin/bash
#
set -uxo pipefail

# pacman -R breaks if the package is not installed
sudo pacman -D --asdeps $(cat custom-scripts/rmpkglist.txt)
sudo pacman -Rns $(pacman -Qqtd)

set -euxo pipefail

sudo pacman -Sy --needed --noconfirm - < custom-scripts/pkglist.txt

# Install AUR packages
paru -S --removemake --cleanafter --norebuild --noredownload --noconfirm\
    visual-studio-code-insiders-bin \
    xournalpp
