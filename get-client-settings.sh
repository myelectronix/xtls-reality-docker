#!/bin/bash
echo "IP Address: $(curl -s ifconfig.me)"
echo "UUID: $(cat config/uuid)"
echo "Public key: $(cat config/public)"
echo "SNI: ${SNI}"
echo "ShortID: ${SHORT_ID}"