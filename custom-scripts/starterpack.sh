#!/bin/bash
#
set -uxo pipefail

sudo pacman -Sy

sudo pacman -R \
	endeavouros-xfce4-terminal-colors \
	xfce4-terminal \
	xterm \
	xed \
	nano-syntax-highlighting \
	nano \
	--noconfirm

set -euxo pipefail

sudo pacman -S \
	alacritty \
	code \
	python \
	go \
	--needed --noconfirm

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install nerd fonts
git clone --filter=blob:none --sparse https://github.com/ryanoasis/nerd-fonts.git /tmp/nerd-fonts

cd /tmp/nerd-fonts
git sparse-checkout add patched-fonts/Hack
git sparse-checkout add patched-fonts/FiraCode

chmod +x ./install

./install Hack FiraCode

