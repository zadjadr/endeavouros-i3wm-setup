#!/bin/bash
#
# the mount in /mnt/BACKUP is used for onedrive
# onedrive will block the unmount when shutting down / rebooting
# and result in an error.
# Hence, we should unmount /mnt/BACKUP before shutting down / rebooting.
#
set -euxo pipefail

sudo tee /etc/systemd/system/unmount-volume.service > /dev/null <<EOT
[Unit]
Description=Unmount Volume before Shutdown/Reboot
DefaultDependencies=no
Before=shutdown.target reboot.target

[Service]
Type=oneshot
ExecStart=/bin/true
ExecStop=/bin/umount /mnt/BACKUP

[Install]
WantedBy=shutdown.target reboot.target
EOT

sudo systemctl enable unmount-volume.service
sudo systemctl daemon-reload
