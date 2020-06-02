FROM php:7.2-rc-fpm-stretch  
  
RUN docker-php-ext-install pdo_mysql \  
&& docker-php-ext-install json  
COPY . /watcher  
WORKDIR /watcher  
  
RUN docker-php-ext-install pdo_mysql \  
&& docker-php-ext-install json  
  
# todo: supervisor different user + specific file  
# RUN vendor/bin/doctrine orm:schema-tool:update --force  
#CMD ["tail", "/dev/null"]

