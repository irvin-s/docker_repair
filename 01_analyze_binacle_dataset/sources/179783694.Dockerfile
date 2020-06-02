FROM ubuntu:latest

MAINTAINER Roman Krivetsky <r.krivetsky@gmail.com>

LABEL version="0.12.11"

ADD https://github.com/syncthing/syncthing/releases/download/v0.12.11/syncthing-linux-amd64-v0.12.11.tar.gz /tmp/

RUN mkdir /opt/syncthing && \
	tar -zxf /tmp/syncthing-linux-amd64-v0.12.11.tar.gz -C /opt/syncthing  --strip-components 1 && \
	ln -s /opt/syncthing/syncthing /usr/local/bin

EXPOSE 8384 22000

VOLUME /root

WORKDIR /root

CMD syncthing
