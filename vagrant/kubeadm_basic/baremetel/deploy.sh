#!/bin/bash

set -ex

if [ "$#" -ne 6 ]; then
  echo "Usage: $0 mip, mname, w1ip, w1name, w2ip, w2name" >&2
  exit 1
fi

master_ip=$1
master_hostname=$2

worker1_ip=$3
worker1_hostname=$4
worker2_ip=$5
worker2_hostname=$6

sed -i "s/192.168.1.10/${master_ip}/" host_setup.sh
sed -i "s/master/${master_hostname}/" host_setup.sh
sed -i "s/192.168.1.21/${worker1_ip}/" host_setup.sh
sed -i "s/worker1/${worker1_hostname}/" host_setup.sh
sed -i "s/192.168.1.22/${worker2_ip}/" host_setup.sh
sed -i "s/worker2/${worker2_hostname}/" host_setup.sh

sed -i "s/192.168.1.10/${master_ip}/" master_setup.sh
sed -i "s/192.168.1.10/${master_ip}/" worker_setup.sh
