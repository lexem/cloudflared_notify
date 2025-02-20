# cloudflared_notify

Get BOT_TOKEN from @BotFather
Get CHAT_ID from @userinfobot

Example:

```console
docker run -d --name cloudflared_tunnel \
    -e BOT_TOKEN="1234567890:BBEEGHggjH5HRSUmmj9JysrNQqHT570Gq14" \
    -e CHAT_ID="9876543" \
    -e LOCAL_PORT="3001" \
    aleksandk/cloudflared_notify:latest
