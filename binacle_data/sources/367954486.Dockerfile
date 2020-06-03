# Dockerfile for building an image with ubuntu xenial
FROM sociomantictsunami/develbase
MAINTAINER andreas-bok-sociomantic <andreas.bok@sociomantic.com>

RUN export DEBIAN_FRONTEND=noninteractive

# delete all the apt list files to speed up 'apt-get update' command
RUN rm -rf /var/lib/apt/lists/*

# add apt repository for apt-fast
RUN add-apt-repository ppa:apt-fast/stable

RUN apt-get update
RUN apt-get install --no-install-recommends -y apt-fast

# install required packages
RUN apt-fast -y install --no-install-recommends \
    libssl-dev autoconf libtool make automake zlib1g-dev api-sanity-checker
