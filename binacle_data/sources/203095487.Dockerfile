# Base image with compiler/rust for host
FROM ubuntu:15.10

WORKDIR /build

RUN apt-get -y update && \
    apt-get install -y --force-yes --no-install-recommends \
        curl file sudo g++ gcc libc6-dev git ca-certificates \
        musl-tools jq \
        && \
    apt-get clean

# Add install script and set the base RUST_VERSION to be used (but do
# not actually install any rust in base)
ADD install_rust.sh /rust-cross/
ENV RUST_TARGETS="" RUST_VERSIONS="1.7.0"
