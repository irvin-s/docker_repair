FROM ubuntu:14.04

RUN apt-get update && apt-get install -y \
  git-core \
  bzr \
  make \
  gcc \
  mercurial \
  ca-certificates \
  curl

RUN curl -s https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz | tar -v -C /usr/local -xz

ENV GOROOT /usr/local/go
ENV PATH /usr/local/go/bin:/gopath/bin:/usr/local/bin:$PATH
ENV GOPATH /gopath/