FROM golang:1.12 AS builder
COPY src /hockeypuck/src
ENV GOPATH=/hockeypuck
WORKDIR /hockeypuck/src
RUN go vet ./...
RUN go install ./hockeypuck/server/cmd/...

FROM ubuntu:18.04
RUN mkdir -p /hockeypuck/bin /hockeypuck/lib /hockeypuck/etc /hockeypuck/data
COPY --from=builder /hockeypuck/bin /hockeypuck/bin
COPY contrib/templates /hockeypuck/lib/templates
COPY contrib/webroot /hockeypuck/lib/www
VOLUME /hockeypuck/etc /hockeypuck/data
ENTRYPOINT ["/hockeypuck/bin/hockeypuck", "-config", "/hockeypuck/etc/hockeypuck.conf"]
