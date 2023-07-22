#!/bin/bash
rm -rf config/.lockfile
echo "The proxy-server will be restarted. New client settings will be created on startup"
killall /opt/xray/xray 
