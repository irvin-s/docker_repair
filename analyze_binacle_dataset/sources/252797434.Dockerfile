FROM centos:7  
COPY docker-php-entrypoint /usr/bin/docker-php-entrypoint  
  
RUN yum makecache \  
&& yum install -y \  
epel-release \  
&& yum makecache \  
&& yum install -y \  
php \  
php-apcu \  
php-bcmath \  
php-dba \  
php-fpm \  
php-pecl-gmagick \  
php-mbstring \  
php-pecl-memcache \  
php-pecl-memcached \  
php-pdo \  
php-mysql \  
php-soap \  
php-xml \  
&& yum clean all  
  
COPY php-fpm.d/php-fpm.conf /etc/php-fpm.conf  
COPY php-fpm.d/docker.conf /etc/php-fpm.d/docker.conf  
COPY php-fpm.d/zz-docker.conf /etc/php-fpm.d/zz-docker.conf  
  
ENTRYPOINT ["docker-php-entrypoint"]  
WORKDIR /var/www/html  
EXPOSE 9000  
CMD ["php-fpm"]  

