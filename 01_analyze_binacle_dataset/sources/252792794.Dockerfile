FROM alpine:3.2  
MAINTAINER Jonathan Baker <chessracer@gmail.com>  
  
RUN apk --update add \  
nginx \  
php-fpm \  
php-pdo \  
php-json \  
php-openssl \  
php-pgsql \  
php-pdo_pgsql \  
php-mcrypt \  
php-sqlite3 \  
php-pdo_sqlite \  
php-ctype \  
php-zlib \  
php-iconv \  
curl \  
php-curl \  
supervisor  
  
RUN mkdir -p /etc/nginx  
RUN mkdir -p /run/nginx  
RUN mkdir -p /var/run/php-fpm  
RUN mkdir -p /var/log/supervisor  
  
RUN rm /etc/nginx/nginx.conf  
ADD nginx.conf /etc/nginx/nginx.conf  
  
VOLUME ["/var/www", "/etc/nginx/sites-enabled"]  
  
ADD nginx-supervisor.ini /etc/supervisor.d/nginx-supervisor.ini  
ENV TIMEZONE America/Los_Angeles  
  
RUN ln -sf /dev/stderr /var/log/nginx/error.log  
RUN ln -sf /dev/stdout /var/log/nginx/access.log  
  
EXPOSE 80 9000  
CMD ["/usr/bin/supervisord"]  

