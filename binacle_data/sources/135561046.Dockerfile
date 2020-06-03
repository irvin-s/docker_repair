FROM ubuntu:14.04
MAINTAINER Michal Raczka me@michaloo.net

WORKDIR /app

ENTRYPOINT [ "/bin/bash" ]
CMD [ "/app/bin/start" ]

# configure default environment variables
ENV ES_HOST localhost
ENV ES_PORT 9200
ENV LOG_ENV production
ENV DOCKER_HOST unix:///tmp/docker.sock

# add startup scripts and config files
COPY ./bin    /app/bin
COPY ./config /app/config

RUN set -x  && \
    apt-get -q update && \
    apt-get -qy install \
      curl \
      libcurl4-openssl-dev \
      make \
      ruby \
      ruby-dev && \
    \
    gem install -q --no-ri --no-rdoc \
      fluentd && \
    fluent-gem install -q \
      fluent-plugin-elasticsearch \
      fluent-plugin-exclude-filter \
      fluent-plugin-record-modifier && \
    mkdir /etc/fluentd && \
    \
    cd /usr/local/bin && \
    curl -sSL https://github.com/jwilder/docker-gen/releases/download/0.4.2/docker-gen-linux-amd64-0.4.2.tar.gz | tar -xzv

