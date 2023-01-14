#!/bin/bash
set -euxo pipefail

git config --global user.name "Zadjad Rezai"

git config --global core.editor vim
git config --global init.defaultBranch main

echo "Please add your email via git config --global user.email"
