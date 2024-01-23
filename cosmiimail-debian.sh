#!/bin/bash

# Initialize variables
USE_DOCKER_DEFAULTS=false
VERBOSE=false
ROUND_CUBE_VERSION="1.5.2"  # Use the latest stable version of Roundcube

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
    # ... (same as in the provided script)
}

# Start the animation in the background
animate &
ANIMATION_PID=$!

# Rest of the script using the execute function...
execute sudo apt update
execute sudo apt install -y apache2 mariadb-server php php-mysql libapache2-mod-php dovecot-core dovecot-imapd dovecot-pop3d postfix whiptail

# Enable and start Apache2, MariaDB, Dovecot, and Postfix services
execute sudo systemctl enable apache2 mariadb dovecot postfix
execute sudo systemctl start apache2 mariadb dovecot postfix

# Ask user for domain and mail domain
domain_name=$(whiptail --inputbox "Enter your domain name (e.g., example.com):" 8 60 3>&1 1>&2 2>&3)
mail_domain=$(whiptail --inputbox "Enter your mail domain (e.g., mail.example.com):" 8 60 3>&1 1>&2 2>&3)

# Postfix configuration
execute sudo postconf -e "myhostname = $mail_domain"
execute sudo postconf -e "mydestination = $mail_domain, localhost.localdomain, localhost"
execute sudo postconf -e "mynetworks = 127.0.0.0/8 [::1]/128"
execute sudo postconf -e "home_mailbox = Maildir/"

# Dovecot configuration
execute sudo bash -c "echo 'mail_location = maildir:~/Maildir' >> /etc/dovecot/conf.d/10-mail.conf"
execute sudo systemctl restart dovecot

# Set up Roundcube
execute wget https://github.com/roundcube/roundcubemail/releases/download/${ROUND_CUBE_VERSION}/roundcubemail-${ROUND_CUBE_VERSION}-complete.tar.gz
execute tar xzf roundcubemail-${ROUND_CUBE_VERSION}-complete.tar.gz
execute sudo mv roundcubemail-${ROUND_CUBE_VERSION} /var/www/roundcube
execute sudo chown -R www-data:www-data /var/www/roundcube

# Apache configuration for Roundcube
execute sudo tee /etc/apache2/sites-available/roundcube.conf <<EOL
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/roundcube
    ServerName ${mail_domain}

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    <Directory /var/www/roundcube>
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    <IfModule mod_dir.c>
        DirectoryIndex index.php index.html
    </IfModule>
</VirtualHost>
EOL

# Enable the Apache2 site and reload the service
execute sudo a2ensite roundcube.conf
execute sudo systemctl reload apache2

# Final message and URL
if [ "$VERBOSE" = true ]; then
whiptail --msgbox "Mail server setup is complete. Please visit http://${mail_domain} to access Roundcube webmail." 8 60
fi

# Stop the animation before exiting
kill $ANIMATION_PID

# Clear the screen to remove any remaining parts of the animation
clear

# Print the final success message and Roundcube access URL
echo -e "\n\033[1;34mMail server successfully set up. \033[1;95mYay!\033[0m"
echo -e "\033[1;32mAccess Roundcube at: http://${mail_domain}\033[0m"

# End of the script
