FROM debian:jessie
MAINTAINER Clément Schreiner <clement@mux.me>

RUN adduser --disabled-password --gecos '' --home /srv/debile debile
VOLUME /etc/debile
FROM debian:jessie
MAINTAINER Clément Schreiner <clement@mux.me>

RUN groupadd -r debile && useradd -r -g debile -d /srv/debile debile

COPY sources.list /etc/apt/

COPY *.deb /tmp/debile/

WORKDIR /tmp/debile


RUN apt-get update && apt-get install -y python python2.7 python-sqlalchemy python-debian python-requests python-yaml adduser python-firehose python-firewoes
RUN dpkg -i python-firewoes*.deb python-debile*.deb debile-master*.deb

COPY master.yaml /etc/debile/
COPY debile.yaml /etc/debile/

USER debile

EXPOSE 22017

CMD debile-master --auth simple --debug
