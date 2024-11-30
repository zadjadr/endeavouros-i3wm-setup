#!/bin/bash
#
set -euxo pipefail

sudo pacman -Sy

# Install nerd fonts & emojis
sudo pacman -S arc-gtk-theme --needed --noconfirm
