#!/bin/bash

# Remove the directory for the primary IB-L8 code to live
rm -r /var/ibl8

# Remove the devices database
rm create.sql
rm devices.sql 
# Install the code that updates the firewall
sudo wget -q ${REPO}ibl8.py

# Create the log file
sudo touch ibl8.log

# Set owner, group, and permissions of files in /var/ibl8
sudo chown www-data *.*
sudo chgrp www-data *.*
sudo chmod 755 *.*

#update cron to execute the script every minute
cd /etc/cron.d
sudo wget -q ${REPO}ibl8cron

#install apache2 and configure it to allow cgi
sudo apt install apache2 -y
sudo a2enmod cgid
sudo service apache2 restart

# Remove cgi scripts into the cgi directory
rm -r /usr/lib/cgi-bin


#log permissions and rotation configuration
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

#copy default web pages
cd /var/www/html
sudo rm index.html
sudo wget -q ${REPO}index.html
sudo wget -q ${REPO}logo.svg
sudo wget -q ${REPO}style.css
sudo wget -q ${REPO}favicon.ico
sudo touch macs.txt
sudo touch rsa.csv
sudo chown www-data *.*
sudo chgrp www-data *.*
sudo chmod 755 *.*

cd /var
sudo mkdir autoback
sudo chown www-data autoback
sudo chgrp www-data autoback
cd /var/autoback
sudo wget -q ${REPO}autoback.py
sudo chown www-data *.*
sudo chgrp www-data *.*
sudo chmod 755 *.*

#harden the Raspberry Pi
sudo systemctl disable avahi-daemon
sudo systemctl stop avahi-daemon
sudo systemctl disable triggerhappy
sudo systemctl stop triggerhappy

#harden Apache
cd /etc/apache2/conf-available
sudo rm -y security.conf
sudo wget -q ${REPO}security.conf
sudo systemctl restart apache2
