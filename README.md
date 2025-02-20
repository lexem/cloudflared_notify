# cloudflared_notify

Get BOT_TOKEN from @BotFather

Get CHAT_ID from @userinfobot

Add LOCAL_APP for your app name, need just for notifications

Add LOCAL_PORT for your app port


Example:

```console
docker run -d --name cloudflared_tunnel --network host --restart always \
    -e BOT_TOKEN="1234567890:BBEEGHggjH5HRSUmmj9JysrNQqHT570Gq14" \
    -e CHAT_ID="9876543" \
    -e LOCAL_APP="OpenWebUI" \
    -e LOCAL_PORT="3000" \
    aleksandk/cloudflared_notify:latest
