# 1  
FROM php:7.1-cli  
  
# 2  
MAINTAINER Averor <averor.dev@gmail.com>  
  
# 3 Packages  
RUN apt-get update \  
&& apt-get install -yqq \  
ca-certificates \  
git \  
gettext \  
libbz2-dev \  
libcurl3-dev \  
openssh-client \  
unzip \  
wget \  
curl \  
build-essential \  
php-pear  
  
# 4 PHP extensions  
RUN docker-php-ext-install bcmath bz2 curl  
  
# 5 Cleanup  
RUN apt-get clean && rm -r /var/lib/apt/lists/*  
  
# 6 XDebug  
RUN pecl install xdebug && docker-php-ext-enable xdebug  
  
# 7 Composer  
RUN curl -sS https://getcomposer.org/installer | php \  
&& mv composer.phar /usr/local/bin/ \  
&& ln -s /usr/local/bin/composer.phar /usr/local/bin/composer  
  
# 8 PHPUnit  
RUN wget -O /usr/local/bin/phpunit https://phar.phpunit.de/phpunit.phar \  
&& chmod 755 /usr/local/bin/phpunit \  
&& chmod +x /usr/local/bin/phpunit  
  
# 9  
VOLUME ["/app"]  
  
# 10  
WORKDIR /app  
  
# 11  
CMD ["phpunit"]  

