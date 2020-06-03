FROM debian:stable-slim

COPY scripts/dev/go.sh /etc/profile.d/go.sh

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		build-essential \
		ca-certificates \
		curl \
		gccgo \
		git \
		iproute2 \
		iptables \
		iputils-ping \
		less \
		procps \
		sqlite3 \
		vim \
		wget \
	&& mkdir /root/.ssh

########## Dapper Configuration #####################
ENV DAPPER_RUN_ARGS --name metadata_dev
ENV DAPPER_SOURCE /go/src/github.com/kassisol/metadata
ENV SHELL /bin/bash

WORKDIR ${DAPPER_SOURCE}

########## General Configuration #####################
ARG DAPPER_HOST_ARCH=amd64
ARG HOST_ARCH=${DAPPER_HOST_ARCH}
ARG ARCH=${HOST_ARCH}

# Set up environment and export all ARGS as ENV
ENV ARCH=${ARCH} \
	HOST_ARCH=${HOST_ARCH}

ENV DAPPER_HOST_ARCH=${DAPPER_HOST_ARCH} \
	GOPATH=/go \
	GOARCH=$ARCH \
	GO_VERSION=1.9

ENV PATH=$PATH:/usr/local/go/bin:/go/bin

# Install dotfiles
RUN git clone https://github.com/juliengk/dot-files /root/Dotfiles \
	&& mkdir /root/bin \
	&& wget https://raw.githubusercontent.com/juliengk/dotfiles/master/misc/get-dotfiles.sh -O /root/bin/get-dotfiles.sh \
	&& chmod +x /root/bin/get-dotfiles.sh \
	&& /root/bin/get-dotfiles.sh \
	&& /root/bin/dotfiles -sync -force

# Install Go
RUN curl -sfL https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz | tar -xzC /usr/local

# Install govendor
RUN go get -u github.com/kardianos/govendor

# Install Golint
RUN go get -u github.com/golang/lint/golint
