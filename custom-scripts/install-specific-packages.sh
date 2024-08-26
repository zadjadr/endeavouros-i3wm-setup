#!/bin/bash
#
set -euxo pipefail

sudo pacman -Sy --needed --noconfirm - < $1
