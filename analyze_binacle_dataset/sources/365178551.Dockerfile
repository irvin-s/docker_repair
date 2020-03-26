FROM buildpack-deps:jessie
MAINTAINER Fletcher Nichol <fnichol@nichol.ca>

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    gdb \
  && rm -rf /var/lib/apt/lists/*

ENV RUST_VERSION 1.7.0

RUN curl -s https://static.rust-lang.org/rustup.sh \
  | sh -s -- --yes --disable-sudo --revision=$RUST_VERSION \
  && rustc --version && cargo --version

ENV CARGO_HOME /cargo
ENV SRC_PATH /src

RUN mkdir -p "$CARGO_HOME" "$SRC_PATH"
WORKDIR $SRC_PATH

CMD ["/bin/bash"]
