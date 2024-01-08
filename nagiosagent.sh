#!/bin/bash

# Define the Nagios server IP address
NAGIOS_SERVER_IP="10.100.0.50"

# Function to install and configure NRPE
install_configure_nrpe() {
    # Update package lists
    sudo apt-get update

    # Install NRPE and Nagios plugins
    sudo apt-get install -y nagios-nrpe-server nagios-plugins

    # Add Nagios server IP to allowed_hosts in NRPE configuration
    echo "allowed_hosts=127.0.0.1,${NAGIOS_SERVER_IP}" | sudo tee -a /etc/nagios/nrpe.cfg

    # Restart the NRPE service
    sudo systemctl restart nagios-nrpe-server

    # Open port 5666 in the firewall (if applicable)
    sudo ufw allow 5666/tcp
}

# Main script execution
echo "Installing and configuring NRPE on the remote server..."

# Check if the script is running with root privileges
if [ "$(id -u)" != "0" ]; then
    echo "Please run this script as root or with sudo."
    exit 1
fi

# Run the installation and configuration function
install_configure_nrpe

echo "NRPE installation and configuration completed."
