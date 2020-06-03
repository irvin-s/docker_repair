FROM davidedimauro88/php5-fpm  
  
RUN apt-get update && \  
apt-get install -y php5-mysql \  
php5-curl \  
php5-cli \  
php5-gd \  
imagemagick \  
php5-memcache \  
php5-dev \  
php5-imagick \  
php-pear \  
\--no-install-recommends && rm -r /var/lib/apt/lists/*

