FROM ubuntu:xenial

ARG SPIRE_VERSION=0.6.0
ARG SPIRE_RELEASE=https://github.com/spiffe/spire/releases/download/${SPIRE_VERSION}/spire-${SPIRE_VERSION}-linux-x86_64-glibc.tar.gz
ARG SPIRE_DIR=/opt/spire

RUN apt-get update \
  && apt-get install -y --no-install-recommends ca-certificates curl tar gzip vim default-jre

RUN curl --silent --location $SPIRE_RELEASE | tar -xzf -
RUN mv spire-${SPIRE_VERSION} ${SPIRE_DIR}

WORKDIR ${SPIRE_DIR}
COPY conf/agent.conf conf/agent/agent.conf
COPY conf/server.conf conf/server/server.conf
COPY create-user.sh .
COPY create-entries.sh .

RUN chmod +x create-entries.sh
