#!/bin/bash

[ -z "$BOT_TOKEN" ] && echo "Переменная BOT_TOKEN пуста" || echo "Переменная BOT_TOKEN: $BOT_TOKEN"
[ -z "$CHAT_ID" ] && echo "Переменная CHAT_ID пуста" || echo "Переменная CHAT_ID: $CHAT_ID"
[ -z "$LOCAL_PORT" ] && echo "Переменная LOCAL_PORT пуста" || echo "Переменная LOCAL_PORT: $LOCAL_PORT"

CLOUDFLARED_LOG="cloudflared.log"

# Проверяем, запущен ли уже cloudflared
if pgrep -x "cloudflared" > /dev/null; then
    echo "Cloudflared был запущен ранее. Завершаю его через pkill"
    pkill -f "cloudflared"
    sleep 2
fi

# Очищаем лог перед запуском
> "$CLOUDFLARED_LOG"

# Запускаем cloudflared в фоне
cloudflared tunnel --url http://localhost:$LOCAL_PORT > "$CLOUDFLARED_LOG" 2>&1 &

# Ждем несколько секунд, чтобы туннель успел запуститься
sleep 10

# Ищем URL туннеля в логах
URL=$(grep -o 'https://[^ ]*\.trycloudflare.com' cloudflared.log)
echo $URL

# Если URL получен, отправляем уведомление
if [ ! -z "$URL" ]; then
    echo "Cloudflare Tunnel запущен: $URL"
    
    # Отправляем в Telegram
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
         -d chat_id=$CHAT_ID \
         -d text="Cloudflared Tunnel for OpenWebUI: $URL"

else
    echo "Не удалось получить URL туннеля."

    # Отправляем в Telegram
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
         -d chat_id=$CHAT_ID \
         -d text="Cannot update URL for OpenWebUI."

fi