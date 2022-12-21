#!/bin/bash
#
set -euxo pipefail

# Install AUR packages
## Install timeshift
yay -S timeshift-bin

## timeshift seems to have a bug where it does not create a crontab as expected
## run this after installation and creation of your backup schedule
# timeshift --check
## create empty crontab
# crontab -e