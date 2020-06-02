FROM ubuntu:xenial

LABEL Description="Spiffe nginx integration"
LABEL vendor="SPIFFE"
LABEL version="0.5.0"

ARG DEBUG
ARG SPIRE_GOOPTS

ENV DEBUG        "$DEBUG"
ENV SPIRE_GOOPTS "$SPIRE_GOOPTS"

RUN apt-get update && apt-get -y install \
    curl unzip git build-essential autoconf automake dh-autoreconf libtool pkg-config g++ \
    nano emacs vim

ENV GOPATH=/root/go

# Copy nginx local configurations
COPY configurations /usr/local/nginx/

# Install spire
COPY spire /tmp
WORKDIR /tmp
RUN ./install_spire.sh

# Install spiffe-nginx
COPY nginx /tmp
WORKDIR /tmp
RUN ./install_nginx.sh

WORKDIR /opt/spiffe-nginx