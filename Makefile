include .env
export $(shell sed 's/=.*//' .env)

# Переменные
IMAGE_NAME := aleksandk/cloudflared_notify
TAG := latest

# Команда для сборки образа для текущей архитектуры
build:
	docker build -t $(IMAGE_NAME):$(TAG) .

# Сборка для нескольких платформ
buildx:
	docker buildx build --platform linux/amd64,linux/arm64 -t $(IMAGE_NAME):$(TAG) .

# Запуск контейнера
run:
	docker run -d --name cloudflared_tunnel --restart always --network host \
		-e BOT_TOKEN=$(BOT_TOKEN) \
		-e CHAT_ID=$(CHAT_ID) \
		-e LOCAL_APP=$(LOCAL_APP) \
		-e LOCAL_HOST=$(LOCAL_HOST) \
		-e LOCAL_PORT=$(LOCAL_PORT) \
		$(IMAGE_NAME):$(TAG)

# Очистка старых образов
clean:
	docker rmi $(IMAGE_NAME):$(TAG)

# Собираем образ и пушим образ в Docker Hub
push: buildx
	docker push $(IMAGE_NAME):$(TAG)