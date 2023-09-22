#!/bin/bash
#
# Change some system properties and packages according to my needs
#
set -euxo pipefail

# Enable trim operations on SSD/NVME
sudo systemctl enable --now fstrim.timer
