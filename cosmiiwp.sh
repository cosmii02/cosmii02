#!/bin/bash

# Update packages and install necessary dependencies
sudo apt update
sudo apt install -y nginx mariadb-server php8.1-fpm php8.1-mysql dialog

# Enable and start Nginx and MariaDB services
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl enable mariadb
sudo systemctl start mariadb

# Dialog colors and appearance
export DIALOGOPTS="--colors --backtitle \"WordPress Setup\" --title \"WordPress Setup Wizard\""

# Create the WordPress database and user
db_name=$(dialog --stdout --inputbox "\Zb\Z0Enter the \Zb\Z1WordPress database name\Zn:" 8 40)
db_user=$(dialog --stdout --inputbox "\Zb\Z0Enter the \Zb\Z1WordPress database user\Zn:" 8 40)
db_pass=$(dialog --stdout --insecure --passwordbox "\Zb\Z0Enter the \Zb\Z1WordPress database user's password\Zn:" 8 40)

sudo mysql -e "CREATE DATABASE ${db_name};"
sudo mysql -e "CREATE USER '${db_user}'@'localhost' IDENTIFIED BY '${db_pass}';"
sudo mysql -e "GRANT ALL PRIVILEGES ON ${db_name}.* TO '${db_user}'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Download and extract WordPress
wget https://wordpress.org/latest.tar.gz
tar xzf latest.tar.gz
sudo cp -R wordpress/* /var/www/html/

# Set up Nginx configuration
domain_name=$(dialog --stdout --inputbox "\Zb\Z0Enter your \Zb\Z1domain name\Zn (e.g., example.com):" 8 60)

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

dialog --msgbox "\Zb\Z0WordPress installation complete. Please visit \Zb\Z1http://${domain_name}/wp-admin\Zn to complete the setup." 8 60
