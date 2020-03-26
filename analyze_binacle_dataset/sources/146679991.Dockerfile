FROM debian:jessie
MAINTAINER Clément Schreiner <clement@mux.me>

RUN mkdir -p /srv/debile/
RUN groupadd -r debile && useradd -r -g debile -d /srv/debile debile

RUN mkdir -p /srv/debile/incoming/UploadQueue /srv/debile/files/default /srv/debile/repo/default
RUN mkdir -p /srv/debile/repo/default/conf /srv/debile/repo/default/logs

COPY reprepo-conf/* /srv/debile/repo/default/conf/

RUN chown -R debile:debile /srv/debile

USER debile

COPY master-keys.tar.gz /tmp/

WORKDIR /tmp

RUN sh -c "tar xvf master-keys.tar.gz -O | gpg --import --status-fd 1"

WORKDIR /srv/debile

VOLUME /srv/debile

CMD echo Data-only container for debile-master
