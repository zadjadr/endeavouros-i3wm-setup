#!/bin/bash
set -exuo pipefail

sudo pacman -Sy docker docker-buildx docker-compose --needed --noconfirm

sudo usermod -aG docker "$USER"

## Add IPv6 support
sudo tee /etc/docker/daemon.json > /dev/null <<EOT
{
  "ipv6": true,
  "fixed-cidr-v6": "fd00::/80"
}
EOT

sudo ip6tables -t nat -A POSTROUTING -s fd00::/80 ! -o docker0 -j MASQUERADE
### Test that it works!
docker run --rm curlimages/curl curl -v -6 example.com
