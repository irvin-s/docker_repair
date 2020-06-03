FROM maven:3-jdk-8
MAINTAINER Tom Barlow "<tomwbarlow@gmail.com>"

RUN apt-get update && apt-get install -y --no-install-recommends \
    make

ENV DOCKER_VERSION 1.10.0

RUN curl -sL https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION} > /usr/local/bin/docker && \
    chmod +x /usr/local/bin/docker

ADD . /workspace
WORKDIR /workspace
