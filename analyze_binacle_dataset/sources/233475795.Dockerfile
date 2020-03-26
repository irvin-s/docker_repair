# From elk env basic
FROM eason02/java:1.8

# Maintainer
MAINTAINER Eason Lau <eason.lau02@hotmail.com>

# Install gosu for step-down from root
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
    curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.9/gosu-amd64" && \
    curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.9/gosu-amd64.asc" && \
    gpg --verify /usr/local/bin/gosu.asc && \
    rm /usr/local/bin/gosu.asc && \
    rm -rf /root/.gnupg/ && \
    chmod +x /usr/local/bin/gosu && \
    gosu nobody true

# Install logstash componment
RUN set -x && \
    yum clean all && \
    yum -y install which && \
    yum -y install openssl && \
    wget https://artifacts.elastic.co/downloads/logstash/logstash-6.0.0.rpm && \
    rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch && \
    sha1sum logstash-6.0.0.rpm && \
    rpm --install logstash-6.0.0.rpm && \
    rm -rf /etc/logstash/* && \
    rm -rf logstash-6.0.0.rpm && \
    ls -R /etc/logstash && \
    cd /etc/logstash && \
    rm -rf *

RUN ls -R /etc/logstash/

ENV PATH  /usr/share/logstash/bin:$PATH
ENV LS_SETTINGS_DIR /etc/logstash

RUN set -x && \
        chown logstash:root /var/log/logstash && \
        ls -ltr /var/log/ && \
        echo securerandom.source=file:/dev/urandom >> /usr/java/jdk1.8.0_112/jre/lib/security/java.security

RUN ls -R /etc/pki/tls/certs/ && ls -R /etc/pki/tls/private/

EXPOSE 5000
VOLUME /var/log/logstash
VOLUME /etc/pki/tls/private/logstash-forwarder.key
VOLUME /etc/pki/tls/certs/logstash-forwarder.crt
VOLUME /etc/logstash/

COPY docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh
ENV JAVA_HOME /usr/java/jdk1.8.0_112/

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["logstash"]
