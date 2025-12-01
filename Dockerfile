# Stage 1: health endpoint
FROM python:3.11-slim as health
WORKDIR /app
COPY health.py .

# Stage 2: main V2Ray
FROM v2fly/v2fly-core
COPY config.json /etc/v2ray/config.json
COPY --from=health /app/health.py /health.py
COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
