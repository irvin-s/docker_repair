FROM ubuntu:16.04

ENV CONFD_VERSION  0.14.0
ARG DCOS_URL
ENV DCOS_URL $DCOS_URL
ENV DCOS_NAME dcos_generate_config.sh

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
  echo "deb http://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list && \
  apt-get update && \
  apt-get install curl docker-engine python-pip jq -y && \
  pip install awscli

RUN mkdir -p /usr/local/bin/ && \
  curl -L -o /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 && \
  chmod +x /usr/local/bin/confd

ARG SOURCE_DIR
RUN mkdir -p $SOURCE_DIR

WORKDIR $SOURCE_DIR
RUN curl -o $DCOS_NAME $DCOS_URL

COPY . $SOURCE_DIR

COPY entrypoint.sh /entrypoint.sh
ENV SOURCE_DIR $SOURCE_DIR

ENTRYPOINT ["/entrypoint.sh"]
