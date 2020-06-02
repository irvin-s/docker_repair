FROM php:7.1.4-alpine

MAINTAINER TAMURA Yoshiya <a@qmu.jp>

RUN apk --update add curl && \
    cd /bin && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer global require hirak/prestissimo && \
    apk del curl

RUN mkdir -p /app
WORKDIR /app
VOLUME /app

CMD ["/bin/sh"]
ENTRYPOINT ["/bin/sh", "-c"]
