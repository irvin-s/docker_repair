FROM ubuntu:latest
RUN apt-get update
RUN apt-get -y install curl vim build-essential sudo libssl-dev gcc-arm-linux-gnueabihf

# Install Rust and Cargo
RUN curl https://sh.rustup.rs > sh.rustup.rs \
    && sh sh.rustup.rs -y \
    && . $HOME/.cargo/env \
    && echo 'source $HOME/.cargo/env' >> $HOME/.bashrc \
    && rustup update \
    && rustup default nightly-2016-09-05 \
    && rustup target add arm-unknown-linux-gnueabihf

VOLUME /rust-avc
VOLUME /rust-qik
