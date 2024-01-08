#!/bin/bash

# Install whiptail if not already installed
sudo apt-get update
sudo apt-get -y install whiptail

# Prompt the user to enter the NTP server IP address
ntp_server=$(whiptail --inputbox "Enter the IP address of the NTP server:" 10 60 172.16.200.3 --title "NTP Server Configuration" 3>&1 1>&2 2>&3)

# Check if the user pressed Cancel or entered an empty value
if [ $? -ne 0 ] || [ -z "$ntp_server" ]; then
    whiptail --msgbox "No NTP server IP address entered. Exiting." 10 60 --title "NTP Server Configuration"
    exit 1
fi

# Install the NTP package
sudo apt-get -y install ntp

# Backup the original NTP configuration file
sudo cp /etc/ntp.conf /etc/ntp.conf.bak

# Configure NTP to use the specified NTP server
sudo sed -i 's/^pool/#pool/' /etc/ntp.conf
echo "server $ntp_server" | sudo tee -a /etc/ntp.conf

# Restart the NTP service
sudo systemctl restart ntp

whiptail --msgbox "NTP server setup complete!" 10 60 --title "NTP Server Configuration"
