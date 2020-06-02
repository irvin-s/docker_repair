# This dockerfile is intended to build a minimal version of the todd container.
# It should be built using the provided makefile ("make build"), to ensure the
# binaries are compiled properly.

# This is currently renamed to "Dockerfile-debian" because I wanted to get the Dockerhub autobuild working
# quickly, and therefore used a Golang image instead. The long-term goal would be to get autobuild
# working with this Dockerfile instead, to cut down on image size.

FROM debian:jessie
MAINTAINER Matt Oswalt <matt@keepingitclassless.net> (@mierdin)

LABEL version="0.1"

env PATH /go/bin:$PATH

RUN mkdir /etc/todd

RUN mkdir -p /opt/todd/agent/assets/factcollectors
RUN mkdir -p /opt/todd/server/assets/factcollectors
RUN mkdir -p /opt/todd/agent/assets/testlets
RUN mkdir -p /opt/todd/server/assets/testlets

RUN apt-get update \
 && apt-get install -y vim curl iperf

# Copy ToDD binaries
COPY ./build/todd /go/bin/
COPY ./build/todd-server /go/bin/
COPY ./build/todd-agent /go/bin/

COPY ./etc/agent.cfg /etc/todd/agent.cfg
COPY ./etc/server.cfg /etc/todd/server.cfg
COPY ./etc/agent-dev.cfg /etc/todd/agent-dev.cfg
COPY ./etc/server-dev.cfg /etc/todd/server-dev.cfg