FROM alpine:3.3  
MAINTAINER Andrew Liu  
  
# OSX Only: Change to conform to the UID and GID of host system  
ENV HOST_UID 1000  
ENV HOST_GID 50  
# Fix OSX shared volume permission issue  
# Must be placed on top for setting up UID and GID  
RUN adduser -D -s /bin/ash -u $HOST_UID dev && \  
addgroup -g $HOST_GID www-data && \  
adduser -HD -s /sbin/nologin phpfpm && \  
addgroup phpfpm www-data  
  
# Install Laravel dependencies  
# Note: Tokenizer is enable by default since PHP 4.3.0  
RUN apk upgrade -U && \  
apk --update \  
\--repository=http://nl.alpinelinux.org/alpine/edge/testing add \  
php7 \  
php7-openssl \  
php7-pdo_mysql \  
php7-pdo_sqlite \  
php7-mbstring \  
php7-session  
  
# Install additional PHP packages  
RUN apk --update \  
\--repository=http://nl.alpinelinux.org/alpine/edge/testing add \  
php7-json \  
php7-xml \  
php7-dom \  
php7-curl \  
php7-phar \  
php7-zip \  
php7-redis \  
php7-opcache \  
php7-fpm  
  
# Install Nginx and additional packages  
RUN apk --update \  
add \  
nginx \  
redis \  
supervisor \  
curl  
  
# Delete cached packages  
RUN rm -fr /var/cache/apk/*  
  
# Link php  
RUN ln -s /etc/php7 /etc/php && \  
ln -s /usr/bin/php7 /usr/bin/php && \  
ln -s /usr/sbin/php-fpm7 /usr/bin/php-fpm && \  
ln -s /usr/lib/php7 /usr/lib/php  
  
# Configure php7-fpm  
WORKDIR /etc/php7/php-fpm.d  
RUN sed -i "s/user = nobody/user = phpfpm/g" www.conf && \  
sed -i "s/group = nobody/group = phpfpm/g" www.conf && \  
sed -i "s/pm.max_children = 5/pm.max_children = 10/g" www.conf  
  
# Configure php7-opcache  
WORKDIR /etc/php7/conf.d  
RUN sed -i "$ a opcache.enable_cli=1" 00_opcache.ini && \  
sed -i "$ a opcache.validate_timestamps=1" 00_opcache.ini && \  
sed -i "$ a opcache.revalidate_freq=0" 00_opcache.ini  
  
# Configure Nginx  
WORKDIR /etc/nginx  
RUN addgroup nginx www-data && \  
sed -i "1 i daemon off;" nginx.conf && \  
sed -i "s/worker_processes 1;/worker_processes auto;/g" \  
nginx.conf && \  
sed -i "/events {/ a \ \multi_accept on;" nginx.conf && \  
sed -i "/events {/ a \ \use epoll;" nginx.conf && \  
sed -i "/http {/ a \ \include \/etc\/nginx\/sites-enabled\/\\*;" \  
nginx.conf  
COPY dockerstead.app.conf sites-available/  
RUN mkdir sites-enabled && \  
ln -fs $(pwd)/sites-available/dockerstead.app.conf \  
$(pwd)/sites-enabled/dockerstead.app.conf  
  
WORKDIR /var/www/app/public  
RUN echo "<?php phpinfo(); ?>" > index.php  
  
# Configure Supervisor  
WORKDIR /  
COPY supervisord.conf /etc/supervisor/  
  
EXPOSE 80  
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]  

