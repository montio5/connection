#!/bin/sh
# Start health server in background
python /health.py &

# Start V2Ray server
exec /usr/bin/v2ray -config=/etc/v2ray/config.json
