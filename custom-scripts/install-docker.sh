#!/bin/bash
set -exuo pipefail

sudo pacman -Sy
sudo pacman -S docker docker-buildx docker-compose

sudo usermod -aG docker "$(whoami)"
