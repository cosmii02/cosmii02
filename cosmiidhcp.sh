#!/bin/bash

# Check if the user is running the script with root privileges
if [[ $EUID -ne 0 ]]; then
   whiptail --title "Error" --msgbox "This script must be run as root." 10 50
   exit 1
fi

# Install DHCP package
apt-get update
apt-get install isc-dhcp-server -y

# Prompt user for DHCP server settings
DOMAIN=$(whiptail --inputbox "Enter your domain name:" 10 50 3>&1 1>&2 2>&3)
DNSIP=$(whiptail --inputbox "Enter the IP address of the DNS server:" 10 50 3>&1 1>&2 2>&3)
IPRANGE=$(whiptail --inputbox "Enter the DHCP IP range (e.g. 192.168.1.100 192.168.1.200):" 10 50 3>&1 1>&2 2>&3)
GATEWAY=$(whiptail --inputbox "Enter the IP address of the gateway:" 10 50 3>&1 1>&2 2>&3)
NETMASK=$(whiptail --inputbox "Enter the subnet mask:" 10 50 3>&1 1>&2 2>&3)

# Configure DHCP server
echo "authoritative;
subnet $IPRANGE netmask $NETMASK {
  range dynamic-bootp $IPRANGE;
  option domain-name \"$DOMAIN\";
  option domain-name-servers $DNSIP;
  option routers $GATEWAY;
}" >> /etc/dhcp/dhcpd.conf

# Restart DHCP server
systemctl restart isc-dhcp-server

# Display completion message
whiptail --title "Success" --msgbox "ISC DHCP server has been successfully set up!" 10 50
