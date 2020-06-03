FROM php:7.2-fpm-alpine

# Install Magento requirements
RUN \
    apk add --no-cache --virtual .persistent-deps \
        freetype-dev \
        git \
        jq \
        icu-libs \
        libjpeg-turbo-dev \
        libpng-dev \
        libxml2-dev \
        libxml2-utils \
        openssh-client \
        patch \
        perl \
        ssmtp \
        yarn && \
    apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        icu-dev && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) \
        bcmath \
        intl \
        gd \
        opcache \
        pdo_mysql \
        soap \
        zip && \
    yes "" | pecl install apcu lzf mongodb redis && \
    docker-php-ext-enable apcu lzf mongodb redis && \
    curl -sS https://packages.blackfire.io/binaries/blackfire-php/1.22.0/blackfire-php-alpine_amd64-php-72.so \
        --output $(php -r "echo ini_get('extension_dir');")/blackfire.so && \
    perl -pi -e "s/mailhub=mail/mailhub=maildev/" /etc/ssmtp/ssmtp.conf && \
    perl -pi -e "s|;pm.status_path = /status|pm.status_path = /php_fpm_status|g" /usr/local/etc/php-fpm.d/www.conf && \
    pear channel-discover pear.phing.info && \
    pear install phing/phing && \
    yarn global add grunt-cli && \
    apk del .build-deps

# Install Composer globally
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer global require "hirak/prestissimo:dev-master" --no-suggest --optimize-autoloader --classmap-authoritative

# Install custom PHP configuration
COPY conf/* /usr/local/etc/php/

# Install custom entrypoint
COPY entrypoint.sh /usr/local/bin/docker-custom-entrypoint
RUN chmod 777 /usr/local/bin/docker-custom-entrypoint
CMD ["php-fpm"]
ENTRYPOINT ["docker-custom-entrypoint"]
