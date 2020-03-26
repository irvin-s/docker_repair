FROM ubuntu:xenial

ARG SPIRE_VERSION="0.7.0"

RUN apt-get update -y
RUN apt-get install -y curl tar vim 

RUN curl -L https://github.com/spiffe/spire/releases/download/${SPIRE_VERSION}/spire-${SPIRE_VERSION}-linux-x86_64-glibc.tar.gz | tar zx -C /
RUN mkdir -p /opt/spire/conf/agent
RUN mkdir -p /opt/spire/conf/server
RUN mkdir -p /opt/spire/data/agent
RUN mkdir -p /opt/spire/data/server
RUN mv spire-${SPIRE_VERSION}/spire-server /usr/local/bin
RUN mv spire-${SPIRE_VERSION}/spire-agent /usr/local/bin

WORKDIR /opt/spire
