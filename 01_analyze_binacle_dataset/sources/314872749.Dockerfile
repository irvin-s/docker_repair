# Build stage
FROM golang:1.10-alpine3.7
MAINTAINER Hung-Wei Chiu <hwchiu@linkernetworks.com>

WORKDIR /go/src/github.com/hwchiu/fileserver
COPY src   /go/src/github.com/hwchiu/fileserver/src
COPY main.go /go/src/github.com/hwchiu/fileserver
COPY vendor /go/src/github.com/hwchiu/fileserver/vendor

COPY mime.types /etc/

ENV PORT 33333
ENV ROOT /

RUN apk add --no-cache git bzr
RUN go get github.com/kardianos/govendor
RUN govendor sync
RUN go install .
ENTRYPOINT /go/bin/fileserver -host localhost -port ${PORT} -documentRoot ${ROOT}
