#!/bin/bash
#
set -uxo pipefail

# Install AUR packages
yay -S --removemake --cleanafter --norebuild --noredownload --noconfirm \
    bibata-cursor-theme
