# Create a Debile slave.
#
# VERSION   0.1
FROM        debian:sid
MAINTAINER  Clément Schreiner <clement@mux.me>
# OK. Enough about that. Let's take our pristine Debian image and
# add our key.

RUN mkdir -p /srv/debile/
RUN groupadd -r debile && useradd -r -g debile -d /srv/debile debile
RUN chown -R debile:debile /srv/debile

COPY sources.list /etc/apt/
COPY *.deb /tmp/

WORKDIR /tmp

RUN apt-get update && apt-get install -y python python-dput python-firehose adduser python-debian python-requests python-yaml sbuild python-schroot

RUN dpkg -i python-debile*.deb debile-slave*.deb

RUN sbuild-adduser debile

RUN chown -R debile:debile /etc/debile/*

USER debile

COPY slave-keys.tar.gz /tmp/

RUN sh -c "tar xvf slave-keys.tar.gz -O | gpg --import --status-fd 1"

CMD debile-slave --debug --simple-auth
