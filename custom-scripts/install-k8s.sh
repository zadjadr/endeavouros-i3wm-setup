#!/bin/bash
#
set -euxo pipefail

# Install Kubernetes related packages
sudo pacman -Sy --needed --noconfirm - < custom-scripts/k8s.list

## kind
go install sigs.k8s.io/kind@latest

## cilium
CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/master/stable.txt)
CLI_ARCH=amd64
curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum
tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz ~/.local/bin
rm cilium-linux-${CLI_ARCH}.tar.gz*

## linkerd
curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/install | sh

## Others
yay -S --removemake --cleanafter --norebuild --noredownload --noconfirm \
    openlens-bin