#!/bin/bash
#
set -euxo pipefail

# Install AUR packages
## Install timeshift
yay -S --removemake --cleanafter --norebuild --noredownload \
    timeshift-bin
    
sudo systemctl enable cronie
sudo systemctl start cronie

# create empty cronfiles, otherwise 'crontab -l' will fail in timeshift
touch /var/spool/cron/$USER
sudo touch /var/spool/cron/root

sudo mkdir /etc/crontab
