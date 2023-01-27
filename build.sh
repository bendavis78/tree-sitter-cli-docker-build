#!/bin/sh
dir="$(dirname $0)";
default_arch="$(arch)";
imgname="tree-sitter-cli-build"

ARCH="${ARCH:-$default_arch}";

mkdir -p "$dir/build";
docker build --build-arg VERSION="${VERSION}" --platform="${ARCH}" -t "${imgname}" . || exit 1
version=$(docker run --rm --entrypoint tree-sitter "${imgname}" --version | cut -d ' ' -f 2);
docker run --rm --entrypoint cat "${imgname}" "/usr/local/cargo/bin/tree-sitter" \
    > "$dir/build/tree-sitter_${version}_${ARCH}";
chmod +x "$dir/build/tree-sitter_${version}_${ARCH}";
