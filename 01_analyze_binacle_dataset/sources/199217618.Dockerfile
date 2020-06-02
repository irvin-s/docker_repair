FROM ubuntu:latest

MAINTAINER Hugh Cannon <hugh@hughcannon.com>

RUN apt-get update &&\
  apt-get install -y curl && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /factorio
RUN curl -L -k https://www.factorio.com/get-download/0.13.20/headless/linux64 | tar --strip-components=1 -xzf -

VOLUME ["/factorio/saves"]
VOLUME ["/factorio/mods"]

EXPOSE 34197/udp

COPY start start

ENTRYPOINT ["./start"]
