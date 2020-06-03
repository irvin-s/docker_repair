# From elk basic env
FROM eason02/java:1.8

# Maintainer
MAINTAINER eason.lau02@hotmail.com

# Install kibana
RUN  set -x && \
     cd ~ && \
     yum -y install which && \
     rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch && \
     wget https://artifacts.elastic.co/downloads/kibana/kibana-5.0.1-x86_64.rpm && \
     sha1sum kibana-5.0.1-x86_64.rpm && \
     rpm --install kibana-5.0.1-x86_64.rpm && \
     rm -rf /etc/kibana/*

# COPY ./config/ /etc/kibana/

ENV PATH /usr/share/kibana/bin:$PATH
EXPOSE 5601

VOLUME /etc/kibana/kibana.yml

CMD ["kibana"]
