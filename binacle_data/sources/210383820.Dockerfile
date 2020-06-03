# MAINTAINER @willfarrell

FROM debian:jessie

ENV FILEBEAT_VERSION=1.1.1 \
    FILEBEAT_SHA1=05f99d2f61fee1608d01f583a2d0737a53bbd4b5

RUN set -x && \
  apt-get update && \
  apt-get install -y wget && \
  wget https://download.elastic.co/beats/filebeat/filebeat-${FILEBEAT_VERSION}-x86_64.tar.gz -O /opt/filebeat.tar.gz && \
  cd /opt && \
  echo "${FILEBEAT_SHA1}  filebeat.tar.gz" | sha1sum -c - && \
  tar xzvf filebeat.tar.gz && \
  cd filebeat-* && \
  cp filebeat /bin && \
  cp filebeat.yml /filebeat.yml && \
  cd /opt && \
  rm -rf filebeat* && \
  apt-get purge -y wget && \
  apt-get autoremove -y && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD [ "filebeat", "-e" ]
