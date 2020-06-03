FROM golang:alpine as builder

ADD ./main.go /go/src/github.com/cirocosta/auto53/main.go
ADD ./lib /go/src/github.com/cirocosta/auto53/lib
ADD ./vendor /go/src/github.com/cirocosta/auto53/vendor

WORKDIR /go/src/github.com/cirocosta/auto53

RUN set -ex && \
  CGO_ENABLED=0 go build -tags netgo -v -a -ldflags '-extldflags "-static"' && \
  mv ./auto53 /usr/bin/auto53

FROM alpine
COPY --from=builder /usr/bin/auto53 /usr/local/bin/auto53

RUN set -x && \
  apk add --update ca-certificates

ENTRYPOINT [ "auto53" ]

