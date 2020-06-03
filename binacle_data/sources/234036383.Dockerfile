FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
	&& apt-get install -y git bash make python2.7 sqlite3

VOLUME /build
