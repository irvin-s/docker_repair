FROM alpine:latest

RUN set -ex; \
  apk add --no-cache --no-progress --virtual .build-deps git gcc musl-dev bash go; \
  env GOPATH=/go go get -v github.com/google/pubkeystore; \
  install -t /bin /go/bin/pubkeystore; \
  rm -rf /go; \
  apk --no-progress del .build-deps
