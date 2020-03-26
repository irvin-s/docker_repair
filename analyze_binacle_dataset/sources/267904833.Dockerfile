FROM alpine:3.5

ENV GOPATH=/go

RUN apk --no-cache add ca-certificates git go musl-dev 

WORKDIR /go/src/app

ADD . /go/src/app/

RUN go get ./... \
  && CGO_ENABLED=0 go build -ldflags '-s -extldflags "-static"' -o /kubernetes-auth-conf . \
  && apk del go git musl-dev \
  && rm -rf $GOPATH

CMD [ "/kubernetes-auth-conf" ]
