FROM alpine:3.9

RUN apk upgrade --no-cache
RUN apk add --no-cache php php-fpm bash fcgi

COPY rootfs /

EXPOSE 9000
HEALTHCHECK --interval=10s --timeout=3s CMD /usr/local/bin/healthcheck

CMD ["/usr/sbin/php-fpm7", "-F"]
