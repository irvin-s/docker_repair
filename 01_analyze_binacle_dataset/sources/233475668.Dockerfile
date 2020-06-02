# From elk env basic
FROM eason02/java:1.8

# Maintainer
MAINTAINER eason.lau02@hotmail.com

COPY ./logstash.repo /etc/yum.repos.d/logstash.repo

# Install logstash componment
RUN set -x && \
        yum -y install which && \
        yum -y install openssl && \
        rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch && \
        wget https://artifacts.elastic.co/downloads/logstash/logstash-5.0.1.rpm && \
        sha1sum logstash-5.0.1.rpm && \
        rpm --install logstash-5.0.1.rpm && \
        rm -rf /etc/logstash/* && \
        ls -R /etc/logstash && \
        cd /etc/logstash && \
        rm -rf *

# COPY ./config/ /etc/logstash/

RUN ls -R /etc/logstash/

ENV PATH  /usr/share/logstash/bin:$PATH
ENV LS_SETTINGS_DIR /etc/logstash

# COPY ./config /usr/share/logstash/config/
# COPY ./conf.d /etc/logstash/conf.d/

RUN set -x && \
        chown logstash:root /var/log/logstash && \
        ls -ltr /var/log/ && \
        echo securerandom.source=file:/dev/urandom >> /usr/java/jdk1.8.0_112/jre/lib/security/java.security

EXPOSE 5000
VOLUME /var/log/logstash
VOLUME /etc/logstash/

CMD ["logstash"]