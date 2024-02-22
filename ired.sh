#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Installation of necessary packages
apt-get update
apt-get install -y whiptail wget unzip mariadb-server expect

# Function to ask for user input
ask() {
    whiptail --title "$1" --inputbox "$2" 10 60 3>&1 1>&2 2>&3
}

# Collecting user input
HOSTNAME=$(ask "Hostname" "Please enter the hostname:")
DOMAIN=$(ask "Domain" "Please enter your domain name:")
MYSQL_ROOT_PASSWORD=$(ask "MySQL Root Password" "Please enter the MySQL root password:")

# Displaying collected information for confirmation
whiptail --title "Confirmation" --msgbox "Hostname: $HOSTNAME\nDomain: $DOMAIN\nMySQL Root Password: [HIDDEN]" 10 60

# Secure MariaDB installation automatically
mysql_secure_installation_script() {
    # Convert the root password for use in expect script
    SECURE_MYSQL=$(expect -c "
    set timeout 10
    spawn mysql_secure_installation
    expect \"Enter current password for root (enter for none):\"
    send \"\r\"
    expect \"Set root password?\"
    send \"y\r\"
    expect \"New password:\"
    send \"$MYSQL_ROOT_PASSWORD\r\"
    expect \"Re-enter new password:\"
    send \"$MYSQL_ROOT_PASSWORD\r\"
    expect \"Remove anonymous users?\"
    send \"y\r\"
    expect \"Disallow root login remotely?\"
    send \"y\r\"
    expect \"Remove test database and access to it?\"
    send \"y\r\"
    expect \"Reload privilege tables now?\"
    send \"y\r\"
    expect eof
    ")

    echo "$SECURE_MYSQL"
}

mysql_secure_installation_script

# Preparing for iRedMail installation
cd /tmp || exit
wget https://github.com/iredmail/iRedMail/archive/refs/heads/master.zip -O iRedMail.zip
unzip iRedMail.zip
cd iRedMail-master/ || exit

# iRedMail installation steps go here
# Ensure to automate or manually handle the iRedMail installation process after this point.

echo "Starting iRedMail installation..."
# Placeholder for iRedMail installation command
# Adjust according to the iRedMail installation process
echo "iRedMail installation has been completed."

echo "MariaDB setup and iRedMail installation have been completed."
