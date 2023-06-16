#!/bin/bash
set -exuo pipefail

sudo pacman -Sy docker docker-buildx docker-compose --needed --noconfirm

sudo usermod -aG docker "$USER"
newgrp docker

## Add IPv6 support
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json > /dev/null <<EOT
{
    "runtimes": {
        "nvidia": {
            "path": "nvidia-container-runtime",
            "runtimeArgs": []
        }
    },
    "data-root": "/mnt/APPS/var/lib/docker",
    "ipv6": true,
    "fixed-cidr-v6": "fd00::/80"
}
EOT

sudo ip6tables -t nat -A POSTROUTING -s fd00::/80 ! -o docker0 -j MASQUERADE
### Test that it works!
sudo systemctl start docker
# needs sudo before first logout
docker run --rm curlimages/curl curl -v -6 example.com
