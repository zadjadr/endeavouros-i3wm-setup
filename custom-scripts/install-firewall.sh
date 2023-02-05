#!/bin/bash
#
set -uxo pipefail

# Install AUR packages
yay -S --removemake --cleanafter --norebuild --noredownload --noconfirm\
    opensnitch \
    opensnitch-ebpf-module-stable

sudo systemctl enable --now opensnitchd
sudo systemctl start opensnitchd
