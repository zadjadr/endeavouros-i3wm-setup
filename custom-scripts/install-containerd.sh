#!/bin/bash
set -exuo pipefail

sudo pacman -Sy nerdctl buildkit containerd rootlesskit slirp4netns cni-plugins --needed --noconfirm

containerd-rootless-setuptool.sh install
containerd-rootless-setuptool.sh install-buildkit-containerd
nerdctl run --rm curlimages/curl curl -s -I6 example.com
