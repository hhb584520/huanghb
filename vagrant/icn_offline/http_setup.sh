#!/bin/bash

set -ex

sudo apt update
sudo apt-get install apache2 -y
sudo ufw app list
sudo ufw status
sudo ufw allow 'Apache'
sudo ufw status
sudo ufw app list
sudo systemctl status apache2
sudo mkdir /var/www/icn
sudo chown -R vagrant:vagrant /var/www/icn
sudo chmod -R 755 /var/www/icn
sudo cp /vagrant/icn.conf /etc/apache2/sites-available/icn.conf
sudo cp -rf /vagrant/files/  /var/www/icn/
sudo cp /vagrant/index.html /var/www/icn/index.html
sudo a2ensite icn.conf
sudo a2dissite 000-default.conf
apache2ctl configtest
sudo systemctl restart apache2
wget http://192.168.1.10/files/yui.tar.gz
