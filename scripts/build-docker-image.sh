#!/usr/bin/env bash
set -exu

docker build --pull --rm -f "Dockerfile" -t madvoid/gaga:latest "."
