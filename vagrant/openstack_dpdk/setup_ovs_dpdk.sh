#!/bin/bash

set -ex

#sudo sh /vagrant/02_setup_redsocks.sh
sudo sysctl -w vm.nr_hugepages=2048
sudo mount -t hugetlbfs -o pagesize=2M none /dev/hugepages
sudo modprobe uio_pci_generic

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5EDB1B62EC4926EA
sudo apt-get update -y
sudo apt-get install software-properties-common -y
sudo apt-add-repository cloud-archive:ocata -y
sudo apt-get update -y

#install libvirt/qemu
sudo apt-get install -y virt-manager libvirt-bin qemu qemu-system
cat << EOF | sudo tee /etc/libvirt/qemu.conf
user = "root"
group = "root"
EOF
sudo service libvirt-bin restart
sudo sed -ri -e 's,(KVM_HUGEPAGES=).*,\11,' /etc/default/qemu-kvm
sudo service qemu-kvm restart

sudo apt-get install -y openvswitch-switch-dpdk
sudo update-alternatives --set ovs-vswitchd /usr/lib/openvswitch-switch-dpdk/ovs-vswitchd-dpdk

sudo sed -i "s/[# ]*\(NR_2M_PAGES=\).*/\10/" /etc/dpdk/dpdk.conf
sudo service dpdk restart

ip=$(ip a s eth2 | grep inet | grep -v inet6 | sed "s/.*inet//" | cut -f2 -d' ')
sudo ip address flush eth2
sudo /usr/share/dpdk/tools/dpdk_nic_bind.py --bind=uio_pci_generic eth2

sudo ovs-vsctl --no-wait set Open_vSwitch . "other_config:dpdk-init=true"
sudo ovs-vsctl --no-wait set Open_vSwitch . "other_config:dpdk-lcore-mask=1"
sudo ovs-vsctl --no-wait set Open_vSwitch . "other_config:dpdk-alloc-mem=2048"
echo sudo ovs-vsctl --no-wait set Open_vSwitch . \
    "other_config:dpdk-extra=--vhost-owner libvirt-qemu:kvm --vhost-perm 0777"

sudo service openvswitch-switch restart
sudo ovs-vsctl add-br br-int -- set bridge br-int datapath_type=netdev
sudo ovs-vsctl add-br br-ex -- set bridge br-ex datapath_type=netdev
sudo ovs-vsctl add-port br-ex dpdk0 -- set Interface dpdk0 type=dpdk
sudo ip a a $ip dev br-ex
sudo ip link set dev br-ex up
