FROM buildpack-deps:jessie
MAINTAINER Fletcher Nichol <fnichol@nichol.ca>

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    gdb \
  && rm -rf /var/lib/apt/lists/*

ENV RUST_VERSION 1.15.0
ENV CARGO_HOME /cargo
ENV PATH $CARGO_HOME/bin:/root/.cargo/bin:$PATH
ENV SRC_PATH /src

RUN curl -sSf https://sh.rustup.rs \
  | env -u CARGO_HOME sh -s -- -y --default-toolchain "$RUST_VERSION" \
  && rustc --version && cargo --version \
  && mkdir -p "$CARGO_HOME" "$SRC_PATH"

COPY build_musl.sh /prep/build_musl.sh
RUN BUILDROOT=/prep bash /prep/build_musl.sh && rm -rf /prep \
  && env -u CARGO_HOME rustup target add x86_64-unknown-linux-musl
ENV PATH $PATH:/usr/local/musl/bin

WORKDIR $SRC_PATH

CMD ["/bin/bash"]
