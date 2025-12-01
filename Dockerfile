# Use official V2Fly image
FROM v2fly/v2fly-core

# Copy VLESS config
COPY config.json /etc/v2ray/config.json

# Copy health server
COPY health.py /health.py

# Install Python 3 for health.py
RUN apt-get update && apt-get install -y python3 python3-pip && rm -rf /var/lib/apt/lists/*

# Expose ports
EXPOSE 10000 3000

# Start health.py in background, then start V2Ray
CMD ["sh", "-c", "python3 /health.py & /usr/bin/v2ray -config /etc/v2ray/config.json"]
