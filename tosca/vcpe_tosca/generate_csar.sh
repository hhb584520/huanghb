#!/bin/bash

ROOT_DIR=`dirname $(readlink -f $0)`
DEST=`pwd`
PREFIX="vcpe_"

DIRS="infra vbrgemu vbng vgmux vgw"
#DIRS="infra"

for dir in $DIRS; do
#    image_name=${dir}_base_ubuntu_1604 
    cd $ROOT_DIR/$dir
#    mv Artifacts/images/ubuntu16.04 Artifacts/images/${image_name}
#    sed -i "s/ubuntu16.04/${image_name}/g" ./MainServiceTemplate.yaml
#    sed -i "s/ubuntu16.04/${image_name}/g" ./Definitions/MainServiceTemplate.yaml
    zip -r $ROOT_DIR/$dir/$dir.csar Artifacts/ TOSCA-Metadata/ Definitions/ MainServiceTemplate.mf MainServiceTemplate.yaml
#   zip -r $ROOT_DIR/$dir/$dir.csar TOSCA-Metadata/ Definitions/ MainServiceTemplate.mf MainServiceTemplate.yaml
    rm -f $DEST/$dir.csar
    mv $ROOT_DIR/$dir/$dir.csar $DEST/
done
