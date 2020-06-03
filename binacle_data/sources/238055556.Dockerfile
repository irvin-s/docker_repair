FROM alpine:3.5
# https://github.com/seegno/docker-bitcoind/blob/master/0.13/alpine/Dockerfile
# The DAO (organization) - Wikipedia  https://en.wikipedia.org/wiki/The_DAO_(organization)
# Release DAO Wars (1.4.8) · ethereum/go-ethereum  https://github.com/ethereum/go-ethereum/releases/tag/v1.4.8
# Release Colourise (1.4.7) · ethereum/go-ethereum  https://github.com/ethereum/go-ethereum/releases/tag/v1.4.7
# y12docker/dltdojo-ethgo - Docker Hub  https://hub.docker.com/r/y12docker/dltdojo-ethgo/tags/

ENV ETHGO_VERSION=1.4.7
RUN apk --update --no-cache add bash curl jq git \
    && apk add --virtual .builddeps build-base go musl-dev linux-headers \
    && curl --insecure -sL https://github.com/ethereum/go-ethereum/archive/v$ETHGO_VERSION.tar.gz | tar zx \
    && mv go-ethereum-$ETHGO_VERSION go-ethereum \
    && (cd go-ethereum && make geth) \
    && cp go-ethereum/build/bin/geth /usr/bin/geth \
    && rm -rf /go-ethereum && rm -rf /var/cache/apk/* \
    && apk --no-cache --purge del .builddeps \
    && rm -rf /tmp/*
