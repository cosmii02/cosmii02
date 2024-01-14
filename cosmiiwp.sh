#!/bin/bash

# Update packages and install necessary dependencies
sudo apt update
sudo apt install -y nginx mariadb-server php php-fpm php-mysql whiptail

# Enable and start Nginx and MariaDB services
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl enable mariadb
sudo systemctl start mariadb

# Create the WordPress database and user
db_name=$(whiptail --inputbox "Enter the WordPress database name:" 8 40 3>&1 1>&2 2>&3)
db_user=$(whiptail --inputbox "Enter the WordPress database user:" 8 40 3>&1 1>&2 2>&3)
db_pass=$(whiptail --passwordbox "Enter the WordPress database user's password:" 8 40 3>&1 1>&2 2>&3)

sudo mysql -e "CREATE DATABASE ${db_name};"
sudo mysql -e "CREATE USER '${db_user}'@'localhost' IDENTIFIED BY '${db_pass}';"
sudo mysql -e "GRANT ALL PRIVILEGES ON ${db_name}.* TO '${db_user}'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Download and extract WordPress
wget https://wordpress.org/latest.tar.gz
tar xzf latest.tar.gz
sudo cp -R wordpress/* /var/www/html/

# Set up Nginx configuration
domain_name=$(whiptail --inputbox "Enter your domain name (e.g., example.com):" 8 60 3>&1 1>&2 2>&3)

sudo tee /etc/nginx/sites-available/wordpress <<EOL
server {
    listen 80;
    root /var/www/html;
    index index.php index.html index.htm;
    server_name ${domain_name};

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOL

# Enable the Nginx site configuration
sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx

# Set up WordPress configuration
sudo chown -R www-data:www-data /var/www/html
sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sudo sed -i "s/database_name_here/${db_name}/g" /var/www/html/wp-config.php
sudo sed -i "s/username_here/${db_user}/g" /var/www/html/wp-config.php
sudo sed -i "s/password_here/${db_pass}/g" /var/www/html/wp-config.php

whiptail --msgbox "WordPress installation complete. Please visit http://${domain_name}/wp-admin to complete the setup." 8 60
