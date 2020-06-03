############################################################
# Dockerfile to build Nginx Amplify Agent autotests
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Mike Belov

# create required groups/users
RUN groupadd -r mysql && useradd -r -g mysql mysql

# install NGINX OS and some other applications
RUN echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc) main universe" >> /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y --fix-missing \
     build-essential \
     curl \
     dialog \
     mysql-server-5.5 \
     nano \
     net-tools \
     nginx \
     php5-fpm \
     python \
     python-dev \
     python-distribute \
     tar \
     wget

# copy nginx binary
RUN cp /usr/sbin/nginx /usr/sbin/nginx2

# prepare mysql init file
RUN echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('root');" > /mysql.init \
 && echo "CREATE USER 'amplify-agent'@'localhost' IDENTIFIED BY 'amplify-agent';" >> /mysql.init

# configure for php-fpm
RUN rm -rf /run && mkdir -p /run/php/

# add fastcgi_params and php-fpm.conf for nginx
ADD docker/test/fastcgi_params /etc/nginx/fastcgi_params
ADD docker/test/php-fpm.conf /etc/nginx/conf.d/php-fpm.conf

# overwrite default www.conf for php5.0-fpm and add second one
ADD docker/test/php-fpm-www.conf /etc/php5/fpm/pool.d/www.conf
ADD docker/test/php-fpm-www2.conf /etc/php5/fpm/pool.d/www2.conf

# add test .php file to /var/www/php-fpm root
ADD docker/test/test.php /var/www/php-fpm/test.php

# install basic python tools
RUN curl https://bootstrap.pypa.io/get-pip.py | python - 'pip==18.1.0' \
 && pip install supervisor

# install agent requirements:
ADD docker/test/requirements.txt /etc/naas/requirements.txt
RUN pip install -I -r /etc/naas/requirements.txt

# install test requirements
RUN pip install \
    pytest \
    pytest-xdist \
    pyhamcrest \
    requests_mock \
    timeout-decorator \
    freezegun \
    mock

# set some environment variables
ENV AMPLIFY_ENVIRONMENT testing
ENV PYTHONPATH /amplify

# set the default directory where CMD will execute
WORKDIR /amplify

# add config files
ADD docker/test/nginx.conf /etc/nginx/nginx.conf
ADD docker/test/nginx2.conf /etc/nginx/nginx2.conf
ADD docker/test/nginx_bad_status.conf /etc/nginx/nginx_bad_status.conf
ADD docker/test/nginx_syslog.conf /etc/nginx/nginx_syslog.conf
ADD docker/test/supervisord.conf /etc/supervisord.conf
ADD docker/test/nginx_no_logs.conf /etc/nginx/nginx_no_logs.conf

# add ssl stuff
ADD docker/test/amplify-agent-test.crt /etc/nginx/certs.d/amplify-agent-test.crt
ADD docker/test/amplify-agent-test.key /etc/nginx/certs.d/amplify-agent-test.key

# set the home dir of the mysql user
RUN usermod -d /var/lib/mysql/ mysql

CMD bash
