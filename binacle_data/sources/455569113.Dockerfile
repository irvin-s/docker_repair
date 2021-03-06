# Copy of https://github.com/elastic/elasticsearch-docker/blob/master/build/elasticsearch/Dockerfile
FROM docker.elastic.co/elasticsearch/elasticsearch-alpine-base:latest
MAINTAINER Elastic Docker Team <docker@elastic.co>

ARG ELASTIC_VERSION
ARG ES_DOWNLOAD_URL
ARG ES_JAVA_OPTS
ARG XPACK=x-pack

ENV PATH /usr/share/elasticsearch/bin:$PATH
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

WORKDIR /usr/share/elasticsearch

# Download/extract defined ES version. busybox tar can't strip leading dir.
RUN wget ${ES_DOWNLOAD_URL}/elasticsearch-${ELASTIC_VERSION}.tar.gz && \
    EXPECTED_SHA=$(wget -O - ${ES_DOWNLOAD_URL}/elasticsearch-${ELASTIC_VERSION}.tar.gz.sha1) && \
    test $EXPECTED_SHA == $(sha1sum elasticsearch-${ELASTIC_VERSION}.tar.gz | awk '{print $1}') && \
    tar zxf elasticsearch-${ELASTIC_VERSION}.tar.gz && \
    chown -R elasticsearch:elasticsearch elasticsearch-${ELASTIC_VERSION} && \
    mv elasticsearch-${ELASTIC_VERSION}/* . && \
    rmdir elasticsearch-${ELASTIC_VERSION} && \
    rm elasticsearch-${ELASTIC_VERSION}.tar.gz

RUN set -ex && for esdirs in config data logs; do \
        mkdir -p "$esdirs"; \
        chown -R elasticsearch:elasticsearch "$esdirs"; \
    done

USER elasticsearch

# Install xpack
#RUN eval ${ES_JAVA_OPTS:-} elasticsearch-plugin install --batch ${XPACK}



RUN elasticsearch-plugin install --batch https://staging.elastic.co/5.2.2-9f7879a1/downloads/elasticsearch-plugins/ingest-user-agent/ingest-user-agent-5.2.2.zip
RUN elasticsearch-plugin install --batch https://staging.elastic.co/5.2.2-9f7879a1/downloads/elasticsearch-plugins/ingest-geoip/ingest-geoip-5.2.2.zip

COPY config/elasticsearch.yml config/
COPY config/log4j2.properties config/
COPY bin/es-docker bin/es-docker

USER root
RUN chown elasticsearch:elasticsearch config/elasticsearch.yml config/log4j2.properties bin/es-docker && \
    chmod 0750 bin/es-docker

USER elasticsearch
CMD ["/bin/bash", "bin/es-docker"]

EXPOSE 9200 9300
