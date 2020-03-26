FROM golang:latest
MAINTAINER Liang Ding <dl88250@gmail.com>

ADD . /gogogo/src/CoditorX

ENV GOROOT /usr/src/go
ENV GOPATH /gogogo

WORKDIR /gogogo/src/CoditorX

RUN go get -v && go build -v

EXPOSE 9090
