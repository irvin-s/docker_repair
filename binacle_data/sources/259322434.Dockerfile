FROM golang:1.10.0-alpine
RUN apk add --no-cache git
ENV GOPATH /go
RUN go get -u github.com/googlecloudplatform/gcsfuse

FROM alpine:3.6
RUN apk add --no-cache ca-certificates fuse && rm -rf /tmp/*
COPY --from=0 /go/bin/gcsfuse /usr/local/bin
WORKDIR /
