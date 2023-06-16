#!/bin/bash
#
# Creates a systemd.timer that updates the pacman mirrorlist
# You might want to set your country in the reflector argument `-c`
#
set -euxo pipefail

sudo tee /usr/local/bin/10-update-mirrorlists.sh > /dev/null <<EOT
#!/bin/bash
#
if output=$(reflector --verbose -c DE --protocol https --sort rate --latest 10 --download-timeout 2 > /tmp/mirrorlist); then
    cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
    cp /tmp/mirrorlist /etc/pacman.d/mirrorlist
    exit 0
fi

sudo pacman-mirrors --country Germany --api --protocol https
EOT

sudo chmod +x /usr/local/bin/10-update-mirrorlists.sh

sudo tee /etc/systemd/system/10-update-mirrorlists.service > /dev/null <<EOT
[Unit]
Description=Update mirrorlists
Wants=network-online.target
After=network-online.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/10-update-mirrorlists.sh

EOT


sudo tee /etc/systemd/system/10-update-mirrorlists.timer > /dev/null <<EOT
[Unit]
Description=Update mirrors

[Timer]
OnCalendar=Mon,Thu 14:00
Persistent=true
RandomizedDelaySec=true

[Install]
WantedBy=timers.target

EOT

sudo systemctl enable 10-update-mirrorlists.timer
sudo systemctl start 10-update-mirrorlists.timer
sudo systemctl list-timers --all

sudo systemctl daemon-reload
