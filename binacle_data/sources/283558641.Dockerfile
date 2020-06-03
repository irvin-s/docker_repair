FROM php:7.1-alpine

RUN docker-php-ext-install sockets pcntl
