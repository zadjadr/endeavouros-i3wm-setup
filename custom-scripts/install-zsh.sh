#!/bin/bash
set -euxo pipefail

sudo pacman -Sy --needed --noconfirm zsh zsh-completions

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

yay -S --removemake --cleanafter --norebuild --noredownload --noconfirm \
    starship \
    zsh-fast-syntax-highlighting \
    zsh-autosuggestions

chsh -s $(which zsh)
sudo chsh -s $(which zsh)
rm -f ~/.zshrc ~/.zshenv ~/.zcompdump*

ln -s \
    "$PWD"/.zshrc \
    ~/
