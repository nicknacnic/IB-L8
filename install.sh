#!/bin/bash

#check to make sure Python is installed
python --version

#install the python requests module
sudo apt-get install python-requests -y

#install sqlite3
sudo apt-get install sqlite3 -y

#set some necessary permissions
cd /var
sudo mkdir dug
sudo chown www-data dug
sudo chgrp www-data dug
cd /var/dug

#create the devices database
echo 'CREATE TABLE DevicesDynamic (DeviceName "TEXT", DeviceMac "TEXT", Groups "Text");' > create.sql
sqlite3 devices.sql < create.sql
rm create.sql
chmod 777 devices.sql

#install the code that updates the firewall
wget https://raw.githubusercontent.com/p0lr/PAN_DUG/master/dug.py
sudo chusr www-data dug.py
sudo chgrp www-data dug.py
sudo chmod 755 dug.py

#update cron to execute the script every minute
cd /etc/cron.d
sudo wget https://raw.githubusercontent.com/p0lr/PAN_DUG/master/pan_dhcp_cron

#install apache2 and configure it to allow cgi
sudo apt-get install apache2 -y
sudo a2enmod cgid
sudo service apache2 restart

#copy cgi scripts into the cgi directory
cd /usr/lib/cgi-bin
sudo wget https://raw.githubusercontent.com/p0lr/PAN_DUG/master/index.cgi
sudo chusr www-data index.cgi
sudi chgrp www-data index.cgi
sudo chmod 755 index.cgi
sudo wget https://raw.githubusercontent.com/p0lr/PAN_DUG/master/keygen.cgi
sudo chusr www-data keygen.cgi
sudo chgrp www-data keygen.cgi
sudo chmod 755 keygen.cgi

#copy default web page
cd /var/www/html
sudo rm index.html
sudo wget https://raw.githubusercontent.com/p0lr/PAN_DUG/master/index.html
sudo chusr www-data index.html
sudo chgrp www-data index.html
sudo chmod 755 index.html
sudo wget https://raw.githubusercontent.com/p0lr/PAN_DUG/master/dus.css
sudo chown www-data dus.css
sudo chgrp www-data dus.css
sudo chmod 755 dus.css
sudo wget https://raw.githubusercontent.com/p0lr/PAN_DUG/master/logo.svg
sudo chusr www-data logo.svg
sudo chgrp www-data logo.svg
sudo chmod 755 logo.svg
