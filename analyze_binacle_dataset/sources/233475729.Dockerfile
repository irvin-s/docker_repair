# From basic elk env
FROM eason02/java:1.8

# Maintainer
MAINTAINER Eason Lau <eason.lau02@hotmail.com>

# Install gosu for step-down from root
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
    curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.9/gosu-amd64" && \
    curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.9/gosu-amd64.asc" && \
    gpg --verify /usr/local/bin/gosu.asc && \
    rm /usr/local/bin/gosu.asc && \
    rm -rf /root/.gnupg/ && \
    chmod +x /usr/local/bin/gosu && \
    gosu nobody true

# Install elasticsearch
RUN set -x && \
    cd ~ && \
    rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.6.3.rpm && \
    sha1sum elasticsearch-5.6.3.rpm && \
    rpm --install elasticsearch-5.6.3.rpm && \
    rm -rf elasticsearch-5.6.3.rpm && \
    mkdir -p /usr/share/elasticsearch/config && \
    mkdir -p /usr/share/elasticsearch/data && \
    mkdir -p /usr/share/elasticsearch/logs && \
    chown elasticsearch:elasticsearch /usr/share/elasticsearch/logs

ENV PATH /usr/share/elasticsearch/bin:$PATH

# COPY ./config /usr/share/elasticsearch/config/

# RUN set -x && \
#    ls -R /usr/share/elasticsearch/config && \
#    cd /usr/share/elasticsearch/config && \
#    chown root:elasticsearch -R *

EXPOSE 9200 9300

VOLUME /usr/share/elasticsearch/data
VOLUME /usr/share/elasticsearch/logs
VOLUME /usr/share/elasticsearch/config
VOLUME /usr/share/elasticsearch/plugins

WORKDIR /usr/share/elasticsearch/bin

COPY docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]
