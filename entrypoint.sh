#!/bin/bash

#LOCKFILE for generate uuid and keys in first start
LOCKFILE=.lockfile
if [ ! -f $LOCKFILE ]
then
echo "NoFile"

#generate uuid
/opt/xray/xray uuid >> /opt/xray/uuid

#generate Public & Private keys
/opt/xray/xray x25519 >> /opt/xray/keys

#Create files with Public & Private keys
awk '/Public/{print $3}' keys >> public
awk '/Private/{print $3}' keys >> private


touch $LOCKFILE
fi


