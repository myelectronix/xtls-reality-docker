#!/bin/bash

#LOCKFILE for generate uuid and keys in first start
LOCKFILE=config/.lockfile
if [ ! -f $LOCKFILE ]
then

#generate uuid
echo "Generate UUID..."
/opt/xray/xray uuid >> config/uuid


#generate Public & Private keys
echo "Generate public & private keys..."
/opt/xray/xray x25519 >> config/keys

#Create files with Public & Private keys
awk '/Public/{print $3}' config/keys >> config/public
awk '/Private/{print $3}' config/keys >> config/private

UUID=$(cat config/uuid)
PRIVATE=$(cat config/private)

#set uuid in config.json
sed -i 's/"id":.*/"id": "'${UUID}'",/' config/config.json

#set private key in config.json
sed -i 's/"privateKey":.*/"privateKey": "'${PRIVATE}'",/' config/config.json

#create lockfile
touch $LOCKFILE
fi

#run proxy
echo "XTLS reality starting..."
/opt/xray/xray run -config /opt/xray/config/config.json



