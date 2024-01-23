#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Ask for confirmation before proceeding
read -p "Are you sure you want to remove all databases and uninstall WordPress and its components? [y/N] " confirmation
if [[ $confirmation != "y" && $confirmation != "Y" ]]; then
    echo "Uninstall cancelled."
    exit
fi

# Disable the Apache2 site configuration
a2dissite wordpress.conf
systemctl reload apache2

# Stop and disable Apache2 and MariaDB services
systemctl stop apache2
systemctl disable apache2
systemctl stop mariadb
systemctl disable mariadb

# Remove all databases except for essential system databases
mysql -e "DROP DATABASE IF EXISTS information_schema;" # Do not remove system databases
mysql -e "DROP DATABASE IF EXISTS mysql;"
mysql -e "DROP DATABASE IF EXISTS performance_schema;"
mysql -e "SHOW DATABASES;" | grep -v Database | grep -v mysql | grep -v information_schema | grep -v performance_schema | gawk '{print "DROP DATABASE IF EXISTS `" $1 "`;"}' | mysql

# Remove Apache2, MariaDB, PHP, and other installed packages
apt remove --purge -y apache2 mariadb-server php libapache2-mod-php php-mysql

# Remove WordPress files
rm -rf /var/www/html/*

echo "WordPress and all related components have been successfully uninstalled."
