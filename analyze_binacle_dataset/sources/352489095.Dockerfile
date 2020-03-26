FROM php:7.0.0RC6
MAINTAINER Gianluca Arbezzano <gianarb92@gmail.com>

RUN apt-get update
RUN apt-get install -y curl git

WORKDIR /usr/bin
RUN curl -Ss https://getcomposer.org/installer | php
RUN mv composer.phar composer
RUN chmod 755 composer

CMD ["php", "-v"]
