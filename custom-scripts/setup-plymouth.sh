#!/bin/bash
# TODO implement this as a pacman hook to install after every update to sway
#
set -euxo pipefail

git clone https://github.com/pop-os/plymouth-theme.git /tmp/plymouth-theme
sudo mkdir -p /usr/share/plymouth/themes/pop-basic/
sudo cp -r /tmp/plymouth-theme/pop-basic/* /usr/share/plymouth/themes/pop-basic/

sudo tee /etc/plymouth/plymouthd.conf > /dev/null <<EOT
[Daemon]
Theme=pop-basic
EOT

# /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash rd.luks.options=plymouth"

# /etc/mkinitcpio.conf
# Add 'plymouth' to HOOKS

sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo mkinitcpio -P
