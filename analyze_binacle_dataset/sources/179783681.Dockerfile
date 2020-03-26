FROM ubuntu:latest

MAINTAINER Roman Krivetsky <r.krivetsky@gmail.com>

ADD https://github.com/syncthing/discosrv/releases/download/standalone/discosrv-linux-amd64.tar.gz /tmp/

RUN	mkdir /opt/discosrv && \
	tar -zxf /tmp/discosrv-linux-amd64.tar.gz -C /opt/discosrv --strip-components 1 && \
	ln -s /opt/discosrv/discosrv /usr/local/bin

EXPOSE 22026

CMD discosrv
