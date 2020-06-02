FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y upgrade && \
          apt-get -y install curl build-essential docker.io

RUN curl -o go.tar.gz https://storage.googleapis.com/golang/go1.7.6.linux-amd64.tar.gz && \
          tar -C /usr/local -xzf go.tar.gz && \
          rm go.tar.gz

ENV PATH="/usr/local/go/bin:$PATH"
ENV GOPATH="/go"

RUN mkdir -p /go/src/github.com/contiv/auth_proxy

WORKDIR /go/src/github.com/contiv/auth_proxy

ENTRYPOINT ["/bin/bash"]
