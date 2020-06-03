FROM circleci/php:7.1-fpm-node-browsers  
  
ENV APT_PACKAGES="libicu-dev mysql-client nginx zlib1g-dev" \  
PHP_EXTENSIONS="intl pdo_mysql"  
RUN sudo apt-get update \  
&& sudo apt-get upgrade \  
&& sudo apt-get install -y ${APT_PACKAGES} \  
&& sudo rm -rf /var/lib/apt/lists/*  
  
RUN for PHP_EXTENSION in ${PHP_EXTENSIONS}; do \  
sudo docker-php-ext-configure ${PHP_EXTENSION}; \  
done \  
&& sudo docker-php-ext-install ${PHP_EXTENSIONS}  

