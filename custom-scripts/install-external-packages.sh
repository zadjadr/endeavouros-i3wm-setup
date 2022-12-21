#!/bin/bash
#
set -euxo pipefail

# Install external packages
## Install megasync
curl -fsSL -o /tmp/megasync-x86_64.pkg.tar.zst https://mega.nz/linux/repo/Arch_Extra/x86_64/megasync-x86_64.pkg.tar.zst
sudo pacman -U /tmp/megasync-x86_64.pkg.tar.zst