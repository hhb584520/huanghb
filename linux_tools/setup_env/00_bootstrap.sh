#!/bin/sh

# firefox https://github.intel.com/haibinhu/fuel.git 
# find 00_bootstrap.sh file and click raw get token replace below $token
# wget https://github.intel.com/raw/haibinhu/fuel/master/setup/00_bootstrap.sh?token=$token -O 00_bootstrap.sh

# must unap user 

user=`whoami`

cat << EOF | sudo tee /etc/sudoers.d/${user}
${user} ALL = (root) NOPASSWD:ALL
EOF

HTTP_PROXY=${HTTP_PROXY:-http://child-prc.sh.intel.com:913}
cat <<EOF | sudo tee /etc/apt/apt.conf
Acquire::http::Proxy "$HTTP_PROXY";
EOF

sudo apt-get install openssh-server -y
sudo sed -i "s/\(^PermitRootLogin \).*/\1yes/g" /etc/ssh/sshd_config
sudo service ssh restart


sudo apt-get install git -y
git clone https://github.intel.com/haibinhu/fuel.git
