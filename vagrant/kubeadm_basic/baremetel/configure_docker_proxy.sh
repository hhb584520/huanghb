#!/bin/bash

set -ex

sudo mkdir -p /etc/systemd/system/docker.service.d
cat <<EOF | sudo tee /etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=http://child-prc.intel.com:913"
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo docker pull hello-world
