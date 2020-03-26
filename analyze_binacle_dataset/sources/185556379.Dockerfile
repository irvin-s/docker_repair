FROM ubuntu:12.04
MAINTAINER sguthrie@curoverse.com

RUN apt-get update && apt-get install -y \
  build-essential \
  curl \
  git \
  mercurial \
  pkg-config \
  python-pip \
  python-psycopg2 \
  python-software-properties \
  software-properties-common \
  zlib1g-dev

RUN pip install django \
  django-bootstrap-form \
  djangorestframework \
  requests

# Install go
RUN curl https://storage.googleapis.com/golang/go1.3.1.linux-amd64.tar.gz | tar -C /usr/local -zx
ENV GOROOT /usr/local/go
ENV PATH /usr/local/go/bin:$PATH

# Add lightning as a user, set up go environment
RUN useradd lightning
RUN mkdir /home/lightning && chown -R lightning: /home/lightning
RUN mkdir /home/lightning/go
ENV GOPATH /home/lightning/go:$GOPATH

WORKDIR /home/lightning
RUN git clone https://github.com/curoverse/lightning.git
WORKDIR /home/lightning/lightning/experimental/lantern
RUN go get github.com/codegangsta/cli
RUN go get code.google.com/p/vitess/go/cgzip
RUN go get github.com/lib/pq
RUN go get github.com/mattn/go-sqlite3
RUN go build

WORKDIR /home/lightning/lightning/experimental/pylightweb/lightning
