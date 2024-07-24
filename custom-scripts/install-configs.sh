#!/bin/bash
#
# Call this script from the root directory of the repository
# ./custom-scripts/install-configs.sh
set -euxo pipefail

ln -s -f \
	"$PWD"/.config/alacritty \
	"$PWD"/.config/albert \
	"$PWD"/.config/autorandr \
	"$PWD"/.config/autostart \
	"$PWD"/.config/brave-flags.conf \
	"$PWD"/.config/dunst \
	"$PWD"/.config/foot \
	"$PWD"/.config/gtk-3.0 \
	"$PWD"/.config/gtk-4.0 \
	"$PWD"/.config/hypr \
	"$PWD"/.config/i3 \
	"$PWD"/.config/i3status-rust \
	"$PWD"/.config/kanshi \
	"$PWD"/.config/mako \
	"$PWD"/.config/neofetch \
	"$PWD"/.config/nitrogen \
	"$PWD"/.config/onedrive \
	"$PWD"/.config/paru \
	"$PWD"/.config/polybar \
	"$PWD"/.config/ranger \
	"$PWD"/.config/rofi \
	"$PWD"/.config/sway \
	"$PWD"/.config/swaylock \
	"$PWD"/.config/swww \
	"$PWD"/.config/way-displays \
	"$PWD"/.config/waybar \
	"$PWD"/.config/wlogout \
	"$PWD"/.config/wofi \
	"$PWD"/.config/yay \
	~/.config

electron_version=$(electron --version | sed -E 's/v([0-9]+)\..*/\1/')

ln -s -f \
	"$PWD"/.config/electron-flags.conf \
	~/.config/electron${electron_version}-flags.conf

ln -s -f \
	"$PWD"/.config/electron-flags.conf \
	~/.config/code-flags.conf

ls -s -f \
	"$PWD"/.vimrc \
	~/.vimrc \

# Deactivate wayland flags for Slack as it supports wayland now
touch ~/.config/slack-flags.conf

BACKUP_HOME="/mnt/BACKUP/home/xcalizorz"

ln -s -f \
	"$BACKUP_HOME"/.cache \
	"$BACKUP_HOME"/.cargo \
	"$BACKUP_HOME"/.docker \
	"$BACKUP_HOME"/.git \
	"$BACKUP_HOME"/.gitconfig \
	"$BACKUP_HOME"/.gnupg \
	"$BACKUP_HOME"/.icons \
	"$BACKUP_HOME"/.krew \
	"$BACKUP_HOME"/.local \
	"$BACKUP_HOME"/.pyenv \
	"$BACKUP_HOME"/.rbenv \
	"$BACKUP_HOME"/.rustup \
	"$BACKUP_HOME"/.ssh \
	"$BACKUP_HOME"/.terraform.d \
	"$BACKUP_HOME"/.terraform.versions \
	"$BACKUP_HOME"/.vscode \
	"$BACKUP_HOME"/bin \
	"$BACKUP_HOME"/Documents \
	"$BACKUP_HOME"/Downloads \
	"$BACKUP_HOME"/Pictures \
	"$BACKUP_HOME"/go \
	$HOME

ln -s -f \
	"$BACKUP_HOME"/.config/Slack \
	"$BACKUP_HOME"/.config/BraveSoftware \
	"$BACKUP_HOME"/.config/OpenLens \
	"$BACKUP_HOME"/.config/Code \
	$HOME/.config

## VScode
ln -s -f "$PWD/.config/Code - OSS/User/settings.json" "$HOME/.config/Code/User/settings.json"

ln -s -f "$PWD/.config/Code - OSS/User/settings.json" "$HOME/.config/Code - Insiders/User/settings.json"

## Kitty
ln -s -f "$PWD"/.config/kitty/kitty.conf "$HOME/.config/kitty/kitty.conf"

## atuin
rm -rf "$HOME"/.config/atuin
mkdir -p "$HOME"/.config/atuin
ln -s -f "$PWD"/.config/atuin/config.toml "$HOME"/.config/atuin/config.toml

## dunstrc
sudo chattr +i "$PWD"/.config/dunst/dunstrc

## Work
ln -s -f /mnt/BACKUP/Documents/.config/ioki "$HOME"/.config

## Personal
sudo ln -s -f "$PWD"/custom-scripts/only-for-me/lpass.sh /usr/local/bin/lpass
