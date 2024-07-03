#!/bin/bash

# Check if the OS is Arch Linux
if [ -f /etc/arch-release ]; then
    echo "Arch Linux detected. Setting up systemd service..."

    # Get the current directory
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

    # Create the systemd service file
    cat << EOF | sudo tee /etc/systemd/system/minecraft-server.service > /dev/null
[Unit]
Description=Minecraft Server with playit.gg
After=network.target docker.service

[Service]
Type=simple
User=$USER
WorkingDirectory=$SCRIPT_DIR
ExecStart=$SCRIPT_DIR/start_server.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

    # Reload systemd, enable and start the service
    sudo systemctl daemon-reload
    sudo systemctl enable minecraft-server.service
    sudo systemctl start minecraft-server.service

    echo "Systemd service created and started. The Minecraft server will now start automatically on system boot."
else
    echo "This script is intended for Arch Linux. Your current OS is not detected as Arch Linux."
    exit 1
fi