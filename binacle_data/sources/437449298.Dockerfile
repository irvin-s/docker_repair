FROM ubuntu:12.04
MAINTAINER ModCloth Platform Sphere <platform@modcloth.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -yq && \
  apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A && \
  echo 'deb http://repo.percona.com/apt precise main' >> /etc/apt/sources.list && \
  echo 'deb-src http://repo.percona.com/apt precise main' >> /etc/apt/sources.list && \
  apt-get update -yq

EXPOSE 3306
