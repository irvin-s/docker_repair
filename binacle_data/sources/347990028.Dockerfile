FROM golang:1.7-alpine
MAINTAINER colin.hom@coreos.com

RUN apk add --no-cache git
RUN go get github.com/tools/godep

ADD . $GOPATH/src/github.com/bitly/oauth2_proxy

WORKDIR $GOPATH/src/github.com/bitly/oauth2_proxy

RUN godep go install github.com/bitly/oauth2_proxy

ENTRYPOINT ["oauth2_proxy"]
