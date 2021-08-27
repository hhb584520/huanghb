#!/bin/bash

set -ex
mip=`ip a | grep 'inet' | grep '10.239' | awk '{print $ 2}' | awk -F '/' '{print $1}'`
sed -i "s/host_ip/${mip}/" kubeadm-config.yaml
kubeadm init --config=kubeadm-config.yaml --upload-certs | tee kubeadm-init.log
mkdir ~/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f ./kube-flannel.yaml
