#!/bin/bash
#
# Call this script from the root directory of the repository
# ./custom-scripts/install-configs.sh
set -euxo pipefail

# Replace configs
## i3 config
rm -rf \
	~/.config/i3 \
	~/.config/i3status-rust \
	~/.config/dunst \
	~/.config/sway \
	~/.config/swaylock \
	~/.config/waybar \
	~/.config/mako \
	~/.config/kanshi \
	~/.config/alacritty \
	~/.config/albert \
	~/.config/autostart \
	~/.config/autorandr \
	~/.config/gtk-3.0 \
	~/.config/gtk-4.0 \
	~/.config/nitrogen \
	~/.config/onedrive \
	~/.config/ranger \
	~/.config/rofi \
	~/.config/wofi \
	~/.config/yay

ln -s \
	"$PWD"/.config/i3 \
	"$PWD"/.config/i3status-rust \
	"$PWD"/.config/dunst \
	"$PWD"/.config/sway \
	"$PWD"/.config/swaylock \
	"$PWD"/.config/waybar \
	"$PWD"/.config/mako \
	"$PWD"/.config/kanshi \
	"$PWD"/.config/alacritty \
	"$PWD"/.config/albert \
	"$PWD"/.config/autostart \
	"$PWD"/.config/autorandr \
	"$PWD"/.config/gtk-3.0 \
	"$PWD"/.config/gtk-4.0 \
	"$PWD"/.config/nitrogen \
	"$PWD"/.config/onedrive \
	"$PWD"/.config/ranger \
	"$PWD"/.config/rofi \
	"$PWD"/.config/wofi \
	"$PWD"/.config/yay \
	~/.config

## VScode
rm -rf "$HOME/.config/Code/User/settings.json"
ln -s "$PWD/.config/Code - OSS/User/settings.json" "$HOME/.config/Code/User/settings.json"

## i3rust-status custom blocks
mkdir -p ~/.meta/status
touch ~/.meta/status/pomodoro

## atuin
rm -rf "$HOME"/.config/atuin
mkdir -p "$HOME"/.config/atuin
ln -s "$PWD"/.config/atuin/config.toml "$HOME"/.config/atuin/config.toml
