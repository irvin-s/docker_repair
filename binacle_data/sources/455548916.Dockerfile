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

ENV GOPATH=/root/go

# Build Spire
COPY repos/spire /root/go/src/github.com/spiffe/spire
WORKDIR /root/go/src/github.com/spiffe/spire/
RUN ./build.sh setup
RUN ./build.sh vendor
RUN ./build.sh binaries
RUN ./build.sh artifact

# Build tools
COPY tools/ /root/go/src/github.com/spiffe/spiffe-example/rosemary/build/tools/
WORKDIR /root/go/src/github.com/spiffe/spiffe-example/rosemary/build/tools
RUN ./build.sh all

# Build ghosttunnel
ENV GOROOT=/root/go/src/github.com/spiffe/spire/.build-linux-x86_64
ENV PATH=${GOROOT}/bin:${PATH}
RUN git -C /root/go/src/github.com/spiffe/ clone -b tls-config-with-go-spiffe https://github.com/spiffe/ghostunnel.git
WORKDIR /root/go/src/github.com/spiffe/ghostunnel
RUN go install
