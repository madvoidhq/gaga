#!/usr/bin/env bash
set -exu

# Let's quickly run this on a single server with docker-compose for now...
#
# Requires:
#   - proper config in `~/.ssh/config`
#   - an `upgrade.sh` script on remote server mainly doing
#       docker-compose pull && docker-compose up -d

app="gaga"

sshlogin=labvoid-$app
basedir="./docker/$app"

ssh $sshlogin "cd $basedir && ./upgrade.sh"
