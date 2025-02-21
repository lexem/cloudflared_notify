FROM alpine:latest

# Определяем ARG (будет передано из buildx)
ARG TARGETARCH

# Если TARGETARCH не передан, устанавливаем значение по умолчанию (для обычного build)
ENV TARGETARCH=${TARGETARCH:-arm64}

# Установим нужные утилиты и загрузим cloudflared
RUN apk add --no-cache curl && \
    curl -L https://github.com/cloudflare/cloudflared/releases/download/2025.2.0/cloudflared-linux-${TARGETARCH} -o /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared

COPY start_cloudflared.sh .
ENTRYPOINT ["/start_cloudflared.sh"]