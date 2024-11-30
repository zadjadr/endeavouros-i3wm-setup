#!/bin/bash
#
set -euxo pipefail

sudo pacman -S optimus-manager

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Step 1: Ensure Xorg is used by ly
LY_CONFIG="/etc/ly/config.ini"
echo "Configuring ly to use Xorg..."
if [ -f "$LY_CONFIG" ]; then
    # sed -i 's/^x_display.*/x_display :1/' "$LY_CONFIG"
		echo "✅ Found $LY_CONFIG!"
else
    echo "❌ $LY_CONFIG not found. Please install ly and try again."
    exit 1
fi

# Step 2: Modify ly service to run /usr/bin/prime-offload
LY_SERVICE="/usr/lib/systemd/system/ly.service"
if [ ! -f "$LY_SERVICE" ]; then
    LY_SERVICE="/etc/systemd/system/ly.service"
fi

echo "Creating service override for ly to run prime-offload..."
mkdir -p "$LY_SERVICE.d"
cat << 'EOF' > "$LY_SERVICE.d/override.conf"
[Service]
ExecStartPost=/usr/bin/prime-offload
EOF

systemctl daemon-reload

# Step 3: Create a session wrapper to run /usr/bin/prime-switch on logout
SESSION_WRAPPER="/usr/local/bin/ly-session-wrapper"
echo "Creating session wrapper for prime-switch..."
cat << 'EOF' > "$SESSION_WRAPPER"
#!/bin/bash
trap '/usr/bin/prime-switch' EXIT
exec "$@"
EOF
chmod +x "$SESSION_WRAPPER"

# Configure ly to use the session wrapper
if [ -f "$LY_CONFIG" ]; then
    echo "Configuring ly to use the session wrapper..."
    if grep -q '^login_cmd' "$LY_CONFIG"; then
        sed -i 's|^login_cmd.*|login_cmd /usr/local/bin/ly-session-wrapper /bin/bash -login -c "/usr/bin/ly"|' "$LY_CONFIG"
    else
        echo "login_cmd /usr/local/bin/ly-session-wrapper /bin/bash -login -c \"/usr/bin/ly\"" >> "$LY_CONFIG"
    fi
else
    echo "$LY_CONFIG not found. Could not configure ly to use the session wrapper."
    exit 1
fi

# Step 4: Restart ly
echo "Restarting ly service..."
systemctl restart ly

# Done
echo "Setup complete! Reboot your system to apply the changes."
