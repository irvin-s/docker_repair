FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install apt-utils -y

RUN apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    file \
    ftp \
    git \
    gnupg \
    iproute2 \
    iputils-ping \
    locales \
    lsb-release \
    sudo \
    time \
    unzip \
    wget \
    zip \
&& rm -rf /var/lib/apt/lists/*

# Instal Docker
ENV DOCKER_VERSION 18.03.1-ce
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz \
    && tar --strip-components=1 -xvzf docker-18.03.1-ce.tgz -C /usr/local/bin
RUN rm docker-$DOCKER_VERSION.tgz

# Install kubectl
ENV KUBE_VERSION 1.6.4
RUN curl -fsSLO https://storage.googleapis.com/kubernetes-release/release/v$KUBE_VERSION/bin/linux/amd64/kubectl \
    && mv kubectl /usr/local/bin && chmod 755 /usr/local/bin/kubectl
