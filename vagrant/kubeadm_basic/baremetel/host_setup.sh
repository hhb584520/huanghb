#!/bin/bash

set -ex

sudo systemctl stop systemd-resolved
cat << EOF | sudo tee /etc/resolv.conf
nameserver 10.248.2.1
search sh.intel.com
EOF

cat << EOF | sudo tee /etc/hosts
127.0.0.1    localhost
192.168.1.10 master
192.168.1.21 worker1
192.168.1.22 worker2
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

curl -s http://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

sh ./configure_docker_proxy.sh

sudo apt-get update
sudo apt-get install -y --allow-unauthenticated kubelet=1.21.1-00 kubeadm=1.21.1-00 kubectl=1.21.1-00 kubernetes-cni=0.8.7-00

sudo modprobe ip_vs
sudo modprobe ip_vs_rr
sudo modprobe ip_vs_wrr
sudo modprobe ip_vs_sh
sudo swapoff -a
sudo systemctl daemon-reload
sudo systemctl stop kubelet
sudo systemctl start kubelet
