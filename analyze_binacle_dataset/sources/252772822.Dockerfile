FROM alpine:edge  
MAINTAINER Dmytro Shavaryn <shavarynd@gmail.com>  
  
# Install PHP7 with needed exstentions and composer with hirak/prestissimo.  
RUN apk add --no-cache \  
php7 \  
php7-dom \  
php7-curl \  
php7-json \  
php7-phar \  
php7-openssl \  
php7-mbstring \  
php7-ctype \  
php7-pdo_mysql \  
php7-session \  
php7-xml \  
php7-xmlwriter \  
php7-tokenizer \  
curl \  
&& rm -fr /var/cache/apk/* \  
&& curl -sS https://getcomposer.org/installer | php -- --filename=composer \  
\--install-dir=/usr/bin --version=1.0.0 \  
&& composer global require "hirak/prestissimo:^0.3"  
  
# Add files and folders to container.  
ADD ["composer.json", "entrypoint.sh", "/srv/"]  
WORKDIR /srv  
  
# Install and initialize Behat, create folder for artifacts.  
RUN composer install \  
&& bin/behat --init \  
&& mkdir -p artifacts  
  
ENTRYPOINT ["/srv/entrypoint.sh"]  

