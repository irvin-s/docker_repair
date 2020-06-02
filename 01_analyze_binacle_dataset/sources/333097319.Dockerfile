FROM jenkins/jenkins:latest
MAINTAINER Pit Kleyersburg <pitkley@googlemail.com>

USER root

ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.10.3
ENV DOCKER_SHA256 d0df512afa109006a450f41873634951e19ddabf8c7bd419caeb5a526032d86d

RUN curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-$DOCKER_VERSION" -o /usr/local/bin/docker-standalone \
    && echo "${DOCKER_SHA256}  /usr/local/bin/docker-standalone" | sha256sum -c - \
    && chmod +x /usr/local/bin/docker-standalone

RUN apt-get update \
    && apt-get install -y sudo \
    && rm -rf /var/lib/apt/lists/*

RUN echo "jenkins ALL=NOPASSWD: /usr/local/bin/docker-standalone *" >> /etc/sudoers
COPY docker /usr/bin/docker

USER jenkins
