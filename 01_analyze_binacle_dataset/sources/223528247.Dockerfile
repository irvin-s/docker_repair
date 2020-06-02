FROM bitnami/minideb:jessie

LABEL maintainer_name="Eric Dattore"
LABEL maintainer_email="edattore@gmail.com"

# Install dependencies for kcov
RUN apt-get update && \
    apt-get install --no-install-recommends -y zlib1g-dev libcurl4-openssl-dev libssl-dev libelf-dev libdw-dev \
    cmake cmake-data make g++ binutils-dev libiberty-dev python-minimal git curl ca-certificates unzip pkg-config && \
    rm -rf /var/lib/apt/lists/*

# Grab kcov
RUN curl -LOko master.zip https://github.com/SimonKagstrom/kcov/archive/master.zip \
    && unzip master.zip \
    && rm master.zip \
    && cd kcov-master \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j4 \
    && make install \
    && cd / \
    && rm -rf kcov-master

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain stable -y
RUN echo "source ~/.cargo/env" >> ~/.bashrc
RUN ~/.cargo/bin/rustup install beta
RUN ~/.cargo/bin/rustup install nightly
RUN ~/.cargo/bin/rustup run stable cargo install cargo-tarpaulin -j8

# Clone Aluminum-rs
RUN git clone https://github.com/ELD/Aluminum-rs /app

# Set workdir
WORKDIR /app
RUN ~/.cargo/bin/rustup run stable cargo fetch
RUN ~/.cargo/bin/rustup run beta cargo fetch
RUN ~/.cargo/bin/rustup run nightly cargo fetch

# Cleanup
RUN rm -rf /app
RUN apt-get clean
