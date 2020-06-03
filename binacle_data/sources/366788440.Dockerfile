############################################################
# Dockerfile to build Nginx Amplify Agent container
# Based on Ubuntu 16.04
############################################################

# Set the base image to Ubuntu
FROM ubuntu:16.04
# no idea why adding this earlier works..
ADD requirements.txt /etc/naas/requirements.txt

ARG VAULT_ADDR='https://vault.ci.nginx.com'
ARG VAULT_SKIP_VERIFY=true
ARG VAULT_TOKEN
RUN echo ${VAULT_TOKEN}

# File Author / Maintainer
LABEL maintainer="Seth Malaki"

# Add the application resources URL
# RUN echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc) main universe" >> /etc/apt/sources.list

# Update the sources list
RUN apt-get update

# Install basic applications
RUN apt-get install -y --fix-missing \
    tar curl nano wget dialog \
    net-tools build-essential net-tools build-essential \
    apt-transport-https jq software-properties-common

# get vault
RUN curl -Ss https://releases.hashicorp.com/vault/0.10.0/vault_0.10.0_linux_amd64.zip \
    | gunzip - > /usr/local/bin/vault \
    && chmod +x /usr/local/bin/vault

# setup NGINX repo certs for N+
RUN mkdir -p /etc/ssl/nginx \
    && VAULT_TOKEN=${VAULT_TOKEN} vault kv get -format=json certs-dev/nginx-repo.crt  \
    | jq -r .data.data.cert > /etc/ssl/nginx/nginx-repo.crt \
    && VAULT_TOKEN=${VAULT_TOKEN} vault kv get -format=json certs-dev/nginx-repo.key  \
    | jq -r .data.data.key > /etc/ssl/nginx/nginx-repo.key \
    && chmod +r /etc/ssl/nginx/nginx-repo.*

# get N+
RUN curl -sS http://nginx.org/keys/nginx_signing.key | apt-key add -
RUN curl -sS --output /etc/apt/apt.conf.d/90nginx https://cs.nginx.com/static/files/90nginx
RUN printf "deb https://plus-pkgs.nginx.com/ubuntu `lsb_release -cs` nginx-plus\n" > /etc/apt/sources.list.d/nginx-plus.list
RUN apt-get -qq update && apt-get install -qq nginx-plus

# Install php-fpm and configure
RUN apt-get update && apt-get install -y php-fpm
# add fastcgi_params and php-fpm.conf for nginx
ADD fastcgi_params /etc/nginx/fastcgi_params
ADD php-fpm.conf /etc/nginx/conf.d/php-fpm.conf
# overwrite default www.conf for php7.0-fpm
ADD php-fpm-www.conf /etc/php/7.0/fpm/pool.d/www.conf
# add alternate version that listens on IPv4
ADD php-fpm-www-alt.conf /etc/php/7.0/fpm/pool.d/www-alt.conf
# add test .php file to /var/www/php-fpm root
ADD test.php /var/www/php-fpm/test.php

# Instal mysql and prepare init file
RUN groupadd -r mysql && useradd -r -g mysql mysql
RUN echo "mysql-server-5.7 mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server-5.7 mysql-server/root_password_again password root" | debconf-set-selections
RUN apt-get update && apt-get install -y mysql-server-5.7

# Install Python and Basic Python Tools
RUN apt-get install -y python python-dev python-distribute
RUN curl https://bootstrap.pypa.io/get-pip.py | python - 'pip==18.1.0'

# Copy the application folder inside the container
ADD . /amplify

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

CMD service mysql start && nginx && nginx -c /etc/nginx/nginx2.conf && service php7.0-fpm start && python /amplify/nginx-amplify-agent.py start --config=/amplify/etc/agent.conf.development && tail -f /amplify/log/agent.log
