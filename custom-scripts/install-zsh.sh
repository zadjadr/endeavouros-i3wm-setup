#!/bin/bash
set -euxo pipefail

sudo pacman -Sy --needed --noconfirm zsh zsh-completions

yay -S --removemake --cleanafter --norebuild --noredownload --noconfirm \
    oh-my-zsh-git \
    starship \
    zsh-fast-syntax-highlighting \
    zsh-autosuggestions

chsh -s $(which zsh)
sudo chsh -s $(which zsh)
rm -f ~/.zshrc ~/.zshenv ~/.zcompdump*

ln -s \
    "$PWD"/.zshrc \
    ~/
