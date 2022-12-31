#!/bin/bash
#
set -euxo pipefail

sudo tee -a /etc/fstab > /dev/null <<EOT
#######################################################################
# to automount my specific partitions
#
LABEL=APPDATA /mnt/APPDATA auto nosuid,nodev,nofail,x-gvfs-show 0 0
LABEL=BACKUP /mnt/BACKUP auto nosuid,nodev,nofail,x-gvfs-show 0 0
EOT