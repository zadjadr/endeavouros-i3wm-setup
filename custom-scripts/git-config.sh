#!/bin/bash
set -euxo pipefail

git config --global user.name "$1"

git config --global core.editor vim
git config --global init.defaultBranch main
git config --global push.autoSetupRemote true

git config --global user.email "$2"
git config --global core.excludesFile "$HOME/.git/.gitignore"
