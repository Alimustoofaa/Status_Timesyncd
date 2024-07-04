#!/bin/bash

# Secure directory where the script will be copied
secure_directory="/var/lib/status_timesyncd"

# Create the secure directory if it does not exist
mkdir -p "${secure_directory}"

# Copy the script to the secure directory
cp check_timesyncd.sh "${secure_directory}/"

# Create the systemd service file
echo "[Unit]
Description=Check Status Timesyncd
After=network.target

[Service]
ExecStart=bash ${secure_directory}/check_timesyncd.sh
Restart=always
User=$(whoami)

[Install]
WantedBy=default.target" > /etc/systemd/system/check_timesyncd.service

# Reload systemd to load the new service file
systemctl daemon-reload

# Start and enable the service
systemctl start check_timesyncd.service
systemctl enable check_timesyncd.service