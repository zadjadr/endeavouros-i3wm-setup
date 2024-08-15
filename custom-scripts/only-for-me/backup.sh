#!/bin/bash
#
# Creates a systemd.timer that updates the pacman mirrorlist
# You might want to set your country in the reflector argument `-c`
#
set -euxo pipefail

sudo tee /usr/local/bin/10-backup-to-nextcloud.sh > /dev/null <<'EOT'
#!/bin/bash
#
DIR=$1
DATE=$(date "+%F_%H-%M")

# Calculate the timestamp for the date 1 day ago
one_day_ago=$(date -d "3 hours ago" +%s)

tar cvfz \
  --exclude-backups \
  --exclude-caches \
  --exclude "github.com" \
  --exclude "migrations" \
  --exclude ".terraform" \
  --exclude ".venv" \
  --exclude ".devcontainer" \
  --exclude "salt/gpgkeys" \
  --exclude "node_modules" \
  --exclude "vendor" \
  --exclude "debug" \
  ${DIR} | zstd \
  | gpg --symmetric --passphrase "${NEXTCLOUD_GPG_PASSPHRASE}" --batch --compress-algo none --cipher-algo aes256 --digest-algo sha512 > /tmp/documents-${DATE}.tar.zstd.enc

trickle -s -d 0 -u 24000 \
  curl -s -u ${NEXTCLOUD_USER}:${NEXTCLOUD_APP_PASSWORD} -T /tmp/documents-${DATE}.tar.zstd.enc ${NEXTCLOUD_URL}/remote.php/dav/files/${NEXTCLOUD_USER}/backup/

# Delete old files
files=$(curl -s ${NEXTCLOUD_URL}/remote.php/dav/files/${NEXTCLOUD_USER}/backup \
  --user ${NEXTCLOUD_USER}:${NEXTCLOUD_APP_PASSWORD} \
  --request PROPFIND \
  --data '<?xml version="1.0" encoding="UTF-8"?>
    <d:propfind xmlns:d="DAV:" xmlns:oc="http://owncloud.org/ns" xmlns:nc="http://nextcloud.org/ns">
      <d:prop>
        <d:getlastmodified/>
      </d:prop>
    </d:propfind>' | xmllint --xpath "(//*[local-name()='response'])[position() > 1]/*[local-name()='href']/text()" -)

# Iterate over the files in the variable
for file in $files; do
  # Extract the date and time from the filename
  filename=$(basename "$file")
  file_date=$(echo "$filename" | awk -F 'documents-|_' '{print $2}')
  file_time=$(echo "$filename" | awk -F '_' '{print $2}' | cut -d'.' -f1)
  file_time=${file_time//-/:}

  # Create a timestamp from the date and time
  file_timestamp=$(date -d "$file_date $file_time" +%s)

  # Compare the file timestamp with the timestamp of 1 day ago
  if [ "$file_timestamp" -lt "$one_day_ago" ]; then
    echo "File older than 1 day: $file"

    curl -s ${NEXTCLOUD_URL}${file} \
      --user ${NEXTCLOUD_USER}:${NEXTCLOUD_APP_PASSWORD} \
      --request DELETE
  fi
done

rm /tmp/documents-${DATE}.tar.zstd.enc
EOT

sudo chmod +x /usr/local/bin/10-backup-to-nextcloud.sh

sudo tee /etc/systemd/system/10-backup-to-nextcloud.service > /dev/null <<EOT
[Unit]
Description=Take backups
Wants=network-online.target
After=network-online.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/10-backup-to-nextcloud.sh /mnt/BACKUP/Documents
EnvironmentFile=/etc/10-backup-to-nextcloud/10-backup-to-nextcloud.conf
EOT


sudo tee /etc/systemd/system/10-backup-to-nextcloud.timer > /dev/null <<EOT
[Unit]
Description=Update mirrors

[Timer]
OnCalendar=hourly
Persistent=true
RandomizedDelaySec=30

[Install]
WantedBy=timers.target

EOT

sudo systemctl enable 10-backup-to-nextcloud.timer
sudo systemctl daemon-reload
sudo systemctl start 10-backup-to-nextcloud.timer
sudo systemctl list-timers --all

sudo systemctl daemon-reload
