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
ANIMATION_PID=$!

# Rest of the script using the execute function...
execute sudo apt update
execute sudo apt install -y nginx mariadb-server php-fpm php-mysql dovecot-core dovecot-imapd dovecot-pop3d postfix whiptail

# Enable and start Nginx, MariaDB, Dovecot, and Postfix services
execute sudo systemctl enable nginx mariadb dovecot postfix
execute sudo systemctl start nginx mariadb dovecot postfix

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

# Nginx configuration for Roundcube
execute sudo tee /etc/nginx/sites-available/roundcube <<EOL
server {
    listen 80;
    server_name ${mail_domain};

    root /var/www/roundcube;
    index index.php;

    location / {
        try_files \$uri \$uri/ /index.php;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }
}
EOL

# Enable the Nginx site and reload the service
execute sudo ln -s /etc/nginx/sites-available/roundcube /etc/nginx/sites-enabled/
execute sudo nginx -t
execute sudo systemctl reload nginx

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
