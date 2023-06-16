#!/bin/bash
#
set -euxo pipefail

BG_DIR=/usr/share/backgrounds
sudo rm -rf "$BG_DIR"
sudo ln -s ${1:-"/mnt/BACKUP/MEGA/03_data/backgrounds"} /usr/share

BACKGROUND=${2:-"106956.png"}
EXTENSION="${BACKGROUND##*.}"

SIZE=$(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/')
RESIZED_BG="${BG_DIR}/${SIZE}_${BACKGROUND}"

convert "${BG_DIR}/${BACKGROUND}" -resize "$SIZE"\! "$RESIZED_BG"

tee "$HOME"/.config/nitrogen/bg-saved.cfg > /dev/null <<EOT
[xin_-1]
file=${RESIZED_BG}
mode=0
bgcolor=#000000
EOT

LIGHTDM_BACKGROUND=/usr/share/pixmaps/lightdm_background.$EXTENSION
sudo cp "$RESIZED_BG" "$LIGHTDM_BACKGROUND"

sudo tee /etc/lightdm/slick-greeter.conf > /dev/null <<EOT
[Greeter]
background=$LIGHTDM_BACKGROUND
draw-user-backgrounds=false
draw-grid=true
theme-name=Arc-Darker
icon-theme-name=Papirus-Dark
cursor-theme-name=Bibata-Modern-Classic
cursor-theme-size=16
show-a11y=false
show-power=false
background-color=#000000
EOT

tee "$HOME"/.config/i3/scripts/lock > /dev/null <<EOT
#!/bin/bash
#
i3lock --nofork --show-failed-attempts --image "$RESIZED_BG"
EOT

chmod +x $HOME/.config/i3/scripts/lock
nitrogen --restore
