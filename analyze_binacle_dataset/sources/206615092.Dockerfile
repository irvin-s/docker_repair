FROM shipito/php:5.6-alpine
MAINTAINER Patrik Votoček <patrik@votocek.cz>

ENV COMPOSER_DISABLE_XDEBUG_WARN 1

RUN apk --update --no-cache upgrade && \
    apk --update --no-cache add php5-xdebug --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/

CMD ["php", "-a"]
