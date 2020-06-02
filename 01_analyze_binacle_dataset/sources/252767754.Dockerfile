FROM wordpress  
RUN apt-get update && apt-get install -y crudini \  
libfreetype6-dev \  
libmcrypt-dev \  
libpng12-dev \  
libjpeg-dev \  
libpng-dev \  
&& docker-php-ext-install iconv mcrypt \  
&& docker-php-ext-configure gd \  
\--enable-gd-native-ttf \  
\--with-freetype-dir=/usr/include/freetype2 \  
\--with-png-dir=/usr/include \  
\--with-jpeg-dir=/usr/include \  
&& docker-php-ext-install gd \  
&& docker-php-ext-install mbstring \  
&& docker-php-ext-enable opcache gd \  
&& rm -rf -- /var/lib/apt/lists/*  
  
#COPY php.ini /usr/local/etc/php/conf.d  
ENV PHP_INI_FILE /usr/local/etc/php/conf.d/php.ini  
RUN touch $PHP_INI_FILE && \  
crudini --set $PHP_INI_FILE PHP max_input_vars 4000 && \  
crudini --set $PHP_INI_FILE PHP memory_limit 256M && \  
crudini --set $PHP_INI_FILE PHP upload_max_filesize 256M && \  
crudini --set $PHP_INI_FILE PHP post_max_size 300M && \  
crudini --set $PHP_INI_FILE PHP max_execution_time 100 && \  
crudini --set $PHP_INI_FILE PHP max_memory_limit 256M  
  
# set higher limits  
COPY ackee-entrypoint.sh /  
RUN sed -i '$i /ackee-entrypoint.sh' /usr/local/bin/docker-entrypoint.sh  
  
# Install wp-cli  
RUN curl \  
-o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \  
&& chmod +x /usr/local/bin/wp  
  
# copy http basic auth vhost conf  
COPY vhost.conf /httpbasicauthvhost.conf  

