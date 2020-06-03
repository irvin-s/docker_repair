FROM ubuntu:vivid
MAINTAINER Ofir Petrushka @ Rounds <ofir @ rounds.com>, Ory Band @ Rounds <ory @ rounds.com>

# solves some issues and many messages in apt-get install
ENV DEBIAN_FRONTEND noninteractive

# set the locale
# this avoids encoding problems in various apps
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# solves docker/docker#9299
ENV TERM=xterm

# replace sh with bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# install essentials to most images
RUN apt-get update && \
    apt-get install -y wget curl vim && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install docker-gen and dockerize
# NOTE that docker-gen requires mounting the docker api socket, READ-ONLY mode:
# docker run -v /var/run/docker.sock:/tmp/docker.sock:ro ...
ENV DOCKER_GEN_VERSION 0.4.3
ENV DOCKERIZE_VERSION v0.0.3

ENV DOCKER_GEN_FILE docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz
ENV DOCKERIZE_FILE dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

ENV DOCKER_GEN_URL https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/$DOCKER_GEN_FILE
ENV DOCKERIZE_URL https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/$DOCKERIZE_FILE

RUN wget $DOCKER_GEN_URL $DOCKERIZE_URL && \
    tar -C /usr/local/bin -xvzf $DOCKER_GEN_FILE && tar -C /usr/local/bin -xvzf $DOCKERIZE_FILE && \
    rm $DOCKER_GEN_FILE $DOCKERIZE_FILE

# we do want to treat logs the same in all of our images
# see docker/docker#3639
# VOLUME ["/var/log"]
