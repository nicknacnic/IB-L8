#!/bin/bash

#Tell the installer the root of the files to download
REPO="https://raw.githubusercontent.com/p0lr/PAN_DUG/master/"

#check to make sure Python is installed
python --version

#install the python requests module
sudo apt-get install python-requests -y

#install sqlite3
sudo apt-get install sqlite3 -y

#create the directory for the primary dug code to live
cd /var
sudo mkdir dug
sudo chown www-data dug
sudo chgrp www-data dug
cd /var/dug
#create the devices database
sudo touch create.sql
sudo chmod 777 create.sql
sudo echo 'CREATE TABLE DevicesDynamic (DeviceName "TEXT", DeviceMac "TEXT", Groups "Text");' > create.sql
sudo sqlite3 devices.sql < create.sql
sudo rm create.sql
#install the code that updates the firewall
sudo wget -q ${REPO}dug.py
#create the log file
sudo touch dug.log
#Set owner, group, and permissions of files in /var/dug
sudo chown www-data *.*
sudo chgrp www-data *.*
sudo chmod 755 *.*

#update cron to execute the script every minute
cd /etc/cron.d
sudo wget -q ${REPO}dug.cron

#install apache2 and configure it to allow cgi
sudo apt-get install apache2 -y
sudo a2enmod cgid
sudo service apache2 restart

#copy cgi scripts into the cgi directory
cd /usr/lib/cgi-bin
sudo wget -q ${REPO}index.cgi
sudo wget -q ${REPO}keygen.cgi
sudo wget -q ${REPO}vlan.cgi
sudo wget -q ${REPO}usermap.cgi
sudo wget -q ${REPO}groupmap.cgi
sudo wget -q ${REPO}arp.cgi
sudo wget -q ${REPO}dhcp.cgi
sudo wget -q ${REPO}policy.cgi
sudo wget -q ${REPO}duglog.cgi
sudo wget -q ${REPO}menu.html
sudo chown www-data *.*
sudo chgrp www-data *.*
sudo chmod 755 *.*

#copy default web pages
cd /var/www/html
sudo rm index.html
sudo wget -q ${REPO}index.html
sudo wget -q ${REPO}logo.svg
sudo wget -q ${REPO}style.css
sudo touch macs.txt
sudo touch rsa.csv
sudo chown www-data *.*
sudo chgrp www-data *.*
sudo chmod 755 *.*
