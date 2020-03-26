FROM golang:1.7.4-alpine
MAINTAINER Donggeun <odg0318@gmail.com>

RUN apk add --update git make

ADD . /go/src/github.com/odg0318/aws-ec2-price

RUN cd /go/src/github.com/odg0318/aws-ec2-price && make build 

WORKDIR /go/bin

EXPOSE 8080

ENTRYPOINT ["aws-ec2-price"]
