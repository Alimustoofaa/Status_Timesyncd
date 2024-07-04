#!/bin/bash

# Function to check and restart systemd-timesyncd.service
check_and_restart_service() {
    # Check the status of the service
    SERVICE_STATUS=$(systemctl is-active systemd-timesyncd.service)

    # If the service is not active, restart it
    if [ "$SERVICE_STATUS" != "active" ]; then
        echo "$(date): systemd-timesyncd.service is $SERVICE_STATUS. Restarting..."
        systemctl restart systemd-timesyncd.service

        # Check the status again after attempting a restart
        NEW_STATUS=$(systemctl is-active systemd-timesyncd.service)
        if [ "$NEW_STATUS" == "active" ]; then
            echo "$(date): systemd-timesyncd.service has been successfully restarted."
        else
            echo "$(date): Failed to restart systemd-timesyncd.service. Current status: $NEW_STATUS."
        fi
    else
        echo "$(date): systemd-timesyncd.service is running normally."
    fi
}

# Main loop to continuously check the service status
while true; do
    check_and_restart_service
    # Sleep for a specified interval before checking again
    sleep 10
done
