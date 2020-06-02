FROM ubuntu:12.04
MAINTAINER callbacknull <callbacknull@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
EXPOSE 53/udp

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y pdns-backend-pipe
RUN apt-get clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

COPY pdns.conf /etc/pdns/pdns.conf
COPY xip /root/xip

CMD ["pdns_server", "--config-dir=/etc/pdns"]
