FROM debian:jessie

RUN apt-get update && \
    apt-get install -y protobuf-compiler  && \
        rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["protoc"]
