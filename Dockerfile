FROM alpine:latest

# Установим нужные утилиты и загрузим cloudflared
RUN apk add --no-cache curl && \
    curl -L https://github.com/cloudflare/cloudflared/releases/download/2025.2.0/cloudflared-linux-arm64 -o /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared

COPY start_cloudflared.sh .
ENTRYPOINT ["/start_cloudflared.sh"]