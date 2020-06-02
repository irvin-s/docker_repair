FROM ubuntu:16.04
MAINTAINER Terry Chen <seterrychen@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV RESYNC_PERIOD 12h

RUN apt-get update \
  && apt-get install --no-install-recommends -y apt-mirror apache2 \
  && mv /etc/apt/mirror.list / \
  && apt-get autoclean \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 80
COPY setup.sh /setup.sh

VOLUME ["/var/spool/apt-mirror"]
CMD ["/bin/bash", "setup.sh"]
