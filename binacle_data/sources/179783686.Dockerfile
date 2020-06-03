FROM fellah/ubuntu:latest

MAINTAINER Roman Krivetsky <r.krivetsky@gmail.com>

USER root

ADD https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz /tmp
RUN tar \
  --directory=/usr/local \
  --extract \
  --gunzip \
  --file=/tmp/go1.8.linux-amd64.tar.gz
ENV PATH $PATH:/usr/local/go/bin

USER fellah

RUN mkdir /home/fellah/go
ENV GOPATH /home/fellah/go
ENV PATH $PATH:/home/fellah/go/bin
RUN go get github.com/derekparker/delve/cmd/dlv
