FROM ubuntu:14.04

MAINTAINER tsuru <tsuru@corp.globo.com>
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys B0DE9C5DEBF486359EB255B03B0153D0383F073D
RUN echo "deb http://ppa.launchpad.net/tsuru/ppa/ubuntu trusty main"  > /etc/apt/sources.list.d/tsuru.list
RUN apt-get update
RUN apt-get install -y node-hipache redis-server patch

RUN echo DAEMON_ARGS=/data/router/redis.conf > /etc/default/redis-server

EXPOSE      8080

COPY ./run.sh /bin/run.sh
RUN chmod +x /bin/run.sh

ENTRYPOINT ["/bin/run.sh"]
