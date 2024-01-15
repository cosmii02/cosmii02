#!/bin/bash

# Initialize variables
USE_DOCKER_DEFAULTS=false
VERBOSE=false

# Check for flags
while getopts "dv" opt; do
  case $opt in
    d)
      USE_DOCKER_DEFAULTS=true
      ;;
    v)
      VERBOSE=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

# Function to execute a command and optionally print its output
execute() {
    if [ "$VERBOSE" = true ]; then
        "$@"
    else
        "$@" >/dev/null 2>&1
    fi
}

# Function for the animation
animate() {
    local cols=$(tput cols)
    local lines=$(tput lines)
    local symbols=(0 1)

    # Initialize the positions and colors arrays
    local positions=()
    local colors=()
    for ((i=1; i<=cols; i++)); do
        positions[$i]=$((RANDOM % lines))
        colors[$i]=$((RANDOM % 256))
    done

    while true; do
        if ! pgrep -x "whiptail" > /dev/null; then
            # Clear the screen without disrupting the rest of the interface
            printf "\033[H"

            for ((i=1; i<=cols; i++)); do
                # Randomly pick a symbol and color
                local symbol=${symbols[$RANDOM % ${#symbols[@]}]}
                local color=${colors[$i]}

                # Print the symbol at the current position with color
                local line=${positions[$i]}
                printf "\033[38;5;${color}m\033[${line};${i}H$symbol"

                # Update the position
                if (( line >= lines )); then
                    positions[$i]=0
                    colors[$i]=$((RANDOM % 256))  # Randomize color again
                else
                    positions[$i]=$((line + 1))
                fi
            done
            sleep 0.1  # Slow down the effect
        else
            sleep 1
        fi
    done
}

# Start the animation in the background
animate &

# Save the PID of the animation process
ANIMATION_PID=$!

# Rest of the script using the execute function...
execute sudo apt update
execute sudo apt install -y apache2 mariadb-server php libapache2-mod-php php-mysql whiptail

#Enable and start Apache2 and MariaDB services
execute sudo systemctl enable apache2
execute sudo systemctl start apache2
execute sudo systemctl enable mariadb
execute sudo systemctl start mariadb

#Set default values for docker or ask for user input
if [ "$USE_DOCKER_DEFAULTS" = true ] ; then
db_name="docker"
db_user="docker"
db_pass="docker"
else
db_name=$(whiptail --inputbox "Enter the WordPress database name:" 8 40 3>&1 1>&2 2>&3)
db_user=$(whiptail --inputbox "Enter the WordPress database user:" 8 40 3>&1 1>&2 2>&3)
db_pass=$(whiptail --passwordbox "Enter the WordPress database user's password:" 8 40 3>&1 1>&2 2>&3)
fi

execute sudo mysql -e "CREATE DATABASE ${db_name};"
execute sudo mysql -e "CREATE USER '${db_user}'@'localhost' IDENTIFIED BY '${db_pass}';"
execute sudo mysql -e "GRANT ALL PRIVILEGES ON ${db_name}.* TO '${db_user}'@'localhost';"
execute sudo mysql -e "FLUSH PRIVILEGES;"

#Download and extract WordPress
execute wget https://wordpress.org/latest.tar.gz
execute tar xzf latest.tar.gz
execute sudo cp -R wordpress/* /var/www/html/

#Set up Apache2 configuration
domain_name=$(whiptail --inputbox "Enter your domain name (e.g., example.com):" 8 60 3>&1 1>&2 2>&3)

#Enable mod_rewrite for URL rewriting
execute sudo a2enmod rewrite
execute sudo systemctl restart apache2

#Configure Apache2 VirtualHost
execute sudo tee /etc/apache2/sites-available/wordpress.conf <<EOL
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

#Enable the Apache2 site configuration
execute sudo a2ensite wordpress.conf
execute sudo systemctl reload apache2

#Set up WordPress configuration
execute sudo chown -R www-data:www-data /var/www/html
execute sudo cp /var/www

/html/wp-config-sample.php /var/www/html/wp-config.php
execute sudo sed -i "s/database_name_here/${db_name}/g" /var/www/html/wp-config.php
execute sudo sed -i "s/username_here/${db_user}/g" /var/www/html/wp-config.php
execute sudo sed -i "s/password_here/${db_pass}/g" /var/www/html/wp-config.php

#Final message and URL
if [ "$VERBOSE" = true ]; then
whiptail --msgbox "WordPress installation complete. Please visit http://${domain_name}/wp-admin to complete the setup." 8 60
fi

#Stop the animation before exiting
kill $ANIMATION_PID

# Clear the screen to remove any remaining parts of the animation
clear

# Print the final success message and WordPress admin URL
echo -e "\n\033[1;34mWordPress successfully installed \033[1;95mnyaa <3\033[0m"
echo -e "\033[1;32mPlease visit: http://${domain_name}/wp-admin\033[0m"

# End of the script
