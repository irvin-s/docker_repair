FROM gifnksm/emscripten-latest
MAINTAINER NAKASHIMA, Makoto <makoto.nksm@gmail.com>

ARG RUST_VERSION

ENTRYPOINT ["/bin/bash"]

User root
RUN echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-3.9 main" >> /etc/apt/sources.list
RUN echo "deb-src http://apt.llvm.org/xenial/ llvm-toolchain-xenial-3.9 main" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 15CF4D18AF4F7421
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install build-essential git python curl libclang1-3.9

USER build
RUN curl -sSf https://build.travis-ci.org/files/rustup-init.sh | sh -s -- --default-toolchain=$RUST_VERSION -y
ENV PATH=/home/build/.cargo/bin:${PATH}
RUN rustup target add asmjs-unknown-emscripten
