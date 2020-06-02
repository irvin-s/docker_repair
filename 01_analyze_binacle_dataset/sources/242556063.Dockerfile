FROM php:7

ARG composer_checksum=55d6ead61b29c7bdee5cccfb50076874187bd9f21f65d8991d46ec5cc90518f447387fb9f76ebae1fbbacf329e583e30
ARG composer_url=https://raw.githubusercontent.com/composer/getcomposer.org/ba0141a67b9bd1733409b71c28973f7901db201d/web/installer

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV PATH=$PATH:vendor/bin

RUN apt-get update && apt-get install -y --no-install-recommends \
      curl \
      git \
      python-dev \
      python-pip \
      zlib1g-dev \
 && pip install awscli \
 && docker-php-ext-install zip \
 && curl -o installer "$composer_url" \
 && echo "$composer_checksum *installer" | shasum -c -a 384 \
 && php installer --install-dir=/usr/local/bin --filename=composer \
 && rm -rf /var/lib/apt/lists/*
