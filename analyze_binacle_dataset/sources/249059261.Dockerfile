FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%alpine:%%DOCKER_TAG%%

ENV HARBOR_COMPONENT="elasticsearch" \
    ELASTICSEARCH_VERSION="5.0.0-rc1" \
    ELASTICSEARCH_ROOT="/usr/share/elasticsearch" \
    PATH="/usr/share/elasticsearch/bin:$PATH" \
    JAVA_HOME="/usr/lib/jvm/java-1.8-openjdk"

# Download/extract defined ES version. busybox tar can't strip leading dir.
RUN set -e && \
    set -x && \
    apk add --no-cache --virtual run-deps \
        openjdk8 \
        openssl && \
    adduser -D -u 1000 -h ${ELASTICSEARCH_ROOT} elasticsearch && \
    cd ${ELASTICSEARCH_ROOT} && \
      wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz && \
      EXPECTED_SHA=$(wget -O - https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz.sha1) && \
      test $EXPECTED_SHA == $(sha1sum elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz | awk '{print $1}') && \
      tar zxf elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz && \
      chown -R elasticsearch:elasticsearch elasticsearch-${ELASTICSEARCH_VERSION} && \
      mv elasticsearch-${ELASTICSEARCH_VERSION}/* . && \
      rmdir elasticsearch-${ELASTICSEARCH_VERSION} && \
      rm elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz && \
      for esdirs in config/scripts data logs; do \
          mkdir -p "$esdirs"; \
          chown -R elasticsearch:elasticsearch "$esdirs"; \
      done

USER elasticsearch

RUN set -e && \
    set -x && \
    cd ${ELASTICSEARCH_ROOT} && \
    elasticsearch-plugin install --batch x-pack

USER root
    
COPY ./common-assets /opt/harbor/common-assets

COPY ./assets /opt/harbor/assets

RUN set -e && \
    set -x && \
    cp -rfav /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets && \
    cp -rfav /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets && \
    cd ${ELASTICSEARCH_ROOT} && \
      for esdirs in config data logs; do \
         chown -R elasticsearch:elasticsearch "$esdirs"; \
      done && \
      chown elasticsearch:elasticsearch ./bin/es-docker && \
      chmod 0750 ./bin/es-docker

USER elasticsearch

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
