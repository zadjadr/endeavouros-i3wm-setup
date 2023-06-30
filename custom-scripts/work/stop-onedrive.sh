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

sudo tee /usr/local/bin/stop-onedrive-before-unmount.sh > /dev/null <<"EOT"
#!/bin/bash

# Function to stop the onedrive service
stop_onedrive() {
    systemctl --user stop onedrive
}

# Function to handle the shutdown signal
shutdown_handler() {
    stop_onedrive
    wait_for_service_stop
    echo "Shutting down the system..."
    # Additional cleanup or actions before shutting down
    shutdown -h now
}

# Function to handle the reboot signal
reboot_handler() {
    stop_onedrive
    wait_for_service_stop
    echo "Rebooting the system..."
    # Additional cleanup or actions before rebooting
    reboot
}

# Function to wait for the onedrive service to stop
wait_for_service_stop() {
    while [[ $(systemctl --user is-active onedrive) == "active" ]]; do
        sleep 1
    done
}

# Register the shutdown and reboot signal handlers
trap shutdown_handler SIGINT SIGTERM
trap reboot_handler SIGUSR1
EOT

sudo chmod +x /usr/local/bin/stop-onedrive-before-unmount.sh

sudo tee /etc/systemd/system/stop-onedrive-before-unmount.service > /dev/null <<EOT
[Unit]
Description=Stop OneDrive before shutdown or reboot
DefaultDependencies=no
Before=shutdown.target reboot.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/stop-onedrive-before-unmount.sh

[Install]
WantedBy=multi-user.target
EOT

sudo systemctl daemon-reload
sudo systemctl enable stop-onedrive-before-unmount.service
sudo systemctl start stop-onedrive-before-unmount.service
sudo systemctl status stop-onedrive-before-unmount.service
