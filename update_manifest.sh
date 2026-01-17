docker manifest create ghcr.io/aramann/tg-api:latest \
    ghcr.io/aramann/tg-api:amd64 \
    ghcr.io/aramann/tg-api:arm64

docker manifest push ghcr.io/ваш_юзер/tg-api:latest