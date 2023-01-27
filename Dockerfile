FROM rust:buster

RUN apt update && apt install build-essential
RUN cargo install tree-sitter-cli
