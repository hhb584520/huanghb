#!/bin/sh
curl  http://cloud-client6.sh.intel.com:8081/repository/raw/content/install_nexus_cert.sh| bash 
sudo sh -c "echo $(dig +short cloud-client6.sh.intel.com)  nexus3.onap.org >> /etc/hosts"
sudo docker logout nexus3.onap.org:10001
sudo docker login -u docker -p docker nexus3.onap.org:10001
