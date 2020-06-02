FROM debian:jessie
MAINTAINER Fletcher Nichol <fnichol@nichol.ca>

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    file \
    g++ \
    gcc \
    gdb \
    libc6-dev \
    libssl-dev \
    make \
  && rm -rf /var/lib/apt/lists/*

ENV RUST_VERSION 1.6.0

RUN curl -s https://static.rust-lang.org/rustup.sh \
  | sh -s -- --yes --disable-sudo --revision=$RUST_VERSION \
  && rustc --version && cargo --version

ENV CARGO_HOME /cargo
ENV SRC_PATH /src

RUN mkdir -p "$CARGO_HOME" "$SRC_PATH"
WORKDIR $SRC_PATH

CMD ["/bin/bash"]
