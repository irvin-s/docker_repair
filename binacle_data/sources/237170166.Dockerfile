FROM golang:1.8

ENV BUILD_FLAGS="-v -ldflags '-d -s -w' -a -tags netgo -installsuffix netgo"
ENV SYSLOG_SOCKET=/dev/log

WORKDIR /go/src/github.com/yosifkit/syslog-init/
COPY *.go ./

RUN set -e; eval "go get $BUILD_FLAGS"

ENTRYPOINT ["syslog-init"]
CMD ["bash"]
