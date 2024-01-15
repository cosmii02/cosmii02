#!/bin/bash

# Check if the -d flag is provided
USE_DOCKER_DEFAULTS=false
while getopts "d" opt; do
  case $opt in
    d)
      USE_DOCKER_DEFAULTS=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

# Update packages and install necessary dependencies
sudo apt update
sudo apt install -y apache2 mariadb-server php libapache2-mod-php php-mysql whiptail

# Enable and start Apache2 and MariaDB services
sudo systemctl enable apache2
sudo systemctl start apache2
sudo systemctl enable mariadb
sudo systemctl start mariadb

# Set default values for docker or ask for user input
if [ "$USE_DOCKER_DEFAULTS" = true ] ; then
    db_name="docker"
    db_user="docker"
    db_pass="docker"
else
    db_name=$(whiptail --inputbox "Enter the WordPress database name:" 8 40 3>&1 1>&2 2>&3)
    db_user=$(whiptail --inputbox "Enter the WordPress database user:" 8 40 3>&1 1>&2 2>&3)
    db_pass=$(whiptail --passwordbox "Enter the WordPress database user's password:" 8 40 3>&1 1>&2 2>&3)
fi

sudo mysql -e "CREATE DATABASE ${db_name};"
sudo mysql -e "CREATE USER '${db_user}'@'localhost' IDENTIFIED BY '${db_pass}';"
sudo mysql -e "GRANT ALL PRIVILEGES ON ${db_name}.* TO '${db_user}'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Download and extract WordPress
wget https://wordpress.org/latest.tar.gz
tar xzf latest.tar.gz
sudo cp -R wordpress/* /var/www/html/

# Set up Apache2 configuration
domain_name=$(whiptail --inputbox "Enter your domain name (e.g., example.com):" 8 60 3>&1 1>&2 2>&3)

# Enable mod_rewrite for URL rewriting
sudo a2enmod rewrite
sudo systemctl restart apache2

# Configure Apache2 VirtualHost
sudo tee /etc/apache2/sites-available/wordpress.conf <<EOL
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html
    ServerName ${domain_name}
    ServerAlias www.${domain_name}

    <Directory /var/www/html/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOL

# Enable the Apache2 site configuration
sudo a2ensite wordpress.conf
sudo systemctl reload apache2

# Set up WordPress configuration
sudo chown -R www-data:www-data /var/www/html
sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sudo sed -i "s/database_name_here/${db_name}/g" /var/www/html/wp-config.php
sudo sed -i "s/username_here/${db_user}/g" /var/www/html/wp-config.php
sudo sed -i "s/password_here/${db_pass}/g" /var/www/html/wp-config.php

whiptail --msgbox "WordPress installation complete. Please visit http://${domain_name}/wp-admin to complete the setup." 8 60
