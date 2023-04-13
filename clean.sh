#!/bin/bash

# Stop the autoback service
sudo systemctl stop autoback.service
sudo systemctl disable autoback.service

# Remove the autoback directory and its contents
sudo rm -rf /var/autoback

# Remove the ibl8 directory and its contents
sudo rm -rf /var/ibl8

# Remove the apache2 web server and its dependencies
sudo apt purge apache2 -y
sudo apt autoremove -y

# Remove the cron job
sudo rm -f /etc/cron.d/ibl8cron

# Remove the log files and configuration files
sudo rm -f /var/log/apache2/access.log
sudo rm -f /var/log/apache2/error.log
sudo rm -rf /var/log/apache2
sudo rm -f /var/log/syslog
sudo rm -f /var/log/messages
sudo rm -f /etc/rsyslog.conf
sudo rm -f /etc/logrotate.d/apache2
sudo rm -f /etc/logrotate.conf

# Remove the cgi scripts and web pages
sudo rm -rf /usr/lib/cgi-bin
sudo rm -rf /var/www/html

# Remove the security configuration for Apache
sudo rm -f /etc/apache2/conf-available/security.conf

# Reload the system daemons to apply the changes
sudo systemctl daemon-reload
