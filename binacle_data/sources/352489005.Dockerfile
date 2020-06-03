# golang
#
# VERSION 1.5.2

FROM ubuntu:latest
MAINTAINER Gianluca Arbezzano <gianarb92@gmail.com>

RUN apt-get update
RUN apt-get install -y build-essential curl wget cmake git

WORKDIR /tmp
RUN wget https://storage.googleapis.com/golang/go1.5.2.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.5.2.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/work

WORKDIR $GOPATH

CMD ["go", "-v"]
