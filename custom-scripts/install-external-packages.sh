#!/bin/bash
#
set -euxo pipefail
DIR=/tmp/
# Install external packages
## Install megasync
curl -fsSL -o "$DIR"/megacmd-x86_64.pkg.tar.zst https://mega.nz/linux/repo/Arch_Extra/x86_64/megacmd-x86_64.pkg.tar.zst
sudo pacman -U "$DIR"/megacmd-x86_64.pkg.tar.zst --needed --noconfirm
sudo pacman -Sy

wget  && sudo pacman -U \"$PWD/megacmd-x86_64.pkg.tar.zst\"
