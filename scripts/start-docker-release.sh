#!/usr/bin/env bash
set -exu

set +x
# Random secret for local testing
export SECRET_KEY_BASE=J/XKLS1NmzJ5lrY5x7Ezox7x8xbYEfCdY6qRJ6UjRWkveEzT4RsOXEXl91ehklYO
export ENCRYPTION_SALT=BvDHP6B8
export SIGNING_SALT=UfXAsJSI
export LIVE_VIEW_SIGNING_SALT=OMvILgFb
set -x

docker run --rm -p 4000:4000 \
  --env SECRET_KEY_BASE --env ENCRYPTION_SALT --env SIGNING_SALT --env LIVE_VIEW_SIGNING_SALT \
  madvoid/gaga:latest
