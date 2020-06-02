FROM ruby:alpine

RUN apk update
RUN apk upgrade
RUN apk add curl git bash

# Install BOSH v2 CLI
RUN curl -sSL -o /usr/local/bin/bosh https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-2.0.28-linux-amd64
RUN chmod +x /usr/local/bin/bosh

ENV GOLANG_VERSION 1.8.3
ADD https://storage.googleapis.com/golang/go${GOLANG_VERSION}.linux-amd64.tar.gz /downloads/golang/
RUN chmod 644 /downloads/golang/go${GOLANG_VERSION}*.gz
RUN mkdir /blobstore && chmod 755 /blobstore
