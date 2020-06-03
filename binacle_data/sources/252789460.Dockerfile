FROM alpine:edge  
  
RUN apk update \  
&& apk -U upgrade \  
&& apk add php7 \  
&& apk add php7-openssl \  
&& apk add php7-mbstring \  
&& apk add php7-json \  
&& apk add php7-phar \  
&& apk add php7-ctype \  
&& apk add php7-curl \  
&& apk add php7-zlib \  
&& apk add php7-dom \  
&& apk add php7-xml \  
&& apk add php7-iconv \  
&& apk add php7-mcrypt \  
&& apk add php7-ldap \  
&& apk add php7-pdo \  
&& apk add php7-pdo_mysql \  
&& apk add php7-zip \  
&& apk add php7-gd \  
&& apk add php7-session \  
&& apk add ca-certificates wget \  
&& rm -rf /var/cache/apk/*  
  
RUN ln -s /usr/bin/php7 /usr/bin/php  
RUN mkdir -p /opt  
  
ADD php.ini /etc/php7/php.ini  
  
ENV PHP_INI_SENDMAIL_PATH "sendmail -t -i"  
ENV PHP_INI_DATE_TIMEZONE "America/New_York"  
ENV COMPOSER_BIN "/opt/composer.phar"  
  
ADD install-composer.sh /usr/local/bin/install-composer.sh  
RUN install-composer.sh && mv composer.phar /opt  
  
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh  
  
ENTRYPOINT ["docker-entrypoint.sh"]  

