#!/bin/bash

set -ex

sudo systemctl stop systemd-resolved
cat << EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
EOF

cat << EOF | sudo tee /etc/hosts
127.0.0.1    localhost
192.168.1.10 http
192.168.1.20 kud
192.168.1.30 compute
EOF

sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce

sudo swapoff -a
