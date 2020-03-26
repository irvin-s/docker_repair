FROM composer  
RUN apk add \--no-cache icu-dev  
RUN docker-php-ext-install intl

