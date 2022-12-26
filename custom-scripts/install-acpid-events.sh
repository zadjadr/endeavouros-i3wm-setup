#!/bin/bash
# Allows to automatically disable/enable the laptop screen when the lid is opend/closed

sudo pacman -S acpid --needed --noconfirm

sudo mkdir /etc/acpi/actions

sudo tee /etc/acpi/actions/lid.sh > /dev/null <<EOT
#!/bin/bash
# Automatically enable/disable output to Laptop (LVDS1) when lid close/open event happens

export XAUTHORITY=/home/$USER/.Xauthority
export DISPLAY=":0.0"

case "$3" in
    close)
        logger 'LID closed'
        xrandr --output LVDS1 --off
        ;;
    open)
        logger 'LID opened'
        xrandr --output LVDS1 --auto
        ;;
    *)
        logger "ACPI action undefined: $3"
        ;;
esac
EOT

sudo tee /etc/acpi/events/lid > /dev/null <<EOT
event=button/lid LID (open|close)
action=/etc/acpi/actions/lid.sh
EOT

sudo chmod +x /etc/acpi/actions/lid.sh

# remove 'anything' event handler
sudo rm /etc/acpi/events/anything

# restart & enable acpid
sudo systemctl stop acpid
sudo systemctl enable acpid
sudo systemctl start acpid