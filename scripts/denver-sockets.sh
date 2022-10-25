#! /usr/bin/env bash

set -exuo pipefail

# clean existing connections
ps aux | rg /Users/mmoltras/sockets/docker/ | rg -v rg | awk '{print $2}' | xargs kill || true

rm -f /Users/mmoltras/sockets/docker/fedora.sock
rm -f /Users/mmoltras/sockets/docker/ubuntu.sock

ssh -nNTL /Users/mmoltras/sockets/docker/fedora.sock:/var/run/docker.sock vagrant@fedora &
ssh -nNTL /Users/mmoltras/sockets/docker/ubuntu.sock:/var/run/docker.sock vagrant@ubuntu &
