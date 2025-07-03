#!/bin/bash

# === Configuration ===
NEXTCLOUD_DB="nextcloud"
NEXTCLOUD_USER="nextclouduser"
NEXTCLOUD_PASS="CHANGEME123"  # Change this to a strong password
NEXTCLOUD_VERSION="27.1.6"
DOMAIN_NAME="DOMAIN_NAME"  # Change this to your domain or IP

# === Safety Check for Required Variables ===
if [[ -z "$NEXTCLOUD_DB" || -z "$NEXTCLOUD_USER" || -z "$NEXTCLOUD_PASS" ]]; then
  echo "❌ One or more required variables are empty. Aborting."
  exit 1
fi

echo "✅ Using Database: $NEXTCLOUD_DB"
echo "✅ Using User: $NEXTCLOUD_USER"
echo "✅ Using Domain: $DOMAIN_NAME"
sleep 2

# === APT Lock Wait ===
while sudo fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1; do
   echo "⏳ Waiting for APT lock..."
   sleep 3
done

# === Update and Install Required Packages ===
echo "📦 Updating system and installing dependencies..."
sudo apt update && sudo apt upgrade -y
sudo apt install apache2 mariadb-server unzip wget curl -y
sudo apt install php php-mysql libapache2-mod-php php-xml php-curl php-zip php-gd \
php-mbstring php-bcmath php-intl php-imagick php-cli php-soap -y

# === Secure MariaDB (skip password set) ===
echo "🔒 Securing MariaDB..."
sudo mysql -u root <<EOF
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
EOF

# === Create Nextcloud Database and User ===
echo "🗃️ Creating Nextcloud DB and user..."
sudo mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS ${NEXTCLOUD_DB};
CREATE USER IF NOT EXISTS '${NEXTCLOUD_USER}'@'localhost' IDENTIFIED BY '${NEXTCLOUD_PASS}';
GRANT ALL PRIVILEGES ON ${NEXTCLOUD_DB}.* TO '${NEXTCLOUD_USER}'@'localhost';
FLUSH PRIVILEGES;
EOF

# === Download and Set Up Nextcloud ===
echo "⬇️ Downloading Nextcloud v${NEXTCLOUD_VERSION}..."
cd /tmp
wget -q https://download.nextcloud.com/server/releases/nextcloud-${NEXTCLOUD_VERSION}.zip

if [[ ! -f nextcloud-${NEXTCLOUD_VERSION}.zip ]]; then
  echo "❌ Download failed! Version may not exist."
  exit 1
fi

unzip nextcloud-${NEXTCLOUD_VERSION}.zip
sudo mv nextcloud /var/www/
sudo chown -R www-data:www-data /var/www/nextcloud
sudo chmod -R 755 /var/www/nextcloud

# === Apache Config ===
echo "⚙️ Configuring Apache..."
sudo tee /etc/apache2/sites-available/nextcloud.conf > /dev/null <<EOL
<VirtualHost *:80>
    ServerAdmin admin@${DOMAIN_NAME}
    DocumentRoot /var/www/nextcloud
    ServerName ${DOMAIN_NAME}

    <Directory /var/www/nextcloud/>
        Options +FollowSymlinks
        AllowOverride All
        Require all granted
        <IfModule mod_dav.c>
            Dav off
        </IfModule>
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/nextcloud_error.log
    CustomLog \${APACHE_LOG_DIR}/nextcloud_access.log combined
</VirtualHost>
EOL

sudo a2ensite nextcloud.conf
sudo a2enmod rewrite headers env dir mime setenvif ssl
sudo systemctl reload apache2

# === Optional HTTPS via Let's Encrypt ===
# Uncomment below to enable HTTPS using certbot
# echo "🔐 Setting up Let's Encrypt SSL..."
# sudo apt install certbot python3-certbot-apache -y
# sudo certbot --apache -d ${DOMAIN_NAME} --non-interactive --agree-tos -m admin@${DOMAIN_NAME}

# === Done ===
echo ""
echo "✅ Nextcloud installation complete!"
echo "🌐 Visit: http://${DOMAIN_NAME} to finish setup."
echo "🧠 DB Info:"
echo "   DB Name:     ${NEXTCLOUD_DB}"
echo "   DB User:     ${NEXTCLOUD_USER}"
echo "   DB Password: ${NEXTCLOUD_PASS}"
echo ""
