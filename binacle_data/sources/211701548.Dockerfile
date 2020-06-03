FROM ubuntu:15.10
MAINTAINER Ken Jenney <mastermindg@gmail.com>

ENV DEBIAN_FRONTEND="noninteractive" \
    TERM="xterm"

ADD ./start.sh /start-slave.sh

CMD ["/start-slave.sh"]
