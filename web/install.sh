#!/bin/bash
# install.sh - täisautomaatselt server ülesseadmiseks

set -e  # Katkesta kohe kui mingi käsk feilib
cd "$(dirname "$0")"  # Mine skripti asukohta

echo "Installing Apache web server..."

# Uuenda paketid ja paigalda Apache
sudo apt update
sudo apt install -y apache2

# Kopeeri oma kohandatud Apache konf
echo "Copying custom apache2.conf..."
sudo cp apache2.conf /etc/apache2/apache2.conf

# Muuda Apache DocumentRoot ja õigused - valikuline 
echo "Setting DocumentRoot to /home/ssilvet/infra-configs/web"

# Lisa õiged õigused failidele
sudo chmod -R 755 /home/ssilvet/infra-configs/web

# Lisa Apache VirtualHost konfiguratsiooni <Directory> blokk õigesti
echo "Setting up Apache VirtualHost..."

sudo bash -c 'cat > /etc/apache2/sites-available/000-default.conf <<EOF
<VirtualHost *:80>
    DocumentRoot /home/ssilvet/infra-configs/web

    <Directory /home/ssilvet/infra-configs/web>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>
</VirtualHost>
EOF'

# Kontrolli Apache konfiguratsiooni
sudo apache2ctl configtest

# Lae Apache seadistus uuesti
echo "Reloading Apache service..."
sudo systemctl reload apache2
sudo systemctl enable apache2

echo "✅ Apache server installed and configured from GitHub repo!"
