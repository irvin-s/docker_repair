FROM php:7.0-zts
RUN pecl install pthreads-3.1.6
RUN docker-php-ext-enable pthreads