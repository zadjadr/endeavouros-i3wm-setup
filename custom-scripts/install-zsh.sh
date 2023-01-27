#!/bin/bash
set -euxo pipefail

sudo pacman -Sy --needed --noconfirm zsh zsh-completions

rm -f ~/.zshrc ~/.zshenv
ln -s \
    "$PWD"/.zshrc \
    ~/

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

chsh -s $(which zsh)
sudo chsh -s $(which zsh)
