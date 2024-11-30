#!/bin/bash
#
set -uxo pipefail

# Install AUR packages
paru -S --removemake --cleanafter --norebuild --noredownload --noconfirm \
    bibata-cursor-theme
