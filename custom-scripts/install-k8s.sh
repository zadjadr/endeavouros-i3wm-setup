#!/bin/bash
#
set -euxo pipefail

# Install Kubernetes related packages
sudo pacman -Sy --needed --noconfirm - < custom-scripts/k8s.list

## kind
go install sigs.k8s.io/kind@latest

## Others
yay -S --removemake --cleanafter --norebuild --noredownload --noconfirm \
    openlens-bin
