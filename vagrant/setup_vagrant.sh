#!/bin/sh

wget https://raw.githubusercontent.com/opnfv/container4nfv/master/src/vagrant/setup_vagrant.sh -O setup.sh
bash ./setup.sh
rm -rf ./setup.sh
