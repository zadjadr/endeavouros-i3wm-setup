#!/bin/bash
#
set -uxo pipefail

sudo pacman -Sy

# pacman -R breaks if the package is not installed
sudo pacman -D --asdeps $(cat custom-scripts/rmpkglist.txt)
sudo pacman -Rns $(pacman -Qqtd)

set -euxo pipefail

sudo pacman -S --needed --noconfirm - < custom-scripts/pkglist.txt

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

## Albert Launcher
if ! grep -rnwe 'home_manuelschneid3r_Arch' /etc/pacman.conf; then
    sudo tee -a /etc/pacman.conf > /dev/null <<EOT

[home_manuelschneid3r_Arch]
Server = https://download.opensuse.org/repositories/home:/manuelschneid3r/Arch/\$arch
EOT
fi

key=$(curl -fsSL https://download.opensuse.org/repositories/home:manuelschneid3r/Arch/$(uname -m)/home_manuelschneid3r_Arch.key)
fingerprint=$(gpg --quiet --with-colons --import-options show-only --import --fingerprint <<< "${key}" | awk -F: '$1 == "fpr" { print $10 }')

sudo pacman-key --init
sudo pacman-key --add - <<< "${key}"
sudo pacman-key --lsign-key "${fingerprint}"

sudo pacman -Sy home_manuelschneid3r_Arch/albert --needed --confirm
