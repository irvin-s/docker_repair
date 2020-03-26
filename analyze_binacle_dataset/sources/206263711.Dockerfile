FROM ubuntu:latest

ENV GO_VER=1.12.5
ENV FILE=go${GO_VER}.linux-amd64.tar.gz
ENV GOROOT=/root/go
ENV GOPATH=/root

RUN apt update -y && apt install -y git curl && \
cd ${GOPATH} && curl -k -s -O https://dl.google.com/go/${FILE} && \
gunzip -c ${FILE} | tar xf - && rm -f ${FILE} && \
${GOROOT}/bin/go get -u github.com/go-delve/delve/cmd/dlv