FROM buildpack-deps:jessie
MAINTAINER Fletcher Nichol <fnichol@nichol.ca>

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    gdb \
  && rm -rf /var/lib/apt/lists/*

ENV RUST_VERSION 1.6.0
ENV CARGO_VERSION 1af03be

COPY build_musl_rust.sh /build_musl_rust.sh

RUN buildDeps=' \
    cmake \
    cmake-data \
    libarchive13 \
    clang \
    clang-3.5 \
    libclang-common-3.5-dev \
    libclang1-3.5 \
    libllvm3.5 \
    libobjc-4.9-dev \
    libobjc4 \
  ' \
  && set -x \
  && apt-get update \
  && apt-get install -y --no-install-recommends $buildDeps \
  && rm -rf /var/lib/apt/lists/* \
  && BUILDROOT=/prep /build_musl_rust.sh \
  && rm -rf /prep /build_musl_rust.sh \
  && apt-get purge -y --auto-remove $buildDeps

ENV CARGO_HOME /cargo
ENV SRC_PATH /src

RUN mkdir -p "$CARGO_HOME" "$SRC_PATH"
WORKDIR $SRC_PATH

CMD ["/bin/bash"]
