FROM alpine:latest

RUN apk add --no-cache mosh

ENTRYPOINT ["/usr/bin/mosh"]
