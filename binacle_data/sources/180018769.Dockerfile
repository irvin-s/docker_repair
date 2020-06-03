FROM alpine:latest
MAINTAINER Jose Peleteiro <jose@peleteiro.net>

RUN apk update \
 && apk upgrade \
 && apk add \
            s6 bash curl make git \
            go \
 && rm -rf /var/cache/apk/*

ADD . /tmp/build/src/github.com/peleteiro/bandit-server

RUN export GOPATH=/tmp/build GO15VENDOREXPERIMENT=1\
 && cd /tmp/build/src/github.com/peleteiro/bandit-server \
 && make generate \
 && go build -o /usr/bin/bandit-server bandit-server.go \
 && rm -rf /tmp/build

ADD ./root /

ENV PORT=3321

CMD ["/bin/s6-svscan", "/etc/s6"]

EXPOSE 3321
