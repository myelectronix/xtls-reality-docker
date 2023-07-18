#!/bin/bash

#LOCKFILE for generate uuid and keys in first start
LOCKFILE=.lockfile
if [ ! -f $LOCKFILE ]
then

#generate uuid
echo "Generate UUID..."
/opt/xray/xray uuid >> /opt/xray/uuid


#generate Public & Private keys
echo "Generate public & private keys..."
/opt/xray/xray x25519 >> /opt/xray/keys

#Create files with Public & Private keys
awk '/Public/{print $3}' keys >> public
awk '/Private/{print $3}' keys >> private

UUID=$(cat uuid)
PRIVATE=$(cat private)

#set uuid in config.json
sed -i 's/"id":.*/"id": "'${UUID}'",/' config.json

#set private key in config.json
sed -i 's/"privateKey":.*/"privateKey": "'${PRIVATE}'",/' config.json

touch $LOCKFILE
fi

