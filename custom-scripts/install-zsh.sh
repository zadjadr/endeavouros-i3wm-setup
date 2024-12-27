#!/bin/bash
set -euxo pipefail

sudo pacman -Sy --needed --noconfirm zsh zsh-completions

paru -S --removemake --cleanafter --norebuild --noredownload --noconfirm \
    oh-my-zsh-git \
    starship \
    zsh-fast-syntax-highlighting \
    zsh-autosuggestions

chsh -s /bin/zsh
sudo chsh -s /bin/zsh
rm -f ~/.zshrc ~/.zshenv ~/.zcompdump*

ln -s \
    "$PWD"/.zshrc \
    ~/
