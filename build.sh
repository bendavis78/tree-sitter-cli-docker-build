#!/bin/sh
dir="$(dirname $0)";
default_arch="$(arch)";

ARCH="${ARCH:-$default_arch}";

BUILD_ARGS=""
if [ -n "$VERSION" ]; then
    BUILD_ARGS="--build-arg VERSION=${VERSION}"
fi

imgname="tree-sitter-cli-build-${ARCH}"

echo "docker buildx build --load $BUILD_ARGS --platform="linux/${ARCH}" -t \"${imgname}\" ."
docker buildx build --load $BUILD_ARGS --platform="linux/${ARCH}" -t "${imgname}" . || exit 1

mkdir -p "$dir/build";

echo "Getting version from built container"
echo "docker run --rm --entrypoint tree-sitter \"${imgname}\" --version | cut -d ' ' -f 2"
version=$(docker run --platform="linux/${ARCH}" --rm --entrypoint tree-sitter "${imgname}" --version | cut -d ' ' -f 2 || exit 1);

echo "Exporting binary to $dir/build/tree-sitter_${version}_${ARCH}"
docker run --rm --platform="linux/${ARCH}" --entrypoint cat "${imgname}" "/usr/local/cargo/bin/tree-sitter" \
    > "$dir/build/tree-sitter_${version}_${ARCH}";
chmod +x "$dir/build/tree-sitter_${version}_${ARCH}";
