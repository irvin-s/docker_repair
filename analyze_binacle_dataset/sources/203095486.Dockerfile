FROM posborne/rust-cross:base

RUN apt-get -y update && \
    apt-get install -y --force-yes --no-install-recommends \
        gcc-4.7-arm-linux-gnueabi libc6-dev-armel-cross \
        gcc-4.7-arm-linux-gnueabihf libc6-dev-armhf-cross \
        gcc-4.8-aarch64-linux-gnu libc6-dev-arm64-cross \
        qemu qemu-system-arm qemu-system-aarch64 qemu-user qemu-utils \
        && \
    apt-get clean

# Inherit RUST_VERSIONS from base
ENV RUST_TARGETS="aarch64-unknown-linux-gnu arm-unknown-linux-gnueabi arm-unknown-linux-gnueabihf"
RUN bash /rust-cross/install_rust.sh
