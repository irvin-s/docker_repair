FROM alpine:3.4

RUN apk add --no-cache --virtual=build-dependencies go git \
    && GOPATH=/tmp/go \
    && export GOPATH=$GOPATH \
    && go get github.com/kahing/goofys \
    && go install github.com/kahing/goofys \
    && cp $GOPATH/bin/goofys /usr/local/bin \
    \
    && apk add --no-cache ca-certificates fuse syslog-ng \
    \
    && echo '@version: 3.7' > /etc/syslog-ng/syslog-ng.conf \
    && echo 'source goofys {internal();network(transport("udp"));unix-dgram("/dev/log");};' >> /etc/syslog-ng/syslog-ng.conf \
    && echo 'destination goofys {file("/var/log/goofys");};' >> /etc/syslog-ng/syslog-ng.conf \
    && echo 'log {source(goofys);destination(goofys);};' >> /etc/syslog-ng/syslog-ng.conf \
    \
    && apk del build-dependencies \
    && rm -rf "/tmp/"*

ADD docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]