FROM ubuntu:trusty

MAINTAINER Akeda Bagus <admin@gedex.web.id>

ENV DEBIAN_FRONTEND noninteractive

# Install Nginx.
RUN apt-get update -y && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:nginx/stable && \
    apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/* && \
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
    chown -R www-data:www-data /var/lib/nginx

# Only use stable sources
RUN rm -rf /etc/apt/sources.list.d/proposed.list

# Install packages
RUN apt-get update && \
  apt-get install -y \
  curl \
  wget

ADD config/nginx.conf /opt/etc/nginx.conf

# Create required directories
RUN mkdir -p /etc/nginx && \
    mkdir -p /etc/nginx/sites-enabled && \
    mkdir -p /var/log/nginx

RUN rm -rf /etc/nginx/sites-enabled/default

ADD bin/nginx-start.sh /opt/bin/start.sh
RUN chmod u=rwx /opt/bin/start.sh

VOLUME ["/var/www", "/etc/nginx/sites-enabled"]

EXPOSE 80

WORKDIR /opt/bin

ENTRYPOINT ["/opt/bin/start.sh"]
