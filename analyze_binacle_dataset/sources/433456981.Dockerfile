FROM ubuntu:18.04

ADD ./setup.sh /tmp/setup.sh

RUN bash /tmp/setup.sh
