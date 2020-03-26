# Apache Solr Dockerfile
# https://github.com/bigcontainer/bigcont/solr
FROM centos:7

ARG SOLR_MIRROR https://archive.apache.org/dist/lucene/solr
ARG SOLR_VERSION 6.3.0
ARG SOLR_USER solr
ARG SOLR_UID 8983
ARG SOLR_URL ${SOLR_DOWNLOAD_SERVER}/solr-$SOLR_VERSION.tgz
ENV PATH /opt/solr/bin:/opt/docker/scripts:$PATH
ENV JAVA_VERSION=1.8.0 JAVA_HOME=/usr/lib/jvm/jre

# Java installation
RUN \
  yum install -y java-${JAVA_VERSION}-openjdk

RUN \
    groupadd -r -g $SOLR_UID $SOLR_USER && \
    useradd -r -u $SOLR_UID -g $SOLR_USER $SOLR_USER

RUN \
    curl -L ${SOLR_MIRROR}/${SOLR_VERSION}/solr-${SOLR_VERSION}.tgz -o /tmp/solr-${SOLR_VERSION}.tgz && \
    curl -L ${SOLR_MIRROR}/${SOLR_VERSION}/KEYS -o /tmp/KEYS && \
    curl -L ${SOLR_MIRROR}/${SOLR_VERSION}/solr-${SOLR_VERSION}.tgz.asc -o /tmp/solr-${SOLR_VERSION}.tgz.asc && \
    curl -L ${SOLR_MIRROR}/${SOLR_VERSION}/solr-${SOLR_VERSION}.tgz.md5 -o /tmp/solr-${SOLR_VERSION}.tgz.md5 && \
    cd /tmp && \
    md5sum -c --quiet solr-${SOLR_VERSION}.tgz.md5 && \
    cd - && \
    gpg --import /tmp/KEYS && \
    gpg --verify /tmp/solr-${SOLR_VERSION}.tgz.asc && \
    tar xvzf /tmp/solr-${SOLR_VERSION}.tgz -C /opt && \
    mv /opt/solr-${SOLR_VERSION} /opt/solr && \
    rm -f /tmp/solr-* && \
    rm -f /tmp/KEYS && \
    rm -fr /opt/solr/docs && \
    mkdir -p /opt/solr/server/solr/lib /opt/solr/server/solr/mycores && \
    mkdir /docker-entrypoint-initdb.d /opt/docker/ && \
    sed -i -e 's/#SOLR_PORT=8983/SOLR_PORT=8983/' /opt/solr/bin/solr.in.sh && \
    sed -i -e '/-Dsolr.clustering.enabled=true/ a SOLR_OPTS="$SOLR_OPTS -Dsun.net.inetaddr.ttl=60 -Dsun.net.inetaddr.negative.ttl=60"' /opt/solr/bin/solr.in.sh && \
    chown -R $SOLR_USER:$SOLR_USER /opt/solr && \
    chown -R $SOLR_USER:$SOLR_USER /opt/docker && \

ADD scripts /opt/docker/scripts

EXPOSE 8983

WORKDIR /opt/solr

USER $SOLR_USER

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["solr"]
