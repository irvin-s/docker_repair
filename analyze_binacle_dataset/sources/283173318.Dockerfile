FROM ekidd/rust-musl-builder:nightly

RUN sudo apt-get update && \
    sudo apt-get install -y software-properties-common unzip pkg-config && \
    sudo add-apt-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial main" && \
    sudo apt-get update && \
    sudo apt-get install -y clang-4.0 && \
    sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

RUN VERSION=1.0.16 && \
    cd /home/rust/libs && \
    mkdir libsodium && \
    cd libsodium && \
    curl -L https://download.libsodium.org/libsodium/releases/libsodium-$VERSION.tar.gz -o libsodium-$VERSION.tar.gz && \
    tar xfvz libsodium-$VERSION.tar.gz && \
    cd libsodium-$VERSION/ && \
    CC=musl-gcc ./configure --enable-shared=no --disable-pie && \
    make && make check && \
    sudo make install && \
    sudo mv src/libsodium /usr/local/ && \
    rm -rf /home/rust/libs/libsodium

# Protobuf is only used in compile-time.

RUN VERSION=3.4.0 && \
    cd /home/rust/libs && \
    mkdir protoc && \
    cd protoc && \
    curl -L https://github.com/google/protobuf/releases/download/v$VERSION/protoc-$VERSION-linux-x86_64.zip -o protoc-$VERSION.zip && \
    unzip protoc-$VERSION.zip && \
    sudo mv bin/* /usr/local/bin/ && \
    sudo mv include/* /usr/local/include/ && \
    rm -rf /home/rust/libs/protoc

ENV PKG_CONFIG_ALLOW_CROSS 1
ENV SODIUM_LIB_DIR /usr/local/lib
