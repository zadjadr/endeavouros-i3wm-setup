#!/bin/bash
set -exuo pipefail

sudo pacman -Sy docker docker-buildx docker-compose --needed --noconfirm

sudo usermod -aG docker "$USER"
