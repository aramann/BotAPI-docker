# 1. Создаем манифест (флаг --amend позволяет перезаписать существующий)
docker manifest create --amend ghcr.io/aramann/tg-api:latest \
    ghcr.io/aramann/tg-api:amd64 \
    ghcr.io/aramann/tg-api:arm64

# 2. Пушим манифест (исправлено имя юзера)
docker manifest push ghcr.io/aramann/tg-api:latest