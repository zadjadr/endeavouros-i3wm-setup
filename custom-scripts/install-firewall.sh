#!/bin/bash
#
set -uxo pipefail

# Install AUR packages
paru -S --removemake --cleanafter --norebuild --noredownload --noconfirm\
    opensnitch \
    opensnitch-ebpf-module

sudo systemctl enable --now opensnitchd
sudo systemctl daemon-reload
sudo systemctl start opensnitchd
