FROM openresty/openresty:alpine

RUN apk update && apk upgrade && apk add bash

RUN rm -rf /etc/nginx/conf.d
RUN deluser xfs && addgroup -g 33 -S www-data && adduser -S -h /var/www -H -u 33 -G www-data www-data

COPY root /

VOLUME /srv/log
VOLUME /srv/ssl
VOLUME /srv/www

EXPOSE 80
EXPOSE 443

CMD ["/bin/bash","/init.sh"]