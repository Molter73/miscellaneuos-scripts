#! /usr/bin/env bash

set -euo pipefail

function die {
    echo >&2 "$1"
    exit 1
}

flavors=(
    "fedora"
    "debian"
)

FALCO_DIR="$GOPATH/src/github.com/falcosecurity/libs"
DEVCONTAINER_DIR="$GOPATH/src/github.com/molter73/miscellaneuos-scripts/devcontainers"
FALCO_BUILDER="falco-builder"
FLAVOR=${1:-"fedora"}

[[ " ${flavors[*]} " =~ " $FLAVOR " ]] || die "Invalid flavor '$FLAVOR'"

docker build --tag falco-builder:"$FLAVOR" \
    --build-arg FALCO_DIR="${FALCO_DIR}" \
    -f "$DEVCONTAINER_DIR/falco-libs/$FLAVOR.Dockerfile" \
    "$DEVCONTAINER_DIR/falco-libs"

docker rm -f "$FALCO_BUILDER" || true

docker run --rm -id \
    -v "$FALCO_DIR":"$FALCO_DIR" \
    -v /usr/src:/usr/src:ro \
    -v /lib/modules:/lib/modules:ro \
    -v /usr/include/bpf:/usr/include/bpf:ro \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /dev:/dev:ro \
    -w "$FALCO_DIR" \
    --privileged \
    --name "$FALCO_BUILDER" \
    falco-builder:"$FLAVOR"
