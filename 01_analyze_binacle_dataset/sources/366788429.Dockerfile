############################################################
# Dockerfile to build Nginx Amplify Agent container
# Based on Ubuntu 16.04
############################################################

# Set the base image to Ubuntu
FROM ubuntu:16.04

# File Author / Maintainer
LABEL maintainer="Luca Comellini"

# Update the sources list
RUN apt-get update

# Install basic applications
RUN apt-get install -y tar curl nano wget dialog net-tools build-essential
RUN apt-get install -y --fix-missing nginx

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
RUN set -ex; \
	key='A4A9406876FCBD3C456770C88C718D3B5072E1F5'; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
	gpg --export "$key" > /etc/apt/trusted.gpg.d/mysql.gpg; \
	rm -rf "$GNUPGHOME"; \
	apt-key list > /dev/null

RUN echo "deb http://repo.mysql.com/apt/ubuntu/ xenial mysql-8.0" > /etc/apt/sources.list.d/mysql.list

RUN apt-get update && apt-get install -y mysql-community-client-core mysql-community-server-core

RUN rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql /var/run/mysqld \
	&& chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

RUN mkdir -p /var/lib/mysql-files
RUN chown -R mysql:mysql /var/lib/mysql-files/
RUN chmod 700 /var/lib/mysql-files/
RUN mkdir -p /etc/mysql/
RUN touch /var/log/mysqld.log
RUN chmod 777 /var/log/mysqld.log

RUN echo "[mysqld] \n\
skip-host-cache \n\
skip-name-resolve \n\
datadir=/var/lib/mysql \n\
socket=/var/run/mysqld/mysqld.sock \n\
secure-file-priv=/var/lib/mysql-files \n\
user=mysql \n\
log-error=/var/log/mysqld.log \n\
pid-file=/var/run/mysqld/mysqld.pid" >> /etc/mysql/my.cnf

RUN mysqld --initialize-insecure

RUN mysqld -D && mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';"

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

CMD mysqld -D && nginx && nginx -c /etc/nginx/nginx2.conf && service php7.0-fpm start && python /amplify/nginx-amplify-agent.py start --config=/amplify/etc/agent.conf.development && tail -f /amplify/log/agent.log
