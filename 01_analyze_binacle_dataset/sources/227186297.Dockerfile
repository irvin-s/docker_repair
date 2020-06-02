FROM openjdk:jre

# grab gosu for easy step-down from root
# Add a non-root user to prevent files being created with root permissions on host machine.
ARG PUID=1000
ARG PGID=1000
RUN groupadd -g $PGID elasticsearch && \
    useradd -u $PUID -g elasticsearch -m elasticsearch

ENV GOSU_VERSION 1.7
RUN set -x \
  && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
  && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
  && export GNUPGHOME="$(mktemp -d)" \
  && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
  && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
  && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
  && chmod +x /usr/local/bin/gosu \
  && gosu nobody true

############################################
# Install basic utils
############################################

RUN apt-get update && apt-get install -y --no-install-recommends wget unzip sudo && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN cd /tmp \
  && wget -c 'https://github.com/medcl/elasticsearch-rtf/archive/master.zip' \
  && unzip master.zip

RUN mv /tmp/elasticsearch-rtf-master /usr/share/elasticsearch/

ENV PATH /usr/share/elasticsearch/bin:$PATH

WORKDIR /usr/share/elasticsearch

RUN set -ex \
  && for path in \
    ./data \
    ./logs \
    ./config \
    ./config/scripts \
  ; do \
    mkdir -p "$path"; \
    chown -R elasticsearch:elasticsearch "$path"; \
  done

RUN chown -R elasticsearch:elasticsearch /usr/share/elasticsearch

RUN echo "network.host: 0.0.0.0" >> /usr/share/elasticsearch/config/elasticsearch.yml
RUN echo "http.port: 9200" >> /usr/share/elasticsearch/config/elasticsearch.yml
RUN echo "http.host: 0.0.0.0" >> /usr/share/elasticsearch/config/elasticsearch.yml


VOLUME /usr/share/elasticsearch/data
VOLUME /usr/share/elasticsearch/logs

COPY docker-entrypoint-rtf.sh /

RUN apt-get clean \
  && rm -rf /tmp/* /var/tmp/*

USER elasticsearch

EXPOSE 9200 9300

# ENTRYPOINT ["/docker-entrypoint-rtf.sh"]
# CMD ["ES_JAVA_OPTS='-Xms2024m -Xmx2024m' /usr/share/elasticsearch/bin/elasticsearch -d"]
# CMD ["sudo -u elasticsearch /usr/share/elasticsearch/bin/elasticsearch"]
# CMD ["elasticsearch"]
CMD ["elasticsearch"]
