FROM ubuntu:xenial

LABEL Description="Certificate Rotation SPIFFE: build"
LABEL vendor="SPIFFE"
LABEL version="0.1.0"

ARG DEBUG
ARG SPIRE_GOOPTS

ENV DEBUG        "$DEBUG"
ENV SPIRE_GOOPTS "$SPIRE_GOOPTS"

RUN apt-get update -y
RUN apt-get install -y git curl unzip build-essential
RUN apt-get install -y emacs

WORKDIR /root/build

# Build tools, install GO
ADD setup_go.sh /root/build
RUN chmod +x /root/build/setup_go.sh
RUN ./setup_go.sh setup

# Build ghosttunnel
ENV GOPATH=/root/go
ENV GOROOT=/root/build/.build/golang-1.8.3
ENV PATH=${GOROOT}/bin:${PATH}

RUN go get -v github.com/spiffe/ghostunnel
