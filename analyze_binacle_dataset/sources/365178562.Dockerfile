FROM buildpack-deps:jessie
MAINTAINER Fletcher Nichol <fnichol@nichol.ca>

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    gdb \
  && rm -rf /var/lib/apt/lists/*

ENV RUST_VERSION 1.8.0

RUN curl -s https://static.rust-lang.org/rustup.sh \
  | sh -s -- --yes --disable-sudo --revision=$RUST_VERSION \
  && rustc --version && cargo --version

RUN URL=http://static.rust-lang.org/dist/rust-std-${RUST_VERSION}-x86_64-unknown-linux-musl.tar.gz \
  && mkdir -p /prep/rust-std-musl \
  && (cd /prep && curl -LO $URL) \
  && tar xf /prep/$(basename $URL) -C /prep/rust-std-musl --strip-components=1 \
  && (cd /prep/rust-std-musl && ./install.sh --prefix=$(rustc --print sysroot))

COPY build_musl.sh /prep/build_musl.sh
RUN BUILDROOT=/prep bash /prep/build_musl.sh && rm -rf /prep

ENV PATH $PATH:/usr/local/musl/bin
ENV CARGO_HOME /cargo
ENV SRC_PATH /src

RUN mkdir -p "$CARGO_HOME" "$SRC_PATH"
WORKDIR $SRC_PATH

CMD ["/bin/bash"]
