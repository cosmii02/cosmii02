#!/bin/bash

# Define your SNMPv3 user and authentication and encryption details
SNMP_USERNAME="student"
AUTH_PASSWORD="Passw0rd"
ENC_PASSWORD="Passw0rd"

# Install SNMP and necessary components
echo "Installing SNMP and its components..."
sudo apt-get update
sudo apt-get install -y snmpd snmp libsnmp-dev

# Stop the SNMP daemon if it's currently running
echo "Stopping SNMP daemon..."
sudo systemctl stop snmpd

# Backup the original SNMP configuration file
echo "Backing up the original SNMP configuration file..."
sudo cp /etc/snmp/snmpd.conf /etc/snmp/snmpd.conf.bak

# Create a new SNMP configuration
echo "Configuring SNMP..."
sudo bash -c 'cat > /etc/snmp/snmpd.conf' << EOF
# Example configuration file for SNMPv3
# Listen for connections from any network
agentAddress udp:0.0.0.0:161

# Create a user with authentication and encryption
createUser $SNMP_USERNAME SHA $AUTH_PASSWORD AES $ENC_PASSWORD

# Set the security and access parameters for the user
rwuser $SNMP_USERNAME priv
EOF

# Change the permissions and owner of the SNMP configuration
sudo chmod 600 /etc/snmp/snmpd.conf
sudo chown root:snmp /etc/snmp/snmpd.conf

# Enable and start the SNMP daemon
echo "Enabling and starting SNMP daemon..."
sudo systemctl enable snmpd
sudo systemctl start snmpd

echo "SNMPv3 is now installed and configured with username '$SNMP_USERNAME'."
