#!/usr/bin/env bash
sudo rm -rf /etc/apt/sources.list
sudo tee /etc/apt/sources.list.d/linux-ftp.list <<-'EOF'
deb http://linux-ftp.sh.intel.com/pub/mirrors/ubuntu/  xenial main restricted
deb http://linux-ftp.sh.intel.com/pub/mirrors/ubuntu/  xenial-updates main restricted
deb http://linux-ftp.sh.intel.com/pub/mirrors/ubuntu/  xenial universe
deb http://linux-ftp.sh.intel.com/pub/mirrors/ubuntu/  xenial-updates universe
deb http://linux-ftp.sh.intel.com/pub/mirrors/ubuntu/  xenial multiverse
deb http://linux-ftp.sh.intel.com/pub/mirrors/ubuntu/  xenial-updates multiverse
deb http://linux-ftp.sh.intel.com/pub/mirrors/ubuntu/  xenial-backports main restricted universe multiverse
deb http://linux-ftp.sh.intel.com/pub/mirrors/ubuntu/  xenial-security main restricted
deb http://linux-ftp.sh.intel.com/pub/mirrors/ubuntu/  xenial-security universe
deb http://linux-ftp.sh.intel.com/pub/mirrors/ubuntu/  xenial-security multiverse
EOF
