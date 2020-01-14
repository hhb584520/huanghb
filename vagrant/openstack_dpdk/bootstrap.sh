#!/usr/bin/env bash

set -ex

sudo apt-get update -y
sudo apt-get install git -y
sudo apt-get install python-pip -y
sudo -H pip install --upgrade pip
mkdir -p ~/.pip
cp /vagrant/pip.conf ~/.pip/
sudo cp /vagrant/pip.conf /etc/pip.conf
git clone http://git.openstack.org/openstack-dev/devstack 
cd devstack; git checkout stable/ocata
patch -p1 < /vagrant/vhost.diff
