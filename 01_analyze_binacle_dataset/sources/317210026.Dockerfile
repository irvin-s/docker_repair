# Build status-go in a Go builder container
FROM golang:1.10-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers git bash curl

ENV WORKDIR=/go/src/github.com/status-im/geth_exporter

RUN mkdir -p ${WORKDIR}
ADD . ${WORKDIR}
WORKDIR ${WORKDIR}
RUN make setup && make

# Copy the binary to the second image
FROM alpine:latest

RUN apk add --no-cache ca-certificates bash

ENV WORKDIR=/go/src/github.com/status-im/geth_exporter

COPY --from=builder ${WORKDIR}/build/bin/geth_exporter /usr/local/bin/

EXPOSE 9200
