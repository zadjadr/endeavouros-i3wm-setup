#!/bin/bash
#
# Creates a systemd.timer that updates the pacman mirrorlist
# You might want to set your country in the reflector argument `-c`
#
set -uxo pipefail

sudo tee /usr/local/bin/10-update-mirrorlists.sh > /dev/null <<EOT
#!/bin/bash
#
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
if output=$(grep EndeavourOS -q /etc/lsb-release); then
    eos-rankmirrors
fi
if output=$(which reflector); then
    reflector --verbose -c DE --protocol https --sort rate --latest 10 --download-timeout 2 > /etc/pacman.d/mirrorlist
    exit 0
fi
if output=$(which pacman-mirrors); then
    pacman-mirrors -c Germany
    exit 0
fi

echo "Failed to update pacman mirrors.."
exit 1
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
RandomizedDelaySec=30

[Install]
WantedBy=timers.target

EOT

sudo systemctl enable 10-update-mirrorlists.timer
sudo systemctl daemon-reload
sudo systemctl start 10-update-mirrorlists.timer
sudo systemctl list-timers --all

sudo systemctl daemon-reload
