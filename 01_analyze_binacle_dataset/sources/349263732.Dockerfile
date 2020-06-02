FROM ubuntu:trusty

MAINTAINER Akeda Bagus <amdin@gedex.web.id>

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /tmp

RUN apt-get update -y && \
    apt-get install -y \
    php5-cli \
    php5-mcrypt \
    php5-mssql \
    php5-mysqlnd \
    php5-pgsql \
    php5-redis \
    php5-sqlite \
    php5-gd \
    curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN mkdir -p /var/www
VOLUME ["/var"]
WORKDIR /var/www

ENTRYPOINT ["php", "/tmp/wp-cli.phar", "--allow-root"]
CMD ["--help"]
