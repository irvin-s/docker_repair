FROM debian:jessie-slim

RUN mkdir -p /opt/driver/src && \
    useradd --uid ${BUILD_UID} --home /opt/driver ${BUILD_USER}

ENV RUSTUP_HOME /opt/rust/rustup
ENV CARGO_HOME /opt/rust/cargo

RUN apt update && \
    apt install -y --no-install-recommends ca-certificates git curl file make libc6-dev gcc && \
    curl https://sh.rustup.rs -sSf | sh -s -- -y \
        --default-toolchain ${RUNTIME_NATIVE_VERSION}

ENV PATH $CARGO_HOME/bin/:$PATH
ENV LD_LIBRARY_PATH $RUSTUP_HOME/toolchains/$RUNTIME_NATIVE_VERSION-x86_64-unknown-linux-gnu/lib/:$LD_LIBRARY_PATH

WORKDIR /opt/driver/src/