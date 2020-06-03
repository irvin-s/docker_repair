FROM golang:alpine

MAINTAINER Buster "Silver Eagle" Neece <buster@busterneece.com>

RUN apk update \
 && apk add git ffmpeg ca-certificates \
 && update-ca-certificates

WORKDIR /go/src/app
COPY . .

RUN go get -d -v ./...
RUN go install -v ./...

CMD /go/bin/app