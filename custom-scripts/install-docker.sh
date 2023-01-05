#!/bin/bash
set -exuo pipefail

sudo pacman -Sy
sudo pacman -S docker docker-buildx docker-compose --needed --noconfirm

sudo usermod -aG docker "$(whoami)"
