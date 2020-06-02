FROM php:7.2

RUN apt-get update && apt-get install -y --no-install-recommends \
        libicu-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure intl && \
    docker-php-ext-install intl

COPY . /code
WORKDIR /code

RUN phpize && ./configure && make && make install
RUN echo 'extension=intl_dtpg.so' > $PHP_INI_DIR/conf.d/intl_dtpg.ini
