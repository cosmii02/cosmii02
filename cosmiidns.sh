#!/bin/bash

# Check if the user is running the script with root privileges
if [[ $EUID -ne 0 ]]; then
   whiptail --title "Error" --msgbox "This script must be run as root." 10 50
   exit 1
fi

# Install BIND9 package
apt-get update
apt-get install bind9 -y

# Prompt user for DNS server settings
DOMAIN=$(whiptail --inputbox "Enter your domain name:" 10 50 3>&1 1>&2 2>&3)
DNSIP=$(whiptail --inputbox "Enter the IP address of this DNS server:" 10 50 3>&1 1>&2 2>&3)
PRIMARY=$(whiptail --inputbox "Enter the IP address of the primary DNS server:" 10 50 3>&1 1>&2 2>&3)
SECONDARY=$(whiptail --inputbox "Enter the IP address of the secondary DNS server:" 10 50 3>&1 1>&2 2>&3)

# Configure BIND9
echo "
zone \"$DOMAIN\" {
    type master;
    file \"/etc/bind/db.$DOMAIN\";
    allow-transfer { $PRIMARY; $SECONDARY; };
};

zone \"0.0.10.in-addr.arpa\" {
    type master;
    file \"/etc/bind/db.10\";
    allow-transfer { $PRIMARY; $SECONDARY; };
};
" >> /etc/bind/named.conf.local

cat << EOF > /etc/bind/db.$DOMAIN
\$TTL    86400
@       IN      SOA     ns1.$DOMAIN. admin.$DOMAIN. (
                        1       ; serial
                        3600    ; refresh
                        1800    ; retry
                        604800  ; expire
                        86400 ) ; minimum TTL

                IN      NS      ns1.$DOMAIN.
                IN      NS      ns2.$DOMAIN.

ns1             IN      A       $DNSIP
ns2             IN      A       $DNSIP
EOF

cat << EOF > /etc/bind/db.10
\$TTL    86400
@       IN      SOA     ns1.$DOMAIN. admin.$DOMAIN. (
                        1       ; serial
                        3600    ; refresh
                        1800    ; retry
                        604800  ; expire
                        86400 ) ; minimum TTL

                IN      NS      ns1.$DOMAIN.
                IN      NS      ns2.$DOMAIN.

$DNSIP           IN      PTR     ns1.$DOMAIN.
EOF

# Restart BIND9 service
systemctl restart bind9

# Display completion message
whiptail --title "Success" --msgbox "BIND9 DNS server has been successfully set up!" 10 50
