FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    git \
    curl \
    php5-cli \
    php5-json \
    php5-mysql \
    php5-intl \
    php5-dev \
    php5-mongo \
    php5-pgsql \
    php5-xdebug

RUN echo 6
ADD xdebug.sh /bin/xdebug

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

ADD entrypoint.sh /entrypoint.sh
ADD ./code /var/www
ADD symfony_environment.sh /etc/profile.d/symfony_environment.sh

WORKDIR /var/www

ENTRYPOINT ["/entrypoint.sh"]
CMD ["echo", "hello"]
