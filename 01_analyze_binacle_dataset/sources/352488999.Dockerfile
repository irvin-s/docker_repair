FROM alpine:latest
MAINTAINER Gianluca Arbezzano <gianarb92@gmail.com>

RUN apk update && \
    apk add ca-certificates wget && \
    update-ca-certificates && \
    wget https://github.com/docker/machine/releases/download/v0.8.2/docker-machine-Linux-x86_64 && \
    chmod +x ./docker-machine-Linux-x86_64 && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["./docker-machine-Linux-x86_64"]
