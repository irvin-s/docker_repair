# vim:set ft=dockerfile:
FROM ubuntu:14.04
MAINTAINER temrdm

RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository multiverse

RUN apt-get update
RUN apt-get install -y unixodbc libgsf-1-114 imagemagick libglib2.0-dev libt1-5 t1utils ttf-mscorefonts-installer

RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/* \
	&& curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
	&& curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& apt-get purge -y --auto-remove curl

RUN apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i ru_RU -c -f UTF-8 -A /usr/share/locale/locale.alias ru_RU.UTF-8

ENV LANG ru_RU.utf8

ENV SERVER_1C_VERSION 8.3.6-2299
ENV SERVER_1C_ARCH amd64
ENV DIST_SERVER_1C ./dist/

ADD ${DIST_SERVER_1C} /opt/

RUN if [ ! -f /opt/1c-enterprise83-common_${SERVER_1C_VERSION}_${SERVER_1C_ARCH}.deb ]; then \
    echo File 1c-enterprise83-common_${SERVER_1C_VERSION}_${SERVER_1C_ARCH}.deb does not exist.; \
    echo "DIST_SERVER_1C set incorrectly. See README.md file."; \
    exit 1; fi

RUN if [ ! -f /opt/1c-enterprise83-server_${SERVER_1C_VERSION}_${SERVER_1C_ARCH}.deb ]; then \
    echo File 1c-enterprise83-server_${SERVER_1C_VERSION}_${SERVER_1C_ARCH}.deb does not exist.; \
    echo "DIST_SERVER_1C set incorrectly. See README.md file."; \
    exit 1; fi

RUN dpkg -i /opt/1c-enterprise83-common_${SERVER_1C_VERSION}_${SERVER_1C_ARCH}.deb \
            /opt/1c-enterprise83-server_${SERVER_1C_VERSION}_${SERVER_1C_ARCH}.deb

RUN mkdir -p /opt/1C/v8.3/x86_64/conf/
COPY logcfg.xml /opt/1C/v8.3/x86_64/conf/
RUN chown -R usr1cv8:grp1cv8 /opt/1C

RUN mkdir -p /var/log/1c/dumps/
RUN chown -R usr1cv8:grp1cv8 /var/log/1c/
RUN chmod 755 /var/log/1c

VOLUME /home/usr1cv8/
VOLUME /var/log/1c

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 1540-1541 1560-1591

CMD ["ragent"]
