#!/bin/bash

# Skript interaktiivseks andmebaasi seadistamiseks, LAMP stacki paigaldamiseks,
# Wordpressi paigaldamiseks ja veebiserveri seadistamiseks

# Küsime kasutajalt andmebaasi seadistamiseks vajalikud parameetrid
read -p "Sisestage andmebaasi nimi: " dbname
read -p "Sisestage andmebaasi kasutajanimi: " dbuser
read -s -p "Sisestage andmebaasi parool: " dbpass
echo

# Küsime kasutajalt kausta nime, kuhu Wordpressi failid paigutatakse
read -p "Sisestage kausta nimi, kuhu Wordpressi failid paigutatakse: " wpdir

# Paigaldame LAMP stacki
echo "Paigaldame LAMP stacki..."
sudo apt update
sudo apt install apache2 mysql-server php libapache2-mod-php php-mysql -y

# Seadistame andmebaasi Wordpressi jaoks
echo "Seadistame andmebaasi..."
mysql -u root << EOF
CREATE DATABASE $dbname;
CREATE USER '$dbuser'@'localhost' IDENTIFIED BY '$dbpass';
GRANT ALL PRIVILEGES ON $dbname.* TO '$dbuser'@'localhost';
FLUSH PRIVILEGES;
EOF

# Laeme alla ja paigaldame Wordpressi
echo "Laeme alla ja paigaldame Wordpressi..."
sudo wget -P /var/www/html https://wordpress.org/latest.tar.gz
sudo tar -xzf /var/www/html/latest.tar.gz -C /var/www/html/
sudo chown -R www-data:www-data /var/www/html/wordpress
sudo chmod -R 755 /var/www/html/wordpress

# Seadistame veebiserveri seadistusfaili
echo "Seadistame veebiserveri seadistusfaili..."
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/wordpress.conf
sudo sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/wordpress|g' /etc/apache2/sites-available/wordpress.conf
sudo sed -i 's|<Directory /var/www/html>|<Directory /var/www/html/wordpress>|g' /etc/apache2/sites-available/wordpress.conf
sudo a2dissite 000-default.conf
sudo a2ensite wordpress.conf
sudo systemctl reload apache2

# Avame Wordpressi veebilehe
echo "Avame Wordpressi veebilehe aadressilt http://localhost"
xdg-open http://localhost

# Skript lõpetab töö
echo "Skript on lõpetanud töö!"
