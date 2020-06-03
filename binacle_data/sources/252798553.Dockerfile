FROM alpine:latest  
  
MAINTAINER Jason McCallister <jason@deployingcraftcms.com>  
  
RUN apk --update --no-cache add \  
php7 \  
php7-fpm \  
php7-xmlreader \  
php7-xmlwriter \  
php7-zip \  
# required extensions  
php7-pdo \  
php7-pdo_mysql \  
php7-pdo_pgsql \  
php7-mcrypt \  
php7-gd \  
php7-openssl \  
php7-mbstring \  
php7-json \  
php7-curl \  
# TODO look into this requirement?  
# php7-crypt \  
# optional extensions  
php7-dom \  
php7-iconv \  
php7-xml  
  
RUN mkdir /app  
  
COPY config/php.ini /etc/php7/conf.d/50-setting.ini  
  
COPY config/php-fpm.conf /etc/php7/php-fpm.conf  
  
WORKDIR /app  
  
EXPOSE 9000  
CMD ["php-fpm7", "-F"]

