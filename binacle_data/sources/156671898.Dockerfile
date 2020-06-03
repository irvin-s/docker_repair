FROM php:7.0

# install phpredis extension
ENV PHPREDIS_VERSION 3.0.0

RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mkdir -p /usr/src/php/ext \
    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
    && docker-php-ext-install redis \
    && docker-php-ext-install pdo_mysql

# build php-cp
COPY . /usr/src/php/ext/php-cp
RUN docker-php-ext-install php-cp
COPY ./pool.ini /etc/pool.ini

# aliases for dev
RUN echo "alias start='php pool_server start'" >> "/root/.bashrc" \
    && echo "alias stop='php pool_server stop'" >> "/root/.bashrc" \
    && echo "alias mi='make && make install'" >> "/root/.bashrc" \
    && echo "alias clean='make clean'" >> "/root/.bashrc"

# workdir
COPY . /usr/src/php-cp
WORKDIR /usr/src/php-cp

CMD ['/bin/bash']
