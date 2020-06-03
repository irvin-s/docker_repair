FROM gliderlabs/alpine:3.3
MAINTAINER Ryan Eschinger <ryanesc@gmail.com>

RUN apk add --update ca-certificates bash
COPY launch.sh /launch.sh

COPY . /go/src/github.com/CiscoCloud/mantl-api

RUN apk add --update go git mercurial make \
  && cd /go/src/github.com/CiscoCloud/mantl-api \
  && export GOPATH=/go \
  && export GO15VENDOREXPERIMENT=1 \
  && echo "building with $(go version)..." \
  && cd /go/src/github.com/CiscoCloud/mantl-api && go build -o /bin/mantl-api \
  && rm -rf /go \
  && apk del --purge go mercurial make

ENTRYPOINT ["/launch.sh"]
