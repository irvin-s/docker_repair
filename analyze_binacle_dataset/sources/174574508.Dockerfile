FROM ubuntu:vivid

ENV DEBIAN_FRONTEND noninteractive

# Usual update / upgrade
RUN apt-get update && apt-get upgrade -q -y && apt-get dist-upgrade -q -y

# Let our containers upgrade themselves
RUN apt-get install -q -y unattended-upgrades

# Install usual tools
RUN apt-get install -q -y wget vim

# Install Java... eurk
RUN apt-get install -q -y openjdk-7-jre-headless

# Install elasticsearch
RUN wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb http://packages.elasticsearch.org/elasticsearch/1.5/debian stable main" | tee -a /etc/apt/sources.list.d/elasticsearch.list
RUN apt-get update && apt-get install elasticsearch
RUN mkdir -p /usr/share/elasticsearch/config && \
    ln -s /etc/elasticsearch/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml && \
    ln -s /etc/elasticsearch/logging.yml /usr/share/elasticsearch/config/logging.yml

# Set our volume
VOLUME ["/var/lib/elasticsearch"]

# Add configurations
ADD conf/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

EXPOSE 9200

# Install Marvel
# RUN /usr/share/elasticsearch/bin/plugin -i elasticsearch/marvel/latest

ENTRYPOINT ["/usr/share/elasticsearch/bin/elasticsearch"]
