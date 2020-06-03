FROM alpine:3.7

RUN mkdir -p /opt/driver/src && \
    adduser ${BUILD_USER} -u ${BUILD_UID} -D -h /opt/driver/src

# PHP installation from: http://php-alpine.codecasts.rocks/
ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub
RUN echo "http://php.codecasts.rocks/v3.5/php-7.1" >> /etc/apk/repositories
RUN apk add  --no-cache make git ca-certificates \
        php7=${RUNTIME_NATIVE_VERSION} \
        php7-openssl php7-zlib php7-mbstring php7-json php7-phar php7-ctype \
        php7-xml php7-dom php7-tokenizer php7-xmlwriter

# PHP composer installation
ADD https://getcomposer.org/installer /tmp/composer-setup.php
RUN php /tmp/composer-setup.php --install-dir=/bin/

WORKDIR /opt/driver/src
