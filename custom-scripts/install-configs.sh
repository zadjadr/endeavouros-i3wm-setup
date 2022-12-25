#!/bin/bash
#
# Call this script from the root directory of the repository
# ./custom-scripts/install-configs.sh
set -euxo pipefail

# Replace configs
## i3 config
rm -rf \
	~/.config/i3 \
	~/.config/alacritty \
	~/.config/albert \
	~/.config/autostart \
	~/.config/autorandr \
	~/.config/dunst \
	~/.config/gtk-3.0 \
	~/.config/gtk-4.0 \
	~/.config/nitrogen \
	~/.config/ranger \
	~/.config/rofi \
	~/.config/wezterm \
	~/.config/yay \

ln -s \
	"$PWD"/.config/i3 \
	"$PWD"/.config/alacritty \
	"$PWD"/.config/albert \
	"$PWD"/.config/autostart \
	"$PWD"/.config/autorandr \
    "$PWD"/.config/dunst \
	"$PWD"/.config/gtk-3.0 \
	"$PWD"/.config/gtk-4.0 \
	"$PWD"/.config/nitrogen \
	"$PWD"/.config/ranger \
	"$PWD"/.config/rofi \
	"$PWD"/.config/wezterm \
	"$PWD"/.config/yay \
	~/.config

## Xresources
rm -rf ~/.Xresources
ln -s "$PWD"/.Xresources ~/

## VScode
rm -rf ~/.config/Code\ -\ OSS/User/settings.json
ln -s "$PWD"/.config/Code\ -\ OSS/User/settings.json ~/.config/Code\ -\ OSS/User

## (neo)vim
curl -sLf https://spacevim.org/install.sh | bash
