#!/bin/bash
# install.sh

echo "Installing Apache web server..."

# Uuenda pakette ja paigalda Apache
sudo apt update
sudo apt install -y apache2

# Kopeeri oma kohandatud konfiguratsioon
sudo cp apache2.conf /etc/apache2/apache2.conf

# Pane test HTML üles
sudo cp index.html /var/www/html/index.html

# Taaskäivita Apache teenus
sudo systemctl restart apache2

echo "Apache server installitud ja seadistatud!"
