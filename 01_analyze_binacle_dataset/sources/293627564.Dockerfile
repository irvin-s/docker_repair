FROM php:7.1.5-alpine

RUN apk --update add openssl curl git && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer &&\
    docker-php-ext-install pdo mbstring

WORKDIR /app
COPY . /app

RUN composer install --no-dev && cp -p .env.example .env

EXPOSE 80

CMD php artisan serve --host=0.0.0.0 --port=80
