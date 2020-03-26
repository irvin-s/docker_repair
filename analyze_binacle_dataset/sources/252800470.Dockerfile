FROM domecloud/openresty:edge  
MAINTAINER Dome C. <dome@tel.co.th>  
  
COPY start.sh /start.sh  
RUN chmod +x /start.sh  
COPY /conf /opt/lixen/nginx/conf/  
COPY info.php /opt/lixen/nginx/html  
  
ARG WORDPRESS_VERSION=4.7  
# Add PHP 7  
RUN apk upgrade -U && \  
apk add curl bash \  
php7 \  
php7-xml \  
php7-xsl \  
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
php7-mbstring  
  
RUN ln -s /etc/php7 /etc/php && \  
ln -s /usr/bin/php7 /usr/bin/php && \  
ln -s /usr/sbin/php-fpm7 /usr/bin/php-fpm && \  
ln -s /usr/lib/php7 /usr/lib/php && \  
rm -fr /var/cache/apk/*  
RUN adduser -D -H -h /opt/lixen/nginx/html www-data  
RUN chown www-data.www-data -R /opt/lixen/nginx/html/  
  
# Install composer global bin  
RUN curl -sS https://getcomposer.org/installer | php \  
&& mv composer.phar /usr/local/bin/composer  
RUN mkdir /var/www  
RUN curl -o wordpress.tar.gz -SL https://wordpress.org/latest.tar.gz \  
&& tar -xzf wordpress.tar.gz -C /var/www \  
&& rm wordpress.tar.gz \  
&& chown -R www-data:www-data /var/www/wordpress  
  
ENV TERM screen.xterm-new  
ENV SHELL=/bin/bash  
EXPOSE 80 443  
ENTRYPOINT ["/start.sh"]  

