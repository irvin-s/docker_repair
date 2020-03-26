FROM kafebob/rpi-nginx:latest

LABEL maintainer="Luis Toubes <luis@toub.es>"

# Add PHP 7
RUN apk upgrade -U && \
    apk --no-cache add \
    openssl php7 php7-fpm php7-simplexml php7-xml php7-xmlwriter php7-xmlreader \
    php7-xsl php7-json php7-mbstring php7-tokenizer php7-dom \
    php7-openssl php7-mcrypt php7-posix php7-pcntl \
    php7-pdo php7-mysqli php7-pdo_mysql\
    php7-curl php7-phar php7-ctype php7-gd  \
    php7-opcache php7-session php7-zlib php7-zip

COPY ./rootfs/. /

# Small fixes
 RUN ln -s /etc/php7 /etc/php && \
     ln -s /usr/sbin/php-fpm7 /usr/bin/php-fpm && \
     ln -s /usr/lib/php7 /usr/lib/php && \
     rm -fr /var/cache/apk/*

# Install composer global bin
RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/local/bin --filename=composer

# Enable default sessions
RUN mkdir -p /var/lib/php7/sessions
RUN chown nginx:nginx /var/lib/php7/sessions

EXPOSE 80

ENTRYPOINT ["/init"]
