FROM archlinux/base

ENV GOPATH /go

RUN pacman -Syu --noconfirm base-devel clang cmake git go python ruby-bundler
RUN curl -fsSL https://sh.rustup.rs | sh -s -- -y --default-toolchain nightly
RUN go get -d github.com/llvm-mirror/llvm/bindings/go/llvm
RUN cd $GOPATH/src/github.com/llvm-mirror/llvm && git checkout stable
RUN $GOPATH/src/github.com/llvm-mirror/llvm/bindings/go/build.sh -DCMAKE_BUILD_TYPE=Release
