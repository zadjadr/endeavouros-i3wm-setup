#!/bin/bash
#
set -euxo pipefail

sudo tee /etc/X11/xorg.conf.d/90-touchpad.conf > /dev/null <<EOT
Section "InputClass"
  Identifier "touchpad"
  MatchIsTouchpad "on"
  Driver "libinput"
  Option "Tapping" "on"
  Option "NaturalScrolling" "true"
  Option "TappingButtonMap" "lrm" # 1/2/3 finger, for 3-finger middle lrm
EndSection
EOT
