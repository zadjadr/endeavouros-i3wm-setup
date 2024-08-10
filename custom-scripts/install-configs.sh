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
	~/.config/brave-flags.conf \
	~/.config/code-flags.conf \
	~/.config/dunst \
	~/.config/electron-flags.conf \
	~/.config/foot \
	~/.config/gtk-3.0 \
	~/.config/gtk-4.0 \
	~/.config/hyde \
	~/.config/hypr \
	~/.config/helix \
	~/.config/i3 \
	~/.config/i3status-rust \
	~/.config/kanshi \
	~/.config/mako \
	~/.config/neofetch \
	~/.config/nitrogen \
	~/.config/onedrive \
	~/.config/paru \
	~/.config/polybar \
	~/.config/ranger \
	~/.config/rofi \
	~/.config/sway \
	~/.config/swaylock \
	~/.config/swww \
	~/.config/way-displays \
	~/.config/waybar \
	~/.config/wlogout \
	~/.config/wofi \
	~/.config/yay \
	~/.config/zed

ln -s \
	"$PWD"/.config/alacritty \
	"$PWD"/.config/albert \
	"$PWD"/.config/autorandr \
	"$PWD"/.config/autostart \
	"$PWD"/.config/brave-flags.conf \
	"$PWD"/.config/dunst \
	"$PWD"/.config/foot \
	"$PWD"/.config/gtk-3.0 \
	"$PWD"/.config/gtk-4.0 \
	"$PWD"/.config/hyde \
	"$PWD"/.config/hypr \
	"$PWD"/.config/helix \
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
	"$PWD"/.config/zed \
	~/.config

electron_version=$(electron --version | sed -E 's/v([0-9]+)\..*/\1/')
rm -rf \
	~/.config/electron${electron_version}-flags.conf \
	~/.config/code-flags.conf

ln -s \
	"$PWD"/.config/electron-flags.conf \
	~/.config/electron${electron_version}-flags.conf

ln -s \
	"$PWD"/.config/electron-flags.conf \
	~/.config/code-flags.conf

ls -s \
	"$PWD"/.vimrc \
	~/.vimrc \

# Deactivate wayland flags for Slack as it supports wayland now
touch ~/.config/slack-flags.conf

BACKUP_HOME="/mnt/BACKUP/home/xcalizorz"

rm -rf \
	~/.cargo \
	~/.config/BraveSoftware \
	~/.config/Code \
	~/.config/OpenLens \
	~/.config/Slack \
	~/.docker \
	~/.git \
	~/.gitconfig \
	~/.gnupg \
	~/.icons \
	~/.krew \
	~/.local \
	~/.megaCmd \
	~/.pyenv \
	~/.rbenv \
	~/.rustup \
	~/.ssh \
	~/.terraform.d \
	~/.terraform.versions \
	~/.vscode \
	~/bin \
	~/Documents \
	~/Downloads \
	~/go
	~/Pictures \

ln -s \
	"$BACKUP_HOME"/.cargo \
	"$BACKUP_HOME"/.docker \
	"$BACKUP_HOME"/.git \
	"$BACKUP_HOME"/.gitconfig \
	"$BACKUP_HOME"/.gnupg \
	"$BACKUP_HOME"/.icons \
	"$BACKUP_HOME"/.krew \
	"$BACKUP_HOME"/.local \
	"$BACKUP_HOME"/.megaCmd \
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
	"$BACKUP_HOME"/go \
	"$BACKUP_HOME"/Pictures \
	"$HOME"

ln -s \
	"$BACKUP_HOME"/.config/BraveSoftware \
	"$BACKUP_HOME"/.config/Code \
	"$BACKUP_HOME"/.config/OpenLens \
	"$BACKUP_HOME"/.config/Slack \
	"$HOME"/.config

## VScode
rm -rf "$HOME/.config/Code/User/settings.json"
ln -s "$PWD/.config/Code - OSS/User/settings.json" "$HOME/.config/Code/User/settings.json"

rm -rf "$HOME/.config/Code - Insiders/User/settings.json"
ln -s "$PWD/.config/Code - OSS/User/settings.json" "$HOME/.config/Code - Insiders/User/settings.json"

## Kitty
rm -rf "$HOME/.config/kitty/kitty.conf"
ln -s "$PWD"/.config/kitty/kitty.conf "$HOME/.config/kitty/kitty.conf"

## i3rust-status custom blocks
mkdir -p ~/.meta/status
touch ~/.meta/status/pomodoro

## atuin
rm -rf "$HOME"/.config/atuin
mkdir -p "$HOME"/.config/atuin
ln -s "$PWD"/.config/atuin/config.toml "$HOME"/.config/atuin/config.toml

## dunstrc
sudo chattr +i "$PWD"/.config/dunst/dunstrc

## Work
rm -rf "$HOME"/.config/ioki
ln -s /mnt/BACKUP/Documents/.config/ioki "$HOME"/.config

## Personal
sudo ln -s -f "$PWD"/custom-scripts/only-for-me/lpass.sh /usr/local/bin/lpass
