FROM orukami/alpine-php:5.6  
MAINTAINER Jonathan Baker <chessracer@gmail.com>  
  
ENV TERM xterm  
  
RUN apk --update add \  
nginx \  
nano \  
php-pgsql \  
php-fpm \  
php-pdo \  
php-ctype \  
php-json \  
php-openssl \  
php-pdo_pgsql \  
php-opcache \  
php-iconv \  
php-openssl \  
php-curl \  
py-pip \  
supervisor  
  
# Configure supervisor  
RUN pip install --upgrade pip && \  
pip install supervisor-stdout  
  
RUN mkdir -p /etc/nginx  
RUN mkdir -p /run/nginx  
RUN mkdir -p /var/run/php-fpm  
RUN mkdir -p /var/log/supervisor  
  
RUN rm /etc/nginx/nginx.conf  
ADD nginx.conf /etc/nginx/nginx.conf  
  
RUN rm /etc/php/php.ini  
ADD php.ini /etc/php/php.ini  
  
RUN rm /etc/php/php-fpm.conf  
ADD php-fpm.conf /etc/php/php-fpm.conf  
  
RUN rm /etc/php/conf.d/opcache.ini  
  
VOLUME ["/var/www", "/etc/nginx/sites-enabled"]  
  
ADD nginx-supervisor.ini /etc/supervisor.d/nginx-supervisor.ini  
ENV TIMEZONE America/Los_Angeles  
  
RUN ln -sf /dev/stderr /var/log/nginx/error.log  
RUN ln -sf /dev/stdout /var/log/nginx/access.log  
  
EXPOSE 80 9000  
CMD ["/usr/bin/supervisord"]  

