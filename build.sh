#!/bin/sh
dir="$(dirname $0)";
default_arch="$(arch)";

ARCH="${ARCH:-$default_arch}";

mkdir -p "$dir/build";
docker build --build-arg VERSION="${VERSION}" --platform="${ARCH}" -t tree-sitter-cli-build . &&
docker run --rm --entrypoint cat tree-sitter-cli-build "/usr/local/cargo/bin/tree-sitter" \
    > "$dir/build/tree-sitter";
