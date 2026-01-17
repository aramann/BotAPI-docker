#!/usr/bin/env bash
set -euo pipefail

case "$(uname -m)" in
    x86_64) ARCH=amd64 ;;
    aarch64|arm64) ARCH=arm64 ;;
    armv7l) ARCH=armv7 ;;
    armv6l) ARCH=armv6 ;;
    ppc64le) ARCH=ppc64le ;;
    s390x) ARCH=s390x ;;
    *) ARCH="$(uname -m)" ;;
esac

IMAGE="ghcr.io/aramann/tg-api:${ARCH}"

docker build --provenance=false --platform linux/${ARCH} -t "$IMAGE" .
docker push "$IMAGE"