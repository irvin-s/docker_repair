# carbonsphere/dock-privoxy with tini
FROM carbonsphere/dock-privoxy
MAINTAINER Odd E. Ebbesen

ENV TINI_VERSION 0.18.0
ENV TINI_GPG_KEY 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7

ADD https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-static /sbin/tini
ADD https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-static.asc /tmp/tini-static.asc
RUN gpg --batch --keyserver hkp://ipv4.pool.sks-keyservers.net:80 --recv-keys $TINI_GPG_KEY
RUN gpg --batch --verify /tmp/tini-static.asc /sbin/tini
RUN chmod 755 /sbin/tini

ENTRYPOINT ["tini", "-g", "--"]
CMD ["run.sh"]
