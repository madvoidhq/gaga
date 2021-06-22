#!/usr/bin/env bash
set -exu

# Setup a Buildx builder for multi-arch (QEMU)
if ! docker buildx ls | grep buildx-builder >/dev/null; then \
  docker buildx create --append --name buildx-builder --driver docker-container --use && \
  docker buildx inspect --bootstrap --builder buildx-builder; \
fi

docker buildx build \
  --pull \
  --platform linux/amd64,linux/arm64 \
  --rm \
  -f "Dockerfile" \
  -t madvoid/gaga:latest \
  "."
