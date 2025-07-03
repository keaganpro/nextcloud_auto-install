
# 🚀 Nextcloud Auto Installer Script for Ubuntu 22.04

This script automates the installation of a full-featured Nextcloud server on a clean Ubuntu 22.04 VPS. It sets up Apache, MariaDB, PHP, and downloads the latest stable version of Nextcloud. Great for quick deployments on self-hosted infrastructure.

---

## 📦 What It Installs

- Apache 2 web server
- MariaDB server + Nextcloud database/user
- PHP 8.1 + all required extensions
- Nextcloud (v27.1.6 by default)
- Optional Let's Encrypt SSL (easily enabled)

---

## 🔧 Prerequisites

- Ubuntu 22.04 LTS VPS (root access)
- A domain name pointing to your server (e.g. `your.domain.com`)
- Ports 80 and 443 open

---

## 🚀 How to Use

### 1. Clone the Repo or Download the Script

```bash
git clone https://github.com/keaganpro/nextcloud_auto-install
cd nextcloud-autoinstall
```

Or download directly:

```bash
wget https://raw.githubusercontent.com/yourusername/nextcloud-autoinstall/main/install_nextcloud.sh
```

### 2. (Optional) Fix Line Endings (if copied from Windows)

```bash
sudo apt install dos2unix -y
dos2unix install_nextcloud.sh
```

### 3. Edit Configuration (Optional)

Open the script in a text editor and edit these variables at the top:

```bash
NEXTCLOUD_DB="nextcloud"
NEXTCLOUD_USER="nextclouduser"
NEXTCLOUD_PASS="CHANGEME123!"
NEXTCLOUD_VERSION="27.1.6"
DOMAIN_NAME="DOMAIN_NAME"
```

### 4. Run the Script

```bash
chmod +x install_nextcloud.sh
sudo ./install_nextcloud.sh
```

---

## 🌐 After Installation

Visit `http://your.domain.com` in your browser and complete the Nextcloud setup.

Use the printed database credentials from the script output:
- **Database name**
- **User**
- **Password**

---

## 🔐 Optional: Enable HTTPS

To enable HTTPS with Let's Encrypt, uncomment the Certbot section in the script:

```bash
# sudo apt install certbot python3-certbot-apache -y
# sudo certbot --apache -d ${DOMAIN_NAME} --non-interactive --agree-tos -m admin@${DOMAIN_NAME}
```

Then run the script again, or run Certbot separately afterward.

---

## 🧼 Cleanup

You can delete the downloaded archive and script after install:

```bash
rm /tmp/nextcloud-*.zip
rm install_nextcloud.sh
```

---

## 📄 License

MIT License. Feel free to use, fork, and improve.

---

## 🙌 Credits

Created by Keagan (WarDaddy) – inspired by countless hours of manual installs 😅

# 🚀 Nextcloud Auto Installer Script for Ubuntu 22.04

This script automates the installation of a full-featured Nextcloud server on a clean Ubuntu 22.04 VPS. It sets up Apache, MariaDB, PHP, and downloads the latest stable version of Nextcloud. Great for quick deployments on self-hosted infrastructure.

---

## 📦 What It Installs

- Apache 2 web server
- MariaDB server + Nextcloud database/user
- PHP 8.1 + all required extensions
- Nextcloud (v27.1.6 by default)
- Optional Let's Encrypt SSL (easily enabled)

---

## 🔧 Prerequisites

- Ubuntu 22.04 LTS VPS (root access)
- A domain name pointing to your server (e.g. `your.domain.com`)
- Ports 80 and 443 open

---

## 🚀 How to Use

### 1. Clone the Repo or Download the Script

```bash
git clone https://github.com/keaganpro/nextcloud_auto-install
cd nextcloud-autoinstall
```

Or download directly:

```bash
wget https://raw.githubusercontent.com/yourusername/nextcloud-autoinstall/main/install_nextcloud.sh
```

### 2. (Optional) Fix Line Endings (if copied from Windows)

```bash
sudo apt install dos2unix -y
dos2unix install_nextcloud.sh
```

### 3. Edit Configuration (Optional)

Open the script in a text editor and edit these variables at the top:

```bash
NEXTCLOUD_DB="nextcloud"
NEXTCLOUD_USER="nextclouduser"
NEXTCLOUD_PASS="CHANGEME123!"
NEXTCLOUD_VERSION="27.1.6"
DOMAIN_NAME="DOMAIN_NAME"
```

### 4. Run the Script

```bash
chmod +x install_nextcloud.sh
sudo ./install_nextcloud.sh
```

---

## 🌐 After Installation

Visit `http://your.domain.com` in your browser and complete the Nextcloud setup.

Use the printed database credentials from the script output:
- **Database name**
- **User**
- **Password**

---

## 🔐 Optional: Enable HTTPS

To enable HTTPS with Let's Encrypt, uncomment the Certbot section in the script:

```bash
# sudo apt install certbot python3-certbot-apache -y
# sudo certbot --apache -d ${DOMAIN_NAME} --non-interactive --agree-tos -m admin@${DOMAIN_NAME}
```

Then run the script again, or run Certbot separately afterward.

---

## 🧼 Cleanup

You can delete the downloaded archive and script after install:

```bash
rm /tmp/nextcloud-*.zip
rm install_nextcloud.sh
```

---

## 📄 License

MIT License. Feel free to use, fork, and improve.

---

## 🙌 Credits

Created by Keagan (WarDaddy) – inspired by countless hours of manual installs 😅
