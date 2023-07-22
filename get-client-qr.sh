#!/bin/bash
EXT_IP=$(curl ifconfig.me)
UUID=$(cat config/uuid)
PUB_KEY=$(cat config/public)

echo "vless://${UUID}@${EXT_IP}:443?security=reality&encryption=none&pbk=${PUB_KEY}&headerType=none&fp=chrome&type=tcp&flow=xtls-rprx-vision&sni=${SNI}&sid=${SHORT_ID}#MyVLESS" > client_qr.txt
qrencode -t ansiutf8 < client_qr.txt