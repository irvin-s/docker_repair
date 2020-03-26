FROM eason02/busybox:latest

MAINTAINER Eason Lau <eason.lau02@hotmail.com>


# Elasticsearch
RUN mkdir -p /usr/share/elasticsearch/config/ && \
    mkdir -p /usr/share/elasticsearch/plugins/

COPY ./elasticsearch/config/ /usr/share/elasticsearch/config/
COPY ./elasticsearch/plugins/ /usr/share/elasticsearch/plugins/

RUN ls -ltra /usr/share/elasticsearch/config/ && \
    ls -ltra /usr/share/elasticsearch/plugins/


# Logstash

RUN mkdir -p /etc/logstash/

COPY ./logstash/config/ /etc/logstash/

RUN ls -ltra /etc/logstash/

# Kibana

RUN mkdir -p /etc/kibana/ && \
    mkdir -p /usr/share/kibana/plugins/

COPY ./kibana/config/kibana.yml.org /etc/kibana/
COPY ./kibana/plugins/ /usr/share/kibana/plugins/

RUN ls -ltra /etc/kibana/ && \
    ls -ltra /usr/share/kibana/plugins/


