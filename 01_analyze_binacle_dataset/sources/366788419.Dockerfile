############################################################
# Dockerfile to build Nginx Amplify Agent container
# Based on Ubuntu 14.04
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Mike Belov

# Add the application resources URL
# RUN echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc) main universe" >> /etc/apt/sources.list

# Install basic applications
RUN apt-get update && apt-get install -y tar curl nano wget dialog net-tools build-essential
RUN apt-get update && apt-get install -y --fix-missing nginx

# Install php-fpm and configure
RUN apt-get update && apt-get install -y php5-fpm
# add fastcgi_params and php-fpm.conf for nginx
ADD fastcgi_params /etc/nginx/fastcgi_params
ADD php-fpm.conf /etc/nginx/conf.d/php-fpm.conf
# overwrite default www.conf for php5.0-fpm
ADD php-fpm-www.conf /etc/php5/fpm/pool.d/www.conf
RUN mkdir /run/php/
# add test .php file to /var/www/php-fpm root
ADD test.php /var/www/php-fpm/test.php

# Instal mysql and prepare init file
RUN groupadd -r mysql && useradd -r -g mysql mysql
RUN echo "mysql-server-5.5 mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server-5.5 mysql-server/root_password_again password root" | debconf-set-selections
RUN apt-get update && apt-get install -y mysql-server-5.5

# Install Python and Basic Python Tools
RUN apt-get install -y python python-dev python-distribute
RUN curl https://bootstrap.pypa.io/get-pip.py | python - 'pip==18.1.0'

# Copy the application folder inside the container
ADD . /amplify
ADD requirements.txt /etc/naas/requirements.txt

# Install agent requirements:
RUN pip install -r /etc/naas/requirements.txt

ENV AMPLIFY_ENVIRONMENT development
ENV PYTHONPATH /amplify/

# Set the default directory where CMD will execute
WORKDIR /amplify

# add stub status
ADD nginx.conf /etc/nginx/nginx.conf
ADD nginx2.conf /etc/nginx/nginx2.conf

# add ssl
ADD amplify-agent-test.crt /etc/nginx/certs.d/amplify-agent-test.crt
ADD amplify-agent-test.key /etc/nginx/certs.d/amplify-agent-test.key

RUN usermod -d /var/lib/mysql/ mysql

CMD service mysql start && nginx && nginx -c /etc/nginx/nginx2.conf && service php5-fpm start && python /amplify/nginx-amplify-agent.py start --config=/amplify/etc/agent.conf.development && tail -f /amplify/log/agent.log
