FROM ubuntu:xenial

RUN apt-get update \
  && apt-get install -y --no-install-recommends ca-certificates curl tar gzip vim

# Install Spire Server
ARG SPIRE_RELEASE="https://storage.googleapis.com/spiffe-example/java-spiffe-federation-demo/spire.tar.gz"
ARG SPIRE_DIR=/opt/spire

RUN curl --silent --location $SPIRE_RELEASE | tar -xzf -
RUN mv spire ${SPIRE_DIR}

WORKDIR ${SPIRE_DIR}

