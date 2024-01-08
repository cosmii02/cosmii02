#!/bin/bash

# Nagios configuration directory
NAGIOS_CONFIG_DIR="/usr/local/nagios/etc/servers"

# Function to add a host to Nagios
add_host_to_nagios() {
    # Prompt the user for the host name
    read -p "Enter the host name: " HOST_NAME

    # Prompt the user for the host IP address
    read -p "Enter the host IP address: " HOST_IP

    # Create a configuration file for the host in the servers directory
    HOST_CONFIG_FILE="${NAGIOS_CONFIG_DIR}/${HOST_NAME}.cfg"

    # Check if the host configuration file already exists
    if [ -e "$HOST_CONFIG_FILE" ]; then
        echo "Host configuration file already exists. Aborting."
        exit 1
    fi

    # Create the host configuration file
    echo "define host {
        use                     linux-server
        host_name               ${HOST_NAME}
        alias                   ${HOST_NAME} Host
        address                 ${HOST_IP}
    }

    define service {
        use                     generic-service
        host_name               ${HOST_NAME}
        service_description     PING
        check_command           check_ping!100.0,20%!500.0,60%
    }" | sudo tee "$HOST_CONFIG_FILE"

    # Verify the Nagios configuration
    sudo /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg

    # Reload Nagios to apply the new configuration
    sudo systemctl reload nagios
}

# Main script execution
echo "Adding a host to Nagios..."

# Check if the script is running with root privileges
if [ "$(id -u)" != "0" ]; then
    echo "Please run this script as root or with sudo."
    exit 1
fi

# Check if the servers directory exists; create it if not
if [ ! -d "$NAGIOS_CONFIG_DIR" ]; then
    sudo mkdir -p "$NAGIOS_CONFIG_DIR"
fi

# Run the function to add the host to Nagios
add_host_to_nagios

echo "Host added to Nagios configuration."
