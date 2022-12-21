#!/bin/bash
#
set -euxo pipefail

# Install nerd fonts
git clone --filter=blob:none --sparse https://github.com/ryanoasis/nerd-fonts.git /tmp/nerd-fonts

cd /tmp/nerd-fonts
git sparse-checkout add patched-fonts/Hack
git sparse-checkout add patched-fonts/FiraCode

chmod +x ./install

./install Hack FiraCode

