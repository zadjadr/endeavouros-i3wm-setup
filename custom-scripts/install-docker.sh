#!/bin/bash
set -exuo pipefail

sudo pacman -Sy docker docker-buildx docker-compose --needed --noconfirm

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
# Set group
sudo usermod -aG docker "$USER"
sudo chown -R --changes root:docker /etc/docker

newgrp docker <<EOF
sudo systemctl start docker
docker run --rm curlimages/curl curl -s -6 example.com
EOF
