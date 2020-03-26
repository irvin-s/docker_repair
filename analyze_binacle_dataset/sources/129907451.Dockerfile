FROM gcr.io/google-appengine/openjdk:8

# add gosu for easy step-down from root
ENV GOSU_VERSION 1.10

RUN apt-get update
RUN apt-get install -f -y

RUN apt-get install -y gnupg2 \
      && rm -rf /var/lib/apt/lists/*~

RUN set -x \
    && wget -q -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
    && wget -q -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
# copy source code
  && wget -q -O /usr/local/src/gosu.tar.gz "https://github.com/tianon/gosu/archive/$GOSU_VERSION.tar.gz" \
# extract gosu binary and check signature
  && export GNUPGHOME="$(mktemp -d)" \
  && gpg --keyserver hkp://pgp.mit.edu:80 --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
  && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
  && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
  && chmod +x /usr/local/bin/gosu \
  && gosu nobody true

# Install Elastic Search
RUN set -ex; \
# https://artifacts.elastic.co/GPG-KEY-elasticsearch
  key='46095ACC8548582C1A2699A9D27D666CD88E42B4'; \
  export GNUPGHOME="$(mktemp -d)"; \
  gpg --keyserver hkp://pgp.mit.edu:80 --recv-keys "$key"; \
  gpg --export "$key" > /etc/apt/trusted.gpg.d/elastic.gpg; \
  rm -r "$GNUPGHOME"; \
  apt-key list

# https://www.elastic.co/guide/en/elasticsearch/reference/current/setup-repositories.html
RUN set -x \
    && apt-get update && apt-get install -y --no-install-recommends apt-transport-https && rm -rf /var/lib/apt/lists/* \
    && echo 'deb https://artifacts.elastic.co/packages/5.x/apt stable main' > /etc/apt/sources.list.d/elasticsearch.list

ENV ELASTICSEARCH_VERSION 5.6.1
ENV ELASTICSEARCH_DEB_VERSION 5.6.1

# copy source code
RUN wget -q https://github.com/elastic/elasticsearch/archive/v5.6.1.tar.gz -O /usr/local/src/elasticsearch-source-v5.6.1.tar.gz

RUN set -x \
# don't allow the package to install its sysctl file (causes the install to fail)
# Failed to write '262144' to '/proc/sys/vm/max_map_count': Read-only file system
  && dpkg-divert --rename /usr/lib/sysctl.d/elasticsearch.conf \
  && apt-get update \
  && apt-get install -y --no-install-recommends "elasticsearch=$ELASTICSEARCH_DEB_VERSION" \
  && apt-get install -y iputils-ping net-tools \
  && rm -rf /var/lib/apt/lists/*


ENV PATH /usr/share/elasticsearch/bin:$PATH

WORKDIR /usr/share/elasticsearch

COPY config ./config

RUN set -ex \
    && for path in \
    ./data \
    ./logs \
    ./config \
     /usr/share/elasticsearch \
    ./config/scripts \
    ; do \
    mkdir -p "$path"; \
    chown -R elasticsearch:elasticsearch "$path"; \
    done

VOLUME /usr/share/elasticsearch/data

COPY docker-entrypoint.sh /

EXPOSE 9200 9300
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]