#!/bin/bash
#
## Script to generate everything we need for i3
## Starting with manjaro i3

# cat << EOF > /etc/pacman.conf

# [endeavouros]
# SigLevel = PackageRequired
# Include = /etc/pacman.d/endeavouros-mirrorlist
# EOF

# sudo wget -O /etc/pacman.d/endeavouros-mirrorlist https://gitlab.com/endeavouros-filemirror/PKGBUILDS/-/raw/master/endeavouros-mirrorlist/endeavouros-mirror

# sudo pacman-key --keyserver keyserver.ubuntu.com -r 003DB8B0CB23504F
# sudo pacman-key --lsign 003DB8B0CB23504F

## Most of the packages here are not needed when starting with manjaro i3
# wget https://raw.githubusercontent.com/endeavouros-team/EndeavourOS-packages-lists/master/i3
# sudo pacman -S --needed - < i3

sudo pacman -Syy
sudo pacman -R palemoon-bin \
    manjaro-i3-settings \
    urxvt-perls \
    xterm \
    conky-i3 \
    pamac-gtk pamac-cli

sudo pacman -Qtdq | pacman -Rns -

sudo pacman -S firefox alacritty i3blocks rofi manjaro-settings-manager

cp .Xresources ~/.Xresources
cp -R .config/* ~/.config/
chmod -R +x ~/.config/i3/scripts
dbus-launch dconf load / < xed.dconf

## Install vim configs
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

