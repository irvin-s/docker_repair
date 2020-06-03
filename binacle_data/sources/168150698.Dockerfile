#
# ElasticSearch Dockerfile
#
# https://github.com/chrisjenx/coreos-elk/elasticsearch
#

# Pull base image.
FROM dockerfile/java:oracle-java7

MAINTAINER Christopher Jenkins <chris.mark.jenkins@gmail.com>

# These should be set when running the container
ENV PRIVATE_IPV4 0.0.0.0
ENV PUBLIC_IPV4 0.0.0.0

# Install confd
ENV CONFD_VERSION 0.6.3
RUN curl -L https://github.com/kelseyhightower/confd/releases/download/v$CONFD_VERSION/confd-$CONFD_VERSION-linux-amd64 -o /usr/local/bin/confd \
  && chmod 0755 /usr/local/bin/confd

# Create directories
RUN mkdir -p /opt/logstash/ssl
RUN mkdir -p /etc/confd/conf.d
RUN mkdir -p /etc/confd/templates

# Install ElasticSearch.
RUN \
  cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.4.tar.gz && \
  tar xvzf elasticsearch-1.3.4.tar.gz && \
  rm -f elasticsearch-1.3.4.tar.gz && \
  mv /tmp/elasticsearch-1.3.4 /opt/elasticsearch

# Install plugins
RUN /opt/elasticsearch/bin/plugin -install lmenezes/elasticsearch-kopf

# Define mountable directories.
VOLUME ["/data"]

# Add files
ADD ./confd                   /etc/confd
ADD ./bin/boot.sh             /boot.sh

# Define working directory.
WORKDIR /data

# Expose ports before starting to alow unicast to find other hosts
# Ports are set by the systemd unit.
#   - 920%i: HTTP
#   - 930%i: transport

# Start Elasticsearch
RUN chmod +x /boot.sh
CMD /boot.sh
