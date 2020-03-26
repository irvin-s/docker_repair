# From elk basic env
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

# Install kibana
RUN set -x && \
    cd ~ && \
    yum clean all && \
    yum -y install which && \
    rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch 

RUN wget https://artifacts.elastic.co/downloads/kibana/kibana-5.6.3-x86_64.rpm && \
    sha1sum kibana-5.6.3-x86_64.rpm && \
    rpm --install kibana-5.6.3-x86_64.rpm && \
    rm -rf kibana-5.6.3-x86_64.rpm && \
    rm -rf /etc/kibana/*

ENV PATH /usr/share/kibana/bin:$PATH
EXPOSE 5601

VOLUME /etc/kibana/

WORKDIR /usr/share/kibana/bin

COPY docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["kibana"]
