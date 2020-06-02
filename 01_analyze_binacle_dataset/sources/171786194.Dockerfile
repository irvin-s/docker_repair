FROM debian:wheezy
MAINTAINER Scott Kidder <kidder.scott@gmail.com>

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r aprs && useradd -r -g aprs aprs

RUN apt-get update \
    && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

RUN buildDeps='wget'; \
    set -x \
    && apt-get update && apt-get install -y $buildDeps --no-install-recommends \
    && cd ${HOME} \
    && wget http://www.pakettiradio.net/downloads/libfap/1.3/deb_amd64/libfap-dev_1.3_amd64.deb \
    && wget http://www.pakettiradio.net/downloads/libfap/1.3/deb_amd64/libfap5_1.3_amd64.deb \
    && dpkg -i libfap-dev_1.3_amd64.deb libfap5_1.3_amd64.deb \
    && rm -f libfap-dev_1.3_amd64.deb libfap5_1.3_amd64.deb \
    && apt-get purge -y --auto-remove $buildDeps

RUN mkdir /data && chown aprs:aprs /data
VOLUME /data
WORKDIR /data
COPY docker-entrypoint.sh /entrypoint.sh
COPY bin/aprs-dashboard /aprs-dashboard
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3000
EXPOSE 3100
CMD ["/aprs-dashboard"]
