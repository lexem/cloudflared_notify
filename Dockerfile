FROM cloudflare/cloudflared:2025.2.0

COPY start_cloudflared.sh .

CMD ["./start_cloudflared.sh"]