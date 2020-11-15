#!/usr/bin/env bash
set -exu

./scripts/build-docker-image.sh

# Force login to prevent pushing with the wrong user...
docker logout && docker login
docker push madvoid/gaga:latest
