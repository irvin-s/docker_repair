FROM debian:stretch-slim

RUN apt-get update && \
    apt-get install -y wget gcc libz-dev && \
    rm -rf /var/lib/apt/lists/*

ARG VERSION=19.0.0
RUN wget https://github.com/oracle/graal/releases/download/vm-$VERSION/graalvm-ce-linux-amd64-$VERSION.tar.gz && \
    tar -xvzf graalvm-ce-$VERSION-linux-amd64.tar.gz && \
    rm graalvm-ce-linux-amd64-$VERSION.tar.gz && \
    /graalvm-ce-$VERSION/bin/gu install native-image

ENV PATH=/graalvm-ce-$VERSION/bin:$PATH