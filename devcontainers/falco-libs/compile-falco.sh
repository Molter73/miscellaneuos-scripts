#! /usr/bin/env bash

set -euo pipefail

ACTION="${1:-build}"
ACTION="${ACTION,,}"

TARGET="${2:-all}"

function clean () {
    rm -f "${FALCO_DIR}/driver/bpf/probe.{o,ll}"
    make -C "${FALCO_DIR}/build" clean || true
    rm -rf "${FALCO_DIR}/build"
}

function configure () {
    mkdir -p "${FALCO_DIR}/build"
    cmake \
        -DBUILD_BPF=ON \
        -DUSE_BUNDLED_DEPS=OFF \
        -DUSE_BUNDLED_VALIJSON=ON \
        -DCMAKE_BUILD_TYPE=Debug \
        -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
        -S "${FALCO_DIR}" \
        -B "${FALCO_DIR}/build"
}

function build () {
    local target

    if [[ ! -d "${FALCO_DIR}/build" ]] || find "${FALCO_DIR}/build" -type d -empty | read ; then
        configure
    fi

    target="$1"
    make -j`nproc` -C "${FALCO_DIR}/build" "$target"
}

# We will be removing some directories, so go somewhere stable
cd "${FALCO_DIR}"

case "$ACTION" in
"clean")
    clean
    ;;
"configure")
    configure
    ;;
"build")
    build "$TARGET"
    ;;
"rebuild")
    clean
    build "$TARGET"
    ;;
*)
    echo >&2 "Unknown option '$ACTION'"
    ;;
esac
