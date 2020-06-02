FROM debian:jessie

MAINTAINER Andrea Usuelli <andrea.usuelli@prima.it>

ENV FILEBEAT_VERSION=1.2.3 \
    FILEBEAT_SHA1=3fde7f5f5ea837140965a193bbb387c131c16d9c

RUN set -x && \
  apt-get update && \
  apt-get install -y wget && \
  wget https://download.elastic.co/beats/filebeat/filebeat-${FILEBEAT_VERSION}-x86_64.tar.gz -O /opt/filebeat.tar.gz && \
  cd /opt && \
  echo "${FILEBEAT_SHA1}  filebeat.tar.gz" | sha1sum -c - && \
  tar xzvf filebeat.tar.gz && \
  cd filebeat-* && \
  cp filebeat /bin && \
  cd /opt && \
  rm -rf filebeat* && \
  apt-get purge -y wget && \
  apt-get autoremove -y && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD [ "filebeat", "-e" ]
