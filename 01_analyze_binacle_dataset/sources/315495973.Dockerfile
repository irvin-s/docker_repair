FROM neighborhoods/php-fpm-phalcon:php7.2_phalcon3.4
RUN apt-get update -y && apt-get install -y unzip procps
ARG PROJECT_NAME=kojo

# COMPOSER_TOKEN can also be passed via the COMPOSER_GITHUB_TOKEN file
ARG COMPOSER_TOKEN=placeholder_token_you_must_replace_via_args_in_compose_file
ARG INSTALL_XDEBUG=true
ARG COMPOSER_INSTALL=true

ENV PROJECT_DIR=/var/www/html/${PROJECT_NAME}.neighborhoods.com
ENV IS_DOCKER=1

RUN usermod -u 1000 www-data
RUN mkdir -p $PROJECT_DIR
WORKDIR $PROJECT_DIR

COPY . $PROJECT_DIR

# Copy xdebug configration for remote debugging
COPY docker/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
COPY docker/bwilson.ini /usr/local/etc/php/conf.d/bwilson.ini

RUN bash docker/build.sh \
    --composer-token ${COMPOSER_TOKEN} \
    --xdebug ${INSTALL_XDEBUG} \
    --composer-install ${COMPOSER_INSTALL}

#CMD ["php-fpm"]

EXPOSE 9001
