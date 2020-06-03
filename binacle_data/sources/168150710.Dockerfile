# Kibana Dockerfile
#
# Pull base image.
FROM dockerfile/ubuntu

MAINTAINER Christopher Jenkins <chris.mark.jenkins@gmail.com>

# These should be set when running the container
ENV PRIVATE_IPV4 0.0.0.0
ENV PUBLIC_IPV4 0.0.0.0

# Install confd
ENV CONFD_VERSION 0.6.3
RUN curl -L https://github.com/kelseyhightower/confd/releases/download/v$CONFD_VERSION/confd-$CONFD_VERSION-linux-amd64 -o /usr/local/bin/confd \
  && chmod 0755 /usr/local/bin/confd


# Install Nginx. (In daemon off mode)
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

# Install Kibana
RUN cd /tmp && \
  wget https://download.elasticsearch.org/kibana/kibana/kibana-3.1.1.tar.gz && \
  tar xvf kibana-3.1.1.tar.gz && \
  cp -r kibana-3.1.1 /usr/share/ && \
  rm -f /usr/share/kibana-3.1.1/config.js

# Add files
ADD ./confd                   /etc/confd
ADD ./bin/boot.sh             /boot.sh
# Kibana config points a 9100 (this box)
ADD ./config/kibana-config.js /usr/share/kibana-3.1.1/config.js

# Expose port.
EXPOSE 9100

# Start Nginx for Kibana
RUN chmod +x /boot.sh
CMD /boot.sh
