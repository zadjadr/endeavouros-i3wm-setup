#!/bin/bash
#
set -euxo pipefail

su -
systemctl enable systemd-homed
systemctl start systemd-homed