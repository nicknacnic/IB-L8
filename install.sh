#!/bin/bash

# Tell the installer the root of the files to download
REPO="https://raw.githubusercontent.com/nicknacnic/IB-L8/master/"

:<<'COMMENT'
# Install the latest version of Python if it's not already installed
if ! command -v python3 &>/dev/null; then
    sudo apt update && sudo apt install -y python3
fi

# Install other dependencies
sudo apt install -y sqlite3 python3-pip
pip3 install xmldiff
pip3 install requests

# Create the directory for the primary IB-L8 code to live
cd /var
sudo mkdir ibl8
sudo chown www-data ibl8
sudo chgrp www-data ibl8
cd /var/ibl8

# Create the devices database
sudo touch create.sql
sudo chmod 777 create.sql
sudo echo 'CREATE TABLE DevicesDynamic (DeviceName "TEXT", DeviceMac "TEXT", Groups "Text");' > create.sql
sudo sqlite3 devices.sql < create.sql
sudo rm create.sql
COMMENT

# Install the code that updates the firewall
sudo wget -q ${REPO}ibl8.py

# Create the log file
sudo touch ibl8.log

# Set owner, group, and permissions of files in /var/ibl8
sudo find /var/ibl8 -exec chown www-data {} \;
sudo find /var/ibl8 -exec chgrp www-data {} \;
sudo find /var/ibl8 -type f -exec chmod 755 {} \;

# Update cron to execute the script every minute
cd /etc/cron.d
sudo wget -q ${REPO}ibl8cron

# Install apache2 and configure it to allow cgi
sudo apt install apache2 -y
sudo a2enmod cgid
sudo service apache2 restart

# Copy cgi scripts into the cgi directory
cd /usr/lib/cgi-bin
sudo wget -q ${REPO}index.cgi
sudo wget -q ${REPO}keygen.cgi
sudo wget -q ${REPO}vlan.cgi
sudo wget -q ${REPO}usermap.cgi
sudo wget -q ${REPO}groupmap.cgi
sudo wget -q ${REPO}clearusers.cgi
sudo wget -q ${REPO}arp.cgi
sudo wget -q ${REPO}dhcp.cgi
sudo wget -q ${REPO}dhcputil.cgi
sudo wget -q ${REPO}policy.cgi
sudo wget -q ${REPO}ibl8log.cgi
sudo wget -q ${REPO}syslog.cgi
sudo wget -q ${REPO}messageslog.cgi
sudo wget -q ${REPO}accesslog.cgi
sudo wget -q ${REPO}errorlog.cgi
sudo wget -q ${REPO}manback.cgi
sudo wget -q ${REPO}software.cgi
sudo wget -q ${REPO}changes.cgi
sudo wget -q ${REPO}menu.html
sudo find /usr/lib/cgi-bin -exec chown www-data {} \;
sudo find /usr/lib/cgi-bin -exec chgrp www-data {} \;
sudo find /usr/lib/cgi-bin -type f -exec chmod 755 {} \;


# Log permissions and rotation configuration
sudo chmod 644 /var/log/syslog
sudo chmod 644 /var/log/messages
cd /etc
sudo rm rsyslog.conf
sudo wget -q ${REPO}rsyslog.conf
sudo chown root rsyslog.conf
sudo chgrp root rsyslog.conf
sudo chmod 755 rsyslog.conf
sudo rm logrotate.conf
sudo wget -q ${REPO}logrotate.conf
sudo chown root logrotate.conf
sudo chgrp root logrotate.conf
sudo chmod 755 logrotate.conf

sudo chmod 755 /var/log/apache2
sudo chmod 644 /var/log/apache2/access.log
sudo chmod 644 /var/log/apache2/error.log
cd /etc/logrotate.d
sudo rm apache2
sudo wget -q ${REPO}apache2
sudo chown root apache2
sudo chgrp root apache2
sudo chmod 644 apache2

# Copy default web pages
cd /var/www/html
sudo rm index.html
sudo wget -q ${REPO}index.html
sudo wget -q ${REPO}logo.svg
sudo wget -q ${REPO}style.css
sudo wget -q ${REPO}favicon.ico
sudo touch macs.txt
sudo touch rsa.csv
sudo find /var/www/html -exec chown www-data {} \;
sudo find /var/www/html -exec chgrp www-data {} \;
sudo find /var/www/html -type f -exec chmod 755 {} \;

cd /var
sudo mkdir autoback
sudo chown www-data autoback
sudo chgrp www-data autoback
cd /var/autoback
sudo wget -q ${REPO}autoback.py
sudo find /var/autoback -exec chown www-data {} \;
sudo find /var/autoback -exec chgrp www-data {} \;
sudo find /var/autoback -type f -exec chmod 755 {} \;

# Harden the Raspberry Pi
sudo systemctl disable avahi-daemon
sudo systemctl stop avahi-daemon
sudo systemctl disable triggerhappy
sudo systemctl stop triggerhappy

# Harden Apache
cd /etc/apache2/conf-available
sudo rm -y security.conf
sudo wget -q ${REPO}security.conf
sudo systemctl restart apache2
