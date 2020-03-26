FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y curl gnupg2
RUN apt-get install -y git
RUN apt-get install -y make
RUN apt-get install -y cmake
RUN apt-get install -y clang
RUN apt-get install -y rsync
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get update
RUN apt-get install -y nodejs

WORKDIR /llvmwasm
RUN git clone https://github.com/sanderspies/llvm

WORKDIR /llvmwasm/llvm
RUN git checkout reference-types

WORKDIR /llvmwasm/llvm/tools
RUN git clone https://github.com/sanderspies/lld

WORKDIR /llvmwasm/llvm/tools/lld
RUN git checkout reference-types

WORKDIR /llvmwasm/llvm-build

RUN cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=$INSTALLDIR -DLLVM_TARGETS_TO_BUILD=WebAssembly -DLLVM_INCLUDE_EXAMPLES=OFF -DLLVM_BUILD_TOOLS=OFF -DLLVM_INCLUDE_TESTS=OFF -DLLVM_ENABLE_PIC=OFF -DLLVM_ENABLE_ASSERTIONS=OFF -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=WebAssembly /llvmwasm/llvm 
RUN make lld
RUN make llc
RUN make -j 4

WORKDIR /
RUN git clone --recursive https://github.com/sanderspies/wabt
RUN ls -l
RUN git clone https://github.com/SanderSpies/ocaml

WORKDIR /wabt
RUN make

WORKDIR /ocaml
ENV LLVM_HOME /llvmwasm/llvm-build

WORKDIR /workspace/ocaml