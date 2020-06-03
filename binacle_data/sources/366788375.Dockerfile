############################################################
# Dockerfile to build Nginx Amplify Agent with N+ container
# Based on Ubuntu 14.04
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Mike Belov

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get install -y -q wget apt-transport-https \
 && apt-get install -y -qq curl libcurl3 libcurl3-dev php5-curl && apt-get install -y -qq ca-certificates

# Download certificate and key from the customer portal (https://cs.nginx.com)
# and copy to the build context
ADD docker/test-plus/nginx-repo.crt /etc/ssl/nginx/
ADD docker/test-plus/nginx-repo.key /etc/ssl/nginx/

# Get other files required for installation
RUN wget -q -O - http://nginx.org/keys/nginx_signing.key | apt-key add -
RUN wget -q -O /etc/apt/apt.conf.d/90nginx https://cs.nginx.com/static/files/90nginx

# Install NGINX Plus and  basic applications
RUN printf "deb https://plus-pkgs.nginx.com/ubuntu `lsb_release -cs` nginx-plus\n" >/etc/apt/sources.list.d/nginx-plus.list \
 && apt-get update \
 && apt-get install -y nginx-plus \
 && apt-get install -y --fix-missing tar curl nano wget dialog net-tools build-essential \
 && cp /usr/sbin/nginx /usr/sbin/nginx2

# Instal mysql and prepare init file
RUN groupadd -r mysql && useradd -r -g mysql mysql
RUN apt-get update && apt-get install -y mysql-server-5.5
RUN echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('root');" > /mysql.init
RUN echo "CREATE USER 'amplify-agent'@'localhost' IDENTIFIED BY 'amplify-agent';" >> /mysql.init

# Install php-fpm and configure
RUN rm -rf /run \
 && mkdir /run \
 && apt-get update \
 && apt-get install -y php5-fpm \
 && mkdir /run/php/

# add fastcgi_params and php-fpm.conf for nginx
ADD docker/test-plus/fastcgi_params /etc/nginx/fastcgi_params
ADD docker/test-plus/php-fpm.conf /etc/nginx/conf.d/php-fpm.conf
# overwrite default www.conf for php5.0-fpm and add second one
ADD docker/test-plus/php-fpm-www.conf /etc/php5/fpm/pool.d/www.conf
ADD docker/test-plus/php-fpm-www2.conf /etc/php5/fpm/pool.d/www2.conf
# add test .php file to /var/www/php-fpm root
ADD docker/test-plus/test.php /var/www/php-fpm/test.php

# Install Python and Basic Python Tools
RUN apt-get update \
 && apt-get install -y python python-dev python-distribute \
 && curl https://bootstrap.pypa.io/get-pip.py | python - 'pip==18.1.0' \
 && pip install supervisor

# Copy the application folder inside the container
#ADD . /amplify
ADD docker/test-plus/requirements.txt /etc/naas/requirements.txt

# Install agent requirements:
RUN pip install -I -r /etc/naas/requirements.txt

# Install test requirements
RUN pip install \
    pytest \
    pytest-xdist \
    pyhamcrest \
    requests_mock \
    timeout-decorator \
    freezegun \
    mock

ENV AMPLIFY_ENVIRONMENT testing
ENV PYTHONPATH /amplify
ENV PYTEST_ADDOPTS "--ignore=test/unit/ext/controller"

# Set the default directory where CMD will execute
WORKDIR /amplify

# add config
ADD docker/test-plus/nginx.conf /etc/nginx/nginx.conf
ADD docker/test-plus/nginx2.conf /etc/nginx/nginx2.conf
ADD docker/test-plus/nginx_bad_status.conf /etc/nginx/nginx_bad_status.conf
ADD docker/test-plus/nginx_syslog.conf /etc/nginx/nginx_syslog.conf
ADD docker/test-plus/supervisord.conf /etc/supervisord.conf
ADD docker/test-plus/nginx_no_logs.conf /etc/nginx/nginx_no_logs.conf

# add ssl
ADD docker/test-plus/amplify-agent-test.crt /etc/nginx/certs.d/amplify-agent-test.crt
ADD docker/test-plus/amplify-agent-test.key /etc/nginx/certs.d/amplify-agent-test.key

RUN usermod -d /var/lib/mysql/ mysql

CMD bash
