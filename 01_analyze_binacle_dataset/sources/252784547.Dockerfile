FROM php:5.6-apache  
  
RUN docker-php-source extract \  
&& apt-get update \  
&& apt-get install -y libmcrypt-dev libldap2-dev nano libmagickwand-dev \  
&& rm -rf /var/lib/apt/lists/* \  
&& docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \  
&& docker-php-ext-install ldap mysqli opcache \  
&& pecl install redis-3.1.0 \  
&& pecl install xdebug-2.5.0 \  
&& pecl install imagick-3.4.1 \  
&& docker-php-ext-enable redis xdebug \  
&& docker-php-ext-enable imagick \  
&& docker-php-source delete \  
&& a2enmod rewrite headers  
  
ARG XDEBUG_REMOTE_HOST='localhost'  
  
RUN { \  
echo 'opcache.memory_consumption=128'; \  
echo 'opcache.interned_strings_buffer=8'; \  
echo 'opcache.max_accelerated_files=4000'; \  
echo 'opcache.revalidate_freq=60'; \  
echo 'opcache.fast_shutdown=1'; \  
echo 'opcache.enable_cli=1'; \  
} > /usr/local/etc/php/conf.d/opcache-recommended.ini && { \  
echo 'max_execution_time=300'; \  
echo 'upload_max_filesize=1000M'; \  
echo 'max_file_uploads=1000'; \  
echo 'post_max_size=1000M'; \  
echo 'xdebug.remote_enable=1'; \  
echo 'xdebug.remote_host='$XDEBUG_REMOTE_HOST; \  
} > /usr/local/etc/php/conf.d/custom-php.ini  
  
ADD index.php /var/www/html  
  
VOLUME /var/www/html  

