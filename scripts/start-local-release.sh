#!/usr/bin/env bash
set -exu

set +x
# Random secret for local testing
export SECRET_KEY_BASE=J/XKLS1NmzJ5lrY5x7Ezox7x8xbYEfCdY6qRJ6UjRWkveEzT4RsOXEXl91ehklYO
export ENCRYPTION_SALT=BvDHP6B8
export SIGNING_SALT=UfXAsJSI
export LIVE_VIEW_SIGNING_SALT=OMvILgFb
set -x

# You can change this if needed:
# export ROOT_URL="http://localhost:4000"
# export PORT=4000

./_build/prod/rel/gaga/bin/gaga start
