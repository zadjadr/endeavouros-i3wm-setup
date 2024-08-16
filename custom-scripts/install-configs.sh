#!/bin/bash
#
# Call this script from the root directory of the repository
# ./custom-scripts/install-configs.sh
set -euxo pipefail

# Replace configs
rm -rf \
	~/.vimrc \
	~/.config/autostart \
	~/.config/brave-flags.conf \
	~/.config/code-flags.conf \
	~/.config/dunst \
	~/.config/electron-flags.conf \
	~/.config/gtk-3.0 \
	~/.config/gtk-4.0 \
	~/.config/hypr \
	~/.config/helix \
	~/.config/kanshi \
	~/.config/onedrive \
	~/.config/paru \
	~/.config/rofi \
	~/.config/swaync \
	~/.config/starship.toml \
	~/.config/waybar \
	~/.config/wlogout \
	~/.config/yay \
	~/.config/zed

ln -s \
	"$PWD"/.config/autostart \
	"$PWD"/.config/brave-flags.conf \
	"$PWD"/.config/dunst \
	"$PWD"/.config/gtk-3.0 \
	"$PWD"/.config/gtk-4.0 \
	"$PWD"/.config/hypr \
	"$PWD"/.config/helix \
	"$PWD"/.config/kanshi \
	"$PWD"/.config/onedrive \
	"$PWD"/.config/kanshi \
	"$PWD"/.config/paru \
	"$PWD"/.config/rofi \
	"$PWD"/.config/starship.toml \
	"$PWD"/.config/swaync \
	"$PWD"/.config/waybar \
	"$PWD"/.config/wlogout \
	"$PWD"/.config/yay \
	"$PWD"/.config/zed \
	~/.config

rm -rf \
	~/.config/electron30-flags.conf \
	~/.config/electron31-flags.conf \
	~/.config/code-flags.conf

ln -s \
	"$PWD"/.config/electron-flags.conf \
	~/.config/electron30-flags.conf

ln -s \
	"$PWD"/.config/electron-flags.conf \
	~/.config/electron31-flags.conf

ln -s \
	"$PWD"/.config/electron-flags.conf \
	~/.config/code-flags.conf

ls -s \
	"$PWD"/.vimrc \
	~/ \

# Deactivate wayland flags for Slack as it supports wayland now
touch ~/.config/slack-flags.conf

BACKUP_HOME="/mnt/BACKUP/home/xcalizorz"

rm -rf \
	~/.cargo \
	~/.config/BraveSoftware \
	~/.config/OpenLens \
	~/.config/Slack \
	~/.kube \
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
	~/Pictures

sudo rm -rf ~/go ~/.local

ln -s \
	"$BACKUP_HOME"/.cargo \
	"$BACKUP_HOME"/.kube \
	"$BACKUP_HOME"/.git \
	"$BACKUP_HOME"/.gitconfig \
	"$BACKUP_HOME"/.gnupg \
	"$BACKUP_HOME"/.icons \
	"$BACKUP_HOME"/.krew \
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
	"$BACKUP_HOME"/.config/OpenLens \
	"$BACKUP_HOME"/.config/Slack \
	"$HOME"/.config

## VScode
rm -rf "$HOME/.config/Code - Insiders/User/settings.json"
ln -s "$PWD/.config/Code - OSS/User/settings.json" "$HOME/.config/Code - Insiders/User/settings.json"

## Kitty
rm -rf "$HOME/.config/kitty/kitty.conf"
ln -s "$PWD"/.config/kitty/kitty.conf "$HOME/.config/kitty/kitty.conf"

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

ln -s \
	"$PWD"/.local/share/applications/element.desktop \
	"$PWD"/.local/share/applications/slack.desktop \
	"$HOME"/.local/share/applications/
