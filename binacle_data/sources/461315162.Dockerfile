FROM rust
RUN apt-get update && \
    apt-get install -y build-essential cmake libssh2-1-dev && \
    rm -rf /var/lib/apt/lists/*
RUN cargo install cargo-watch
WORKDIR /src
CMD cargo watch -s 'cargo run -- --config testing/config.yml'
