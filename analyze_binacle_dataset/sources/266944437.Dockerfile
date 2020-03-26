FROM php:7-alpine
MAINTAINER Suro "suro@tsh.io"

COPY . /src/translator

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /src/translator

ARG SECRET

RUN composer install --no-dev

ADD build-secret.sh /
RUN chmod 755 /build-secret.sh
ENTRYPOINT ["/build-secret.sh"]

CMD [ "php", "./translate.php" ]
