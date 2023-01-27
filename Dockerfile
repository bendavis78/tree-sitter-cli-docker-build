FROM rust:buster
ARG VERSION

RUN apt update && apt install build-essential
ENV VERSION=${VERSION}
RUN bash -c '[[ -n "$VERSION" ]] && args="--version $VERSION"; cargo install $args tree-sitter-cli'
