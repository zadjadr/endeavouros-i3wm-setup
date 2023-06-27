#!/bin/bash
#
# the mount in /mnt/BACKUP is used for onedrive
# onedrive will block the unmount when shutting down / rebooting
# and result in an error.
# Hence, we should stop onedrive before the user session is stopped.
#
# Although it may not be tied to a specific target like umount.target,
# it will ensure that the onedrive service is stopped before the user session manager
# initiates the shutdown process, allowing for safe unmounting of volumes.
#
set -euxo pipefail

sudo tee ~/.config/systemd/user/stop-onedrive-before-unmount.service > /dev/null <<EOT
[Unit]
Description=Stop onedrive service before user session manager shutdown

[Service]
Type=oneshot
ExecStart=/bin/true
ExecStop=/usr/bin/systemctl --user stop onedrive

[Install]
WantedBy=default.target
EOT

systemctl --user daemon-reload
systemctl --user enable stop-onedrive-before-unmount.service
systemctl --user start stop-onedrive-before-unmount.service
systemctl --user status stop-onedrive-before-unmount.service
