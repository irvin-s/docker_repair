FROM ubuntu:19.04

RUN apt-get update
RUN apt-get install -y curl gnupg2
RUN apt-get install -y git
RUN apt-get install -y make
RUN apt-get install -y cmake
RUN apt-get install -y clang
RUN apt-get install -y llvm
RUN apt-get install -y lld
RUN apt-get install -y lldb
RUN apt-get install -y rsync
# RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
# RUN apt-get update
RUN apt-get install -y nodejs

WORKDIR /
RUN git clone --recursive https://github.com/webassembly/wabt
RUN git clone https://github.com/SanderSpies/ocaml
RUN git clone https://github.com/CraneStation/wasi-sysroot
RUN git clone --recurse-submodules https://github.com/CraneStation/wasmtime.git
RUN curl -L https://github.com/CraneStation/wasi-sdk/releases/download/wasi-sdk-5/libclang_rt.builtins-wasm32-wasi-5.0.tar.gz > libclang_rt.builtins-wasm32-wasi-5.0.tar.gz
RUN tar -xvzf libclang_rt.builtins-wasm32-wasi-5.0.tar.gz
RUN mkdir /usr/lib/llvm-8/lib/clang/8.0.0/lib/wasi
RUN cp ./lib/wasi/libclang_rt.builtins-wasm32.a /usr/lib/llvm-8/lib/clang/8.0.0/lib/wasi/
RUN curl https://sh.rustup.rs -sSf > rustup
RUN sh rustup -y

ENV PATH="/usr/lib/llvm-8/bin/:${PATH}"

WORKDIR /wasmtime
COPY ./wasmfile.patch /wasmtime
RUN patch wasmtime-debug/src/transform.rs -i wasmfile.patch
RUN $HOME/.cargo/bin/cargo build --release

WORKDIR /wabt
RUN make

WORKDIR /wasi-sysroot
RUN make install INSTALL_DIR=/workspace/wasi

WORKDIR /ocaml
RUN git checkout manual_gc

ENV LLVM_HOME /usr/lib/llvm-8

WORKDIR /workspace/ocaml

# RUN clang --target=wasm32-unknown-wasi --sysroot /wasi-sysroot/sysroot -Os -s -o example.wasm test.c