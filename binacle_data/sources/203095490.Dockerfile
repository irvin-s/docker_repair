FROM posborne/rust-cross:base

RUN apt-get -y update && \
    apt-get install -y --force-yes --no-install-recommends software-properties-common && \
    add-apt-repository ppa:angelsl/mips-cross && \
    apt-get -y update && \
    apt-get install -y --force-yes --no-install-recommends \
        gcc-5-mips-linux-gnu libc6-dev-mips-cross \
        gcc-5-mipsel-linux-gnu libc6-dev-mipsel-cross \
        qemu qemu-system-mips qemu-user qemu-utils \
        && \
    apt-get clean

ENV RUST_TARGETS="mips-unknown-linux-gnu mipsel-unknown-linux-gnu"
RUN bash /rust-cross/install_rust.sh
