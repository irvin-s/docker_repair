FROM brunogasparin/laravel-apache:5-onbuild  
# Install postgres libraries and php extension  
RUN apt-get update && apt-get install -y \  
libmysqlclient-dev \  
&& docker-php-ext-install pdo_mysql \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
# Install Image manipulation Dependencies (only for PNG and JPEG)  
RUN apt-get update && apt-get install -y \  
libpng-dev \  
libjpeg-dev \  
&& docker-php-ext-install fileinfo \  
&& docker-php-ext-configure gd --with-jpeg-dir=/usr/include/ \  
&& docker-php-ext-install gd \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
# Configure php  
COPY resources/docker/php/conf.d/timezone.ini $PHP_INI_DIR/conf.d/  
  
VOLUME storage/oauth  
  
RUN php artisan route:cache

