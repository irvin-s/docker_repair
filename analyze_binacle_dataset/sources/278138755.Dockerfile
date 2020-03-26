FROM alpine:3.9

RUN apk upgrade --no-cache
RUN apk add --no-cache nginx curl

RUN mkdir -p /var/log/nginx \
    && chown -R nginx:nginx /var/log/nginx \
    && mkdir -p /run/nginx && \
    chown -R nginx:nginx /run/nginx
COPY rootfs /

EXPOSE 80
HEALTHCHECK --interval=5s --timeout=5s --start-period=120s CMD curl --fail http://localhost/ || exit 1

CMD ["/init.sh"]
