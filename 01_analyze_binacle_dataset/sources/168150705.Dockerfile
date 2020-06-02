#
# Haproxy Dockerfile
#
# https://github.com/core-elk/haproxy
#
# Pull base image.
FROM dockerfile/ubuntu
MAINTAINER Chris Jenkins <chris.mark.jenkins@gmail.com>

# Env - These should be set when running the container
ENV PRIVATE_IPV4 0.0.0.0
ENV PUBLIC_IPV4 0.0.0.0

# Install confd
ENV CONFD_VERSION 0.6.3
RUN \
  curl -L https://github.com/kelseyhightower/confd/releases/download/v$CONFD_VERSION/confd-$CONFD_VERSION-linux-amd64 -o /usr/local/bin/confd && \
  chmod 0755 /usr/local/bin/confd

# Install Haproxy.
RUN \
  sed -i 's/^# \(.*-backports\s\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y haproxy=1.5.3-1~ubuntu14.04.1 && \
  sed -i 's/^ENABLED=.*/ENABLED=1/' /etc/default/haproxy && \
  rm -rf /var/lib/apt/lists/*

# Add files
# ADD haproxy.cfg       /etc/haproxy/haproxy.cfg
ADD ./confd           /etc/confd
ADD ./bin/boot.sh     /haproxy-start

# Allow confd to be exec
#RUN chmod +x /usr/local/bin/start_haproxy

# Define working directory.
WORKDIR /etc/haproxy

# Define default command.
CMD ["bash", "/haproxy-start"]

# Expose ports
# - Status
EXPOSE 8080
#Logstash
# - http
# - transport
EXPOSE 9200
EXPOSE 9300
