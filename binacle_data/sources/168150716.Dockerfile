#
# Logstash Dockerfile
#
# https://github.com/chrisjenx/coreos-elk/logstash
#

# Pull base image.
FROM dockerfile/java:oracle-java7

MAINTAINER Chris Jenkins <chris.mark.jenkins@gmail.com>

# Vars
ENV PRIVATE_IPV4 0.0.0.0
ENV PUBLIC_IPV4 0.0.0.0

# Install confd
ENV CONFD_VERSION 0.6.3
RUN \
  curl -L https://github.com/kelseyhightower/confd/releases/download/v$CONFD_VERSION/confd-$CONFD_VERSION-linux-amd64 -o /usr/local/bin/confd && \
  chmod 0755 /usr/local/bin/confd

# Create directories
RUN mkdir -p /opt/logstash/ssl
RUN mkdir -p /etc/confd/conf.d
RUN mkdir -p /etc/confd/templates

# Install Logstash
ENV LOGSTASH_VERSION 1.4.2
RUN \
  curl https://download.elasticsearch.org/logstash/logstash/logstash-$LOGSTASH_VERSION.tar.gz \
  -o /tmp/logstash-$LOGSTASH_VERSION.tar.gz && \
  tar -xzvf /tmp/logstash-$LOGSTASH_VERSION.tar.gz -C /opt/logstash --strip-components=1 && \
  rm /tmp/logstash-$LOGSTASH_VERSION.tar.gz

# Install contrib plugins
RUN /opt/logstash/bin/plugin install contrib

# Add files
ADD ./confd                   /etc/confd
ADD ./bin/boot.sh             /boot.sh

# Logstash Forwarder
EXPOSE 5000
# Logstash TCP Input
EXPOSE 5001

# Start the container
RUN chmod +x /boot.sh
CMD /boot.sh
