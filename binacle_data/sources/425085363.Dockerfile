# PHP (gewo/php)
FROM gewo/interactive
MAINTAINER Gebhard Wöstemeyer <g.woestemeyer@gmail.com>

ENV PHP_VERSION 5.4.24

# 1.13.1/current master broken: https://github.com/c9s/phpbrew/issues/214
ENV PHPBREW_VERSION master

RUN echo 'deb-src http://archive.ubuntu.com/ubuntu trusty main universe multiverse' >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get -y build-dep php5
RUN apt-get -y install curl git \
  openjdk-7-jre-headless nodejs \
  libmysqlclient-dev libmysqld-dev \
  firefox xvfb \
  \
  php5 php5-dev php-pear autoconf automake build-essential libxslt1-dev \
  re2c libxml2 libxml2-dev php5-cli bison libbz2-dev libreadline-dev \
  libfreetype6-dev libpng12-0 libpng12-dev libjpeg-dev libjpeg8-dev libjpeg8 \
  libxpm4 libssl-dev openssl gettext libgettextpo-dev libcurl4-gnutls-dev \
  libgettextpo0 libicu-dev libmhash-dev libmhash2 libmcrypt-dev \
  libmcrypt4 libfreetype6  \
  && apt-get clean

# remove original LoadModule line from Apache config. phpbrew will add it again.
RUN sed -i -e '/^LoadModule php5/d' /etc/apache2/mods-available/php5.load

RUN curl -L https://raw.github.com/c9s/phpbrew/${PHPBREW_VERSION}/phpbrew > /usr/bin/phpbrew \
  && chmod +x /usr/bin/phpbrew

RUN phpbrew init && echo 'source /.phpbrew/bashrc' >> /etc/shell_env
RUN bash -c ". /.phpbrew/bashrc && \
  phpbrew install ${PHP_VERSION} +default+pdo+mysql+apxs2+openssl"

ENV PHPBREW_BIN /.phpbrew/bin
ENV PATH /.phpbrew/bin:$PATH

RUN bash -c ". /.phpbrew/bashrc && phpbrew switch ${PHP_VERSION} && \
  phpbrew install-composer && \
  phpbrew ext install curl && \
  phpbrew ext install APC && \
  phpbrew ext install xdebug"
RUN file="/.phpbrew/php/php-${PHP_VERSION}/lib/php/extensions/*/xdebug.so" && \
  echo "zend_extension=$(echo $file)" > /.phpbrew/php/php-${PHP_VERSION}/var/db/xdebug.ini

# Apache Config
ADD apache_config /etc/apache2/sites-available/default
RUN a2enmod headers php5 rewrite

CMD ["/bin/bash"]
