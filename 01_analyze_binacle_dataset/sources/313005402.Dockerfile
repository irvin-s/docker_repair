FROM golang:1.12.5
LABEL name=mesosphere/dklb-ci
ARG VERSION
LABEL version=${VERSION}

ENV HOME=/tmp

ENV DOCKER_VERSION 18.09.5
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz | \
    tar xz -C /usr/bin --strip-components=1 docker/docker

RUN apt-get update && apt-get install -y \
    python-dev \
    python3 \
    python3-pip \
    locales && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/*

# Set UTF8 locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen ; \
    dpkg-reconfigure --frontend=noninteractive locales ; \
    update-locale LANG=en_US.UTF-8

# these variables can only be set after locales are installed and generated
# otherwise we will get warnings in build-time and run-time
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN pip3 install pre-commit

ENV DCOS_CLI_VERSION dcos-1.13
RUN curl -fsSLo /usr/local/bin/dcos https://downloads.dcos.io/binaries/cli/linux/x86-64/$DCOS_CLI_VERSION/dcos && \
    chmod +x /usr/local/bin/dcos

ENV SKAFFOLD_VERSION v0.30.0
RUN curl -fsSLo /usr/local/bin/skaffold https://storage.googleapis.com/skaffold/releases/$SKAFFOLD_VERSION/skaffold-linux-amd64 && \
    chmod +x /usr/local/bin/skaffold

ENV JQ_VERSION 1.6
RUN curl -fsSLo /usr/local/bin/jq https://github.com/stedolan/jq/releases/download/jq-$JQ_VERSION/jq-linux64 && \
    chmod +x /usr/local/bin/jq

ENV KUBECTL_VERSION v1.14.2
RUN curl -fsSLo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl && \
    chmod +x /usr/local/bin/kubectl
