FROM bytepark/alpine-nginx:1.1  
MAINTAINER Sebastian Knoth <sk@bytepark.de>  
  
# Add PHP 7  
RUN apk upgrade -U && \  
apk --update add \  
php7 \  
php7-zlib \  
php7-dom \  
php7-xml \  
php7-xsl \  
php7-pdo \  
php7-pdo_mysql \  
php7-mcrypt \  
php7-curl \  
php7-json \  
php7-fpm \  
php7-phar \  
php7-openssl \  
php7-mysqli \  
php7-ctype \  
php7-opcache \  
php7-mbstring \  
php7-xmlreader  
  
COPY /rootfs /  
  
# Small fixes  
RUN ln -s /etc/php7 /etc/php && \  
ln -s /usr/bin/php7 /usr/bin/php && \  
ln -s /usr/sbin/php-fpm7 /usr/bin/php-fpm && \  
ln -s /usr/lib/php7 /usr/lib/php && \  
rm -fr /var/cache/apk/*  
  
# Install composer global bin  
RUN curl -sS https://getcomposer.org/installer | php \  
&& mv composer.phar /usr/local/bin/composer  
  
# ADD SOURCE  
ONBUILD COPY ./src /usr/share/nginx/html  
ONBUILD RUN chown -Rf nginx:nginx /usr/share/nginx/html  
  
ENTRYPOINT ["/init"]

