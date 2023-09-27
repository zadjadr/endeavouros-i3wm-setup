#!/bin/bash
#
# Call this script from the root directory of the repository
# ./custom-scripts/install-configs.sh
set -euxo pipefail

# Replace configs
rm -rf \
	~/.config/alacritty \
	~/.config/albert \
	~/.config/autorandr \
	~/.config/autostart \
	~/.config/code-flags.conf \
	~/.config/brave-flags.conf \
	~/.config/electron-flags.conf \
	~/.config/electron25-flags.conf \
	~/.config/dunst \
	~/.config/gtk-3.0 \
	~/.config/gtk-4.0 \
	~/.config/hypr \
	~/.config/i3 \
	~/.config/i3status-rust \
	~/.config/kanshi \
	~/.config/kitty \
	~/.config/foot \
	~/.config/mako \
	~/.config/nitrogen \
	~/.config/onedrive \
	~/.config/polybar \
	~/.config/ranger \
	~/.config/rofi \
	~/.config/sway \
	~/.config/swaylock \
	~/.config/swww \
	~/.config/waybar \
	~/.config/way-displays \
	~/.config/wlogout \
	~/.config/wofi \
	~/.config/yay

ln -s \
	"$PWD"/.config/alacritty \
	"$PWD"/.config/albert \
	"$PWD"/.config/autorandr \
	"$PWD"/.config/autostart \
	"$PWD"/.config/code-flags.conf \
	"$PWD"/.config/brave-flags.conf \
	"$PWD"/.config/electron-flags.conf \
	"$PWD"/.config/electron25-flags.conf \
	"$PWD"/.config/dunst \
	"$PWD"/.config/gtk-3.0 \
	"$PWD"/.config/gtk-4.0 \
	"$PWD"/.config/hypr \
	"$PWD"/.config/i3 \
	"$PWD"/.config/i3status-rust \
	"$PWD"/.config/kanshi \
	"$PWD"/.config/kitty \
	"$PWD"/.config/foot \
	"$PWD"/.config/mako \
	"$PWD"/.config/nitrogen \
	"$PWD"/.config/onedrive \
	"$PWD"/.config/polybar \
	"$PWD"/.config/ranger \
	"$PWD"/.config/rofi \
	"$PWD"/.config/sway \
	"$PWD"/.config/swaylock \
	"$PWD"/.config/swww \
	"$PWD"/.config/waybar \
	"$PWD"/.config/way-displays \
	"$PWD"/.config/wlogout \
	"$PWD"/.config/wofi \
	"$PWD"/.config/yay \
	~/.config

BACKUP_HOME="/mnt/BACKUP/home/xcalizorz"

rm -rf \
	~/.cargo \
	~/.docker \
	~/.git \
	~/.gitconfig \
	~/.gnupg \
	~/.icons \
	~/.config/Slack \
	~/.config/BraveSoftware \
	~/.config/OpenLens \
	~/.config/Code \
	~/.krew \
	~/.pyenv \
	~/.rbenv \
	~/.rustup \
	~/.ssh \
	~/.terraform.d \
	~/.terraform.versions \
	~/bin \
	~/Documents \
	~/Downloads \
	~/Pictures \
	~/go

ln -s \
	"$BACKUP_HOME"/.cargo \
	"$BACKUP_HOME"/.docker \
	"$BACKUP_HOME"/.git \
	"$BACKUP_HOME"/.gitconfig \
	"$BACKUP_HOME"/.gnupg \
	"$BACKUP_HOME"/.icons \
	"$BACKUP_HOME"/.krew \
	"$BACKUP_HOME"/.pyenv \
	"$BACKUP_HOME"/.rbenv \
	"$BACKUP_HOME"/.rustup \
	"$BACKUP_HOME"/.ssh \
	"$BACKUP_HOME"/.terraform.d \
	"$BACKUP_HOME"/.terraform.versions \
	"$BACKUP_HOME"/bin \
	"$BACKUP_HOME"/Documents \
	"$BACKUP_HOME"/Downloads \
	"$BACKUP_HOME"/Pictures \
	"$BACKUP_HOME"/go \
	$HOME

ln -s \
	"$BACKUP_HOME"/.config/Slack \
	"$BACKUP_HOME"/.config/BraveSoftware \
	"$BACKUP_HOME"/.config/OpenLens \
	"$BACKUP_HOME"/.config/Code \
	$HOME/.config

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
