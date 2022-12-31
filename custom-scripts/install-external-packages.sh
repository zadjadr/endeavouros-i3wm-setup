#!/bin/bash
#
set -euxo pipefail

DIR=/tmp/
# Install external packages
## Install megasync
curl -fsSL -o "$DIR"/megasync-x86_64.pkg.tar.zst https://mega.nz/linux/repo/Arch_Extra/x86_64/megasync-x86_64.pkg.tar.zst
sudo pacman -U "$DIR"/megasync-x86_64.pkg.tar.zst
sudo pacman -Sy