FROM fellah/ubuntu:latest

MAINTAINER Roman Krivetsky <r.krivetsky@gmail.com>

ARG version=0.12.22

LABEL version=$version

USER root

ADD https://github.com/syncthing/syncthing/releases/download/v${version}/syncthing-linux-amd64-v${version}.tar.gz /tmp/

RUN mkdir /opt/syncthing && \
	tar -zxf /tmp/syncthing-linux-amd64-v${version}.tar.gz -C /opt/syncthing  --strip-components 1 && \
	ln -s /opt/syncthing/syncthing /usr/local/bin

EXPOSE 8384 22000

USER fellah

WORKDIR /home/fellah

CMD syncthing
