# Small linux dev environment for the fs package.

FROM ubuntu

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y install git subversion mercurial gcc pkg-config

ENV GOROOT /go
ENV GOPATH /

RUN hg clone -u dev.cc https://code.google.com/p/go /go && \
	cd /go/src && ./all.bash

ENV PATH $PATH:/go/bin

WORKDIR /
