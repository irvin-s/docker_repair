FROM ubuntu:latest
#
MAINTAINER Rimusz <rmocius@gmail.com>

# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y

# Basic Requirements
RUN apt-get -y install curl git unzip mc sudo wget python-setuptools python-software-properties

# install nginx 
RUN apt-get install -y software-properties-common 
RUN add-apt-repository ppa:nginx/stable
RUN apt-get update
RUN apt-get install -y nginx

# nginx config
RUN sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf
RUN sed -i -e"s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 100m/" /etc/nginx/nginx.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
# Remove default site
RUN rm -f /etc/nginx/sites-enabled/default

# Install confd
RUN curl -L -o /usr/local/bin/confd "https://github.com/kelseyhightower/confd/releases/download/v0.5.0/confd-0.5.0-linux-amd64"
RUN chmod 777 /usr/local/bin/confd

# Create directories
RUN mkdir -p /etc/confd/conf.d
RUN mkdir -p /etc/confd/templates

# Add confd files
ADD ./confd /etc/confd/

# Supervisor Config
RUN /usr/bin/easy_install supervisor
ADD ./supervisord.conf /etc/supervisord.conf

# Startup Script
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh

# private expose
EXPOSE 80
#
CMD ["/bin/bash", "/start.sh"]
