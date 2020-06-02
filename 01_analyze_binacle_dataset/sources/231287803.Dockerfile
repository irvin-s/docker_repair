FROM ubuntu:16.04
# FROM arm64=aarch64/ubuntu:16.04 arm=armhf/ubuntu:16.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        gccgo \
        git \
        vim \
        wget

########## Dapper Configuration #####################

ENV DAPPER_ENV VERSION DEV_BUILD RUNTEST APTPROXY
ENV DAPPER_DOCKER_SOCKET true
ENV DAPPER_SOURCE /go/src/github.com/rancher/strato
ENV DAPPER_OUTPUT ./bin ./dist
ENV DAPPER_RUN_ARGS --privileged
ENV TRASH_CACHE ${DAPPER_SOURCE}/.trash-cache
ENV SHELL /bin/bash
WORKDIR ${DAPPER_SOURCE}

########## General Configuration #####################

ARG DAPPER_HOST_ARCH=amd64
ARG HOST_ARCH=${DAPPER_HOST_ARCH}
ARG ARCH=${HOST_ARCH}

ARG DOCKER_BUILD_VERSION=1.10.3
ARG DOCKER_BUILD_PATCH_VERSION=v${DOCKER_BUILD_VERSION}-ros1

ARG BUILD_DOCKER_URL_amd64=https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_BUILD_VERSION}
ARG BUILD_DOCKER_URL_arm=https://github.com/rancher/docker/releases/download/${DOCKER_BUILD_PATCH_VERSION}/docker-${DOCKER_BUILD_VERSION}_arm
ARG BUILD_DOCKER_URL_arm64=https://github.com/rancher/docker/releases/download/${DOCKER_BUILD_PATCH_VERSION}/docker-${DOCKER_BUILD_VERSION}_arm64

######################################################

# Set up environment and export all ARGS as ENV
ENV ARCH=${ARCH} \
    HOST_ARCH=${HOST_ARCH}

ENV BUILD_DOCKER_URL=BUILD_DOCKER_URL_${ARCH} \
    BUILD_DOCKER_URL_amd64=${BUILD_DOCKER_URL_amd64} \
    BUILD_DOCKER_URL_arm=${BUILD_DOCKER_URL_arm} \
    BUILD_DOCKER_URL_arm64=${BUILD_DOCKER_URL_arm64} \
    DAPPER_HOST_ARCH=${DAPPER_HOST_ARCH} \
    DOWNLOADS=/usr/src/downloads \
    GOPATH=/go \
    GO_VERSION=1.7.1 \
    GOARCH=$ARCH
ENV PATH=${GOPATH}/bin:/usr/local/go/bin:$PATH

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN mkdir -p ${DOWNLOADS}

# Install Go
RUN ln -sf go-6 /usr/bin/go && \
    curl -sfL https://storage.googleapis.com/golang/go${GO_VERSION}.src.tar.gz | tar -xzf - -C /usr/local && \
    cd /usr/local/go/src && \
    GOROOT_BOOTSTRAP=/usr GOARCH=${HOST_ARCH} GOHOSTARCH=${HOST_ARCH} ./make.bash && \
    rm /usr/bin/go

# Install Host Docker
RUN curl -fL ${!BUILD_DOCKER_URL} > /usr/bin/docker && \
    chmod +x /usr/bin/docker

# Install Trash
RUN go get github.com/rancher/trash

# Install golint
RUN go get github.com/golang/lint/golint

RUN go get gopkg.in/check.v1

# Install dapper
RUN curl -sL https://releases.rancher.com/dapper/latest/dapper-`uname -s`-`uname -m | sed 's/arm.*/arm/'` > /usr/bin/dapper && \
    chmod +x /usr/bin/dapper

ENTRYPOINT ["./scripts/entry"]
CMD ["ci"]
