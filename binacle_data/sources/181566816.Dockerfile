FROM golang

MAINTAINER Giorgos Papaefthymiou <george.yord@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN go get github.com/schachmat/wego

ADD bin/.wegorc /root/.wegorc
ADD bin/init.sh /init.sh
RUN chmod +x /init.sh

WORKDIR /root

ENTRYPOINT ["/init.sh"]