FROM openjdk:jdk

# grab gosu for easy step-down from root
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

RUN set -ex; \
# https://artifacts.elastic.co/GPG-KEY-elasticsearch
  key='46095ACC8548582C1A2699A9D27D666CD88E42B4'; \
  export GNUPGHOME="$(mktemp -d)"; \
  gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  gpg --export "$key" > /etc/apt/trusted.gpg.d/elastic.gpg; \
  rm -r "$GNUPGHOME"; \
  apt-key list

# https://www.elastic.co/guide/en/elasticsearch/reference/current/setup-repositories.html
# https://www.elastic.co/guide/en/elasticsearch/reference/5.0/deb.html
RUN set -x \
  && apt-get update && apt-get install -y --no-install-recommends apt-transport-https wget unzip maven && rm -rf /var/lib/apt/lists/* \
  && echo 'deb https://artifacts.elastic.co/packages/5.x/apt stable main' > /etc/apt/sources.list.d/elasticsearch.list

ENV ELASTICSEARCH_VERSION 5.2.2
ENV ELASTICSEARCH_DEB_VERSION 5.2.2

RUN set -x \
  \
# don't allow the package to install its sysctl file (causes the install to fail)
# Failed to write '262144' to '/proc/sys/vm/max_map_count': Read-only file system
  && dpkg-divert --rename /usr/lib/sysctl.d/elasticsearch.conf \
  \
  && apt-get update \
  && apt-get install -y --no-install-recommends "elasticsearch=$ELASTICSEARCH_DEB_VERSION" \
  && rm -rf /var/lib/apt/lists/*

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

COPY settings ./config

VOLUME /usr/share/elasticsearch/data

COPY docker-entrypoint.sh /



#RUN apt-get update && \
#  apt-get install -y --no-install-recommands wget unzip && \
#  wget -c "https://github.com/medcl/elasticsearch-analysis-ik/archive/master.zip" && \
#  unzip master.zip && \

# Add x-pack plugin
# RUN bin/elasticsearch-plugin install x-pack --batch

# Add ICU analysis plugin <https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-icu.html>
RUN bin/elasticsearch-plugin install analysis-icu

# Add Chinese analysis plugin <https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-smartcn.html>
RUN bin/elasticsearch-plugin install analysis-smartcn

# Add Japanese (kuromoji) analysis plugin <https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-kuromoji.html>
RUN bin/elasticsearch-plugin install analysis-kuromoji

# Add phonetic analysis plugin <https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-phonetic.html#analysis-phonetic-install>
RUN bin/elasticsearch-plugin install analysis-phonetic

# RUN bin/elasticsearch-plugin install discovery-multicast

RUN bin/elasticsearch-plugin install analysis-stempel

RUN bin/elasticsearch-plugin install analysis-ukrainian

RUN bin/elasticsearch-plugin install discovery-file

RUN bin/elasticsearch-plugin install ingest-attachment

# RUN bin/elasticsearch-plugin install ingest-geoip

RUN bin/elasticsearch-plugin install ingest-user-agent

RUN bin/elasticsearch-plugin install mapper-attachments

RUN bin/elasticsearch-plugin install mapper-size

RUN bin/elasticsearch-plugin install mapper-murmur3

RUN bin/elasticsearch-plugin install lang-javascript

RUN bin/elasticsearch-plugin install lang-python

RUN  bin/elasticsearch-plugin install repository-hdfs

RUN bin/elasticsearch-plugin install repository-s3

RUN bin/elasticsearch-plugin install repository-azure

RUN bin/elasticsearch-plugin install repository-gcs

RUN bin/elasticsearch-plugin install store-smb

RUN bin/elasticsearch-plugin install discovery-ec2

RUN bin/elasticsearch-plugin install discovery-azure-classic

RUN bin/elasticsearch-plugin install discovery-gce


######################################
# install Chinese ik analyzer
# <http://www.cnblogs.com/hunttown/p/5450635.html>
######################################

# COPY analysis-ik /usr/share/elasticsearch/plugins
#COPY extend.yml /tmp
COPY config /tmp/config

RUN cd /tmp \
 && wget -c https://github.com/medcl/elasticsearch-analysis-ik/archive/master.zip \
 && unzip master.zip

RUN cd /tmp/elasticsearch-analysis-ik-master \
 && mvn package

RUN unzip /tmp/elasticsearch-analysis-ik-master/target/releases/elasticsearch-analysis-ik-5.2.2.zip -d /usr/share/elasticsearch/plugins/ik

#RUN echo 'index.analysis.analyzer.ik.type : "analysis-ik"' >> /usr/share/elasticsearch/config/elasticsearch.yml

#RUN cat /tmp/extend.yml >> /usr/share/elasticsearch/config/elasticsearch.yml
# RUN cp /usr/share/elasticsearch/plugins/ik/http*.jar /usr/share/elasticsearch/lib

RUN cp -rf /tmp/config/* /usr/share/elasticsearch/plugins/ik/config/

####################################
# clean cache and tmp files
####################################

RUN apt-get clean \
  && rm -rf /tmp/* /var/tmp/*

EXPOSE 9200 9300
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]
