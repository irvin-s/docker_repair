FROM ubuntu:16.04

RUN apt-get update -y && apt-get install -y --no-install-recommends \
      xorriso \
      binutils \
      nasm \
      git \
      qemu \
      gcc \
      libc6-dev \
      curl \
      ca-certificates \
      make \
      sudo \
      grub-pc \
      xorriso \
      grub-common

ENV RUSTUP_HOME=/rustup
ENV CARGO_HOME=/cargo
RUN curl https://sh.rustup.rs | sh -s -- -y --default-toolchain=nightly

ENV PATH=$PATH:/cargo/bin
RUN cargo install xargo --vers 0.2.1
RUN rustup component add rust-src
