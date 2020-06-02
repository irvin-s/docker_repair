FROM alpine:3.7  
  
RUN set -xe && \  
apk upgrade --update && \  
apk add --no-cache \  
php7 \  
php7-fpm \  
php7-pdo \  
php7-pdo_mysql \  
php7-mysqli \  
php7-json \  
php7-openssl \  
php7-curl \  
php7-zlib \  
php7-xml \  
php7-phar \  
php7-intl \  
php7-dom \  
php7-xmlreader \  
php7-xmlwriter \  
php7-ctype \  
php7-mbstring \  
php7-gd \  
php7-tokenizer \  
php7-session \  
nginx \  
supervisor \  
curl \  
&& \  
mkdir -p /var/www/html && \  
mkdir /var/log/supervisor && \  
mkdir /run/nginx/ && \  
echo "<?php echo phpinfo(); ?>" > /var/www/html/index.php && \  
touch /var/log/lastlog  
  
COPY ./rootfs /  
  
WORKDIR /var/www/html  
  
ENTRYPOINT ["/entrypoint.sh"]  
  
EXPOSE 80 443  
  
CMD ["tail", "-f", "/var/log/lastlog"]  

