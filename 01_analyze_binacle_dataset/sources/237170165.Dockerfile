FROM golang:1.8-alpine

ENV BUILD_FLAGS="-v -ldflags '-d -s -w' -a -tags netgo -installsuffix netgo"
ENV SYSLOG_SOCKET=/dev/log

WORKDIR /go/src/github.com/yosifkit/syslog-init/
COPY *.go ./

RUN set -ex; apk add --no-cache git; eval "go get $BUILD_FLAGS"; apk del git

ENTRYPOINT ["syslog-init"]
CMD ["sh"]
