#!/bin/bash
#
set -euxo pipefail

sudo pacman -Sy --needed --noconfirm - < custom-scripts/pkgsway.list
