# Start from Python (so health.py works)
FROM python:3.11-slim

# Install unzip and curl for V2Ray
RUN apt-get update && apt-get install -y curl unzip && rm -rf /var/lib/apt/lists/*

# Download and install V2Ray
RUN curl -L -o /v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip \
    && unzip /v2ray.zip -d /v2ray \
    && mv /v2ray/v2ray /usr/local/bin/ \
    && chmod +x /usr/local/bin/v2ray

# Copy your config and health.py
COPY config.json /etc/v2ray/config.json
COPY health.py /health.py

# Expose ports
EXPOSE 10000 3000

# Run health.py in background, then V2Ray
CMD ["sh", "-c", "python3 /health.py & /usr/local/bin/v2ray -config /etc/v2ray/config.json"]
