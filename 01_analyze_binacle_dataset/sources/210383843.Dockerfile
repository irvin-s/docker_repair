# MAINTAINER @willfarrell
FROM debian:jessie

ENV FILEBEAT_VERSION=%%FILEBEAT_VERSION%% \
    FILEBEAT_SHA1=%%FILEBEAT_SHA1%%

RUN set -x && \
  apt-get update && \
  apt-get install -y wget && \
  wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz -O /opt/filebeat.tar.gz && \
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

CMD [ "filebeat", "-e", "-c", "/etc/filebeat/filebeat.yml"]