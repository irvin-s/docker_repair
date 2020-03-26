FROM debian
MAINTAINER Evan Johnson <evan@twiinsen.com>

ARG fuzztgt
ENV fuzztgt=$fuzztgt

RUN apt-get update && apt-get install -y git gcc curl make build-essential libpng-dev
RUN curl https://storage.googleapis.com/golang/go1.8.1.linux-amd64.tar.gz > go1.8.1.linux-amd64.tar.gz
RUN tar -zxvf go1.8.1.linux-amd64.tar.gz -C /usr/local

RUN mkdir -p go/pkg go/bin go/src/github.com/ejcx
COPY src /src
COPY run.sh /bin/run.sh
COPY Makefile.fuzz Makefile.fuzz
COPY fuzz fuzz
COPY crashbot go/src/github.com/ejcx/crashbot
ENV GOPATH /go

COPY afl-latest.tgz afl-latest.tgz

RUN /usr/local/go/bin/go build go/src/github.com/ejcx/crashbot/crashbot.go
CMD /bin/run.sh $fuzztgt
