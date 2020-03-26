FROM ubuntu:18.04

MAINTAINER Szabo Bogdan <szabobogdan3@gmail.com>

COPY trial /usr/local/bin

WORKDIR /src

RUN apt-get update \
  && apt-get install -y libssl1.0-dev libevent-dev libcurl4 gcc wget libc6-dev \
  && cd /tmp/ \
  && wget http://downloads.dlang.org/releases/2.x/2.083.0/dmd_2.083.0-0_amd64.deb \
  && dpkg -i dmd_2.083.0-0_amd64.deb

# Trial version
RUN trial --version
