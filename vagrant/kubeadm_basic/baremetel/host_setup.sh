#!/bin/bash

# 1. comment swap vim /etc/fstab
# 2. clone ssh://sgx@10.239.36.138/home/sgx/githome/fuel
# 3. modify ip
# 4. date --set="Thu Aug 26 20:16:05 CST 2021"

set -ex
systemctl stop firewalld
systemctl disable firewalld

systemctl stop iptables
systemctl disable iptables

apt install selinux-utils -y

getenforce

swapoff -a

cat << EOF | sudo tee /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-iptables=1
net.bridge.bridge-nf-call-ip6tables=1
net.ipv4.ip_forward=1
net.ipv4.tcp_tw_recycle=0
net.ipv4.neigh.default.gc_thresh1=1024
net.ipv4.neigh.default.gc_thresh2=2048
net.ipv4.neigh.default.gc_thresh3=4096
vm.swappiness=0
vm.overcommit_memory=1
vm.panic_on_oom=0
fs.inotify.max_user_instances=8192
fs.inotify.max_user_watches=1048576
fs.file-max=52706963
fs.nr_open=52706963
net.ipv6.conf.all.disable_ipv6=1
net.netfilter.nf_conntrack_max=2310720
EOF

sysctl -p /etc/sysctl.d/kubernetes.conf

modprobe ip_vs
modprobe ip_vs_rr
modprobe ip_vs_wrr
modprobe ip_vs_sh
modprobe nf_conntrack
modprobe ip_tables
modprobe ip_set
modprobe xt_set
modprobe ipt_set
modprobe ipt_rpfilter
modprobe ipt_REJECT
modprobe ipip

sudo systemctl stop systemd-resolved
cat << EOF | sudo tee /etc/resolv.conf
nameserver 10.248.2.1
search sh.intel.com
EOF

cat << EOF | sudo tee /etc/hosts
127.0.0.1    localhost
10.239.*.* master
10.239.*.* worker1
10.239.*.* worker2
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

sh ./configure_docker_proxy.sh

curl -s http://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update
sudo apt-get install -y --allow-unauthenticated kubelet=1.21.1-00 kubeadm=1.21.1-00 kubectl=1.21.1-00 kubernetes-cni=0.8.7-00

sudo swapoff -a
sudo systemctl daemon-reload
sudo systemctl stop kubelet
sudo systemctl start kubelet

docker load < ~/fuel/k8spkg/coredns.tar
docker load < ~/fuel/k8spkg/kube-apiserver.tar
docker load < ~/fuel/k8spkg/kube-proxy.tar
docker load < ~/fuel/k8spkg/kube-controller-manager.tar
docker load < ~/fuel/k8spkg/kube-scheduler.tar
docker load < ~/fuel/k8spkg/golang.tar
docker load < ~/fuel/k8spkg/etcd.tar
docker load < ~/fuel/k8spkg/pause.tar
docker load < ~/fuel/k8spkg/flannel.tar

