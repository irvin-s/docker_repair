FROM debian

MAINTAINER Giorgos Papaefthymiou <george.yord@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qqy update && \
    apt-get -qqy install curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV HEARTBEAT_CYCLE=60

ADD bin/init.sh /init.sh
RUN chmod +x /init.sh

ENTRYPOINT ["/init.sh"]
