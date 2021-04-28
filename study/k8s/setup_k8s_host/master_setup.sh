#!/bin/bash

set -ex

sudo kubeadm init --apiserver-advertise-address=10.239.241.52  --service-cidr=10.96.0.0/16 --pod-network-cidr=10.244.0.0/16 --token 8c5adc.1cec8dbf339093f0
mkdir ~/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f /vagrant/kube-flannel.yml
