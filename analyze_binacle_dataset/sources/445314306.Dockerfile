# Build Gwon in a stock Go builder container
FROM golang:1.10-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers

ADD . /go-wonderair ecosystem
RUN cd /go-wonderair ecosystem && make gwon

# Pull Gwon into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY --from=builder /go-wonderair ecosystem/build/bin/gwon /usr/local/bin/

EXPOSE 9099 8546 10909 10909/udp
ENTRYPOINT ["gwon"]
