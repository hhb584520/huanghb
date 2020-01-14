#!/bin/sh

# config git
git config --global user.email "haibin.huang@intel.com"
git config --global user.name "Huang Haibin"
git config --global core.editor vim
git config --global push.default simple

# config git review
## config id_rsa
cp ../mine/id_rsa ~/.ssh/id_rsa
chmod 0660 ~/.ssh/id_rsa

## install git-review
sudo apt-get install -y git-review

## download code
# git clone ssh://haibin@gerrit.onap.org:29418/multicloud/openstack m2
# vim m2/.git/config
# add below config
# [remote "gerrit"]
#        url = ssh://haibin@gerrit.onap.org:29418/multicloud/openstack.git
#        fetch = +refs/heads/*:refs/remotes/gerrit/*
