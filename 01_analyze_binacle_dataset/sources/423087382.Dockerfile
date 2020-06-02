##
# NAME             : iadvize/php-convention
# VERSION          : latest
# DOCKER-VERSION   : 17.06
##

FROM iadvize/php:7.0

COPY composer.* /app/

WORKDIR /app

RUN composer install --ignore-platform-reqs --no-progress --no-interaction
