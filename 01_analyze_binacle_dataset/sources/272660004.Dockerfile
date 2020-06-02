FROM debian:stretch

RUN apt-get update && apt-get install -y bc gcc-aarch64-linux-gnu device-tree-compiler git ca-certificates build-essential libc6-dev-arm64-cross wget fakeroot debhelper gawk --no-install-recommends && rm -rf /var/lib/apt/lists/*
