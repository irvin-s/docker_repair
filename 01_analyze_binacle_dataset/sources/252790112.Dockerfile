FROM php:7.1.7-apache  
MAINTAINER Azure App Services Container Images <appsvc-images@microsoft.com>  
  
COPY apache2.conf /bin/  
COPY init_container.sh /bin/  
COPY hostingstart.html /home/site/wwwroot/hostingstart.html  
  
RUN a2enmod rewrite expires include headers deflate filter ext_filter  
  
# install the PHP extensions we need  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
libpng12-dev \  
libjpeg-dev \  
libpq-dev \  
libmcrypt-dev \  
libldap2-dev \  
libldb-dev \  
libicu-dev \  
libgmp-dev \  
libmagickwand-dev \  
openssh-server \  
libssl-dev \  
zip \  
unzip \  
git \  
&& curl -sS https://getcomposer.org/installer | php \  
&& chmod +x composer.phar \  
&& mv composer.phar /usr/local/bin/composer \  
&& chmod 755 /bin/init_container.sh \  
&& echo "root:Docker!" | chpasswd \  
&& ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so \  
&& ln -s /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib/liblber.so \  
&& ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \  
&& rm -rf /var/lib/apt/lists/* \  
&& pecl install imagick-beta \  
mongodb-1.2.9 \  
apcu-5.1.8 \  
apcu_bc-1.0.3 \  
igbinary-2.0.1 \  
redis-3.1.2 \  
&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \  
&& docker-php-ext-install gd \  
mysqli \  
opcache \  
pdo \  
pdo_mysql \  
pdo_pgsql \  
pgsql \  
ldap \  
intl \  
mcrypt \  
gmp \  
zip \  
bcmath \  
mbstring \  
pcntl \  
sockets \  
&& docker-php-ext-enable imagick \  
mongodb \  
apcu --ini-name 40-apcu.ini \  
apc --ini-name 50-apc.ini \  
igbinary \  
redis  
  
RUN \  
rm -f /var/log/apache2/* \  
&& rmdir /var/lock/apache2 \  
&& rmdir /var/run/apache2 \  
&& rmdir /var/log/apache2 \  
&& chmod 777 /var/log \  
&& chmod 777 /var/run \  
&& chmod 777 /var/lock \  
&& chmod 777 /bin/init_container.sh \  
&& cp /bin/apache2.conf /etc/apache2/apache2.conf \  
&& rm -rf /var/www/html \  
&& rm -rf /var/log/apache2 \  
&& mkdir -p /home/LogFiles \  
&& ln -s /home/site/wwwroot /var/www/html \  
&& ln -s /home/LogFiles /var/log/apache2  
  
RUN { \  
echo 'opcache.memory_consumption=256'; \  
echo 'opcache.interned_strings_buffer=8'; \  
echo 'opcache.max_accelerated_files=60000'; \  
echo 'opcache.revalidate_freq=60'; \  
echo 'opcache.fast_shutdown=1'; \  
echo 'opcache.enable_cli=1'; \  
} > /usr/local/etc/php/conf.d/opcache-recommended.ini  
  
RUN { \  
echo 'error_log=/var/log/apache2/php-error.log'; \  
echo 'display_errors=Off'; \  
echo 'log_errors=On'; \  
echo 'display_startup_errors=Off'; \  
echo 'date.timezone=UTC'; \  
echo 'realpath_cache_size=8M'; \  
echo 'realpath_cache_ttl=900'; \  
echo 'max_execution_time=600'; \  
echo 'memory_limit=512M'; \  
} > /usr/local/etc/php/conf.d/php.ini  
  
COPY sshd_config /etc/ssh/  
  
EXPOSE 2222 8080  
ENV APACHE_RUN_USER www-data  
ENV PHP_VERSION 7.1.7  
ENV PORT 8080  
ENV WEBSITE_ROLE_INSTANCE_ID localRoleInstance  
ENV WEBSITE_INSTANCE_ID localInstance  
ENV PATH ${PATH}:/home/site/wwwroot  
  
WORKDIR /var/www/html  
  
ENTRYPOINT ["/bin/init_container.sh"]  

