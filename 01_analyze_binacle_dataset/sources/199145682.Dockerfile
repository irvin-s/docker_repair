FROM ubuntu:16.04
MAINTAINER Matt Ho <matt.ho@gmail.com>

ENV PORT 80
ENV GOPATH /home/go

RUN apt-get update && apt-get install -y wget
ADD . /home/go/src/github.com/savaki/snowflake
RUN wget -q -O /tmp/golang.tar.gz https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz && \
  tar -C /usr/local -xzf /tmp/golang.tar.gz && \
  /usr/local/go/bin/go install github.com/savaki/snowflake/cmd/snowflake && \
  rm -rf /usr/local/go /tmp/golang.tar.gz

CMD [ "/home/go/bin/snowflake" ]
