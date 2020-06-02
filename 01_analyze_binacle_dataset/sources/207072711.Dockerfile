FROM unocha/alpine-jdk:8

MAINTAINER Peter Lieverdink <peterl@humanitarianresponse.info>

# Based on the solr6 Dockerfile.

# Parse arguments for the build command.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

# A little bit of metadata management.
# See http://label-schema.org/
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="alpine-zookeeper" \
      org.label-schema.description="This service provides a stand-alone zookeeper platform." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.4" \
      info.humanitarianresponse.zookeeper=$VERSION

ENV ZOOKEEPER_VERSION=$VERSION \
    ZOOKEEPER=zookeeper-$VERSION

COPY run-zookeeper /

RUN apk add --update-cache \
        bash \
        curl && \
    cd /tmp && \
    echo "Getting zookeeper $ZOOKEEPER_VERSION" >&2 && \
    curl -sSL http://archive.apache.org/dist/zookeeper/$ZOOKEEPER/$ZOOKEEPER.tar.gz -o /tmp/$ZOOKEEPER.tar.gz && \
    curl -sSL http://archive.apache.org/dist/zookeeper/$ZOOKEEPER/$ZOOKEEPER.tar.gz.sha1 -o /tmp/$ZOOKEEPER.tar.gz.sha1 && \
    echo "Checking zookeeper $ZOOKEEPER_VERSION checksum" >&2 && \
    sha1sum -c $ZOOKEEPER.tar.gz.sha1 && \
    mkdir -p /srv && \
    gzip -dc /tmp/$ZOOKEEPER.tar.gz | tar -C /srv -x && \
    ln -sf /srv/$ZOOKEEPER /srv/zookeeper && \
    echo "Cleaning up.." >&2 && \
    apk del curl || true && \
    rm -rf /tmp/* /var/cache/apk/* && \
    mkdir /etc/services.d/zookeeper && \
    mv /run-zookeeper /etc/services.d/zookeeper/run && \
    cd /srv/zookeeper/conf && \
      ln -s zoo_sample.cfg zoo.cfg && \
    sed -i 's/INFO/WARN/' /srv/zookeeper/conf/log4j.properties

EXPOSE 2181

WORKDIR /srv/zookeeper

# Volumes
# - Conf: /srv/zookeeper/conf
#
# Make sure to also map a data volume and point the config at it.
