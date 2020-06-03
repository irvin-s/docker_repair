FROM alpine:edge
MAINTAINER José Moreira <josemoreiravarzim@gmail.com>

RUN apk --update add nginx bash && \
    rm -fR /var/cache/apk/*

ENV DEBUG="" \
    \
    PUBLIC_PATH=/pub \
    NGINX_CONF=/etc/nginx/boot.conf \
    HTTP_PORT=80 \
    TRY_FILES="\$uri \$uri/ \$uri/index.html index.html" \
    \
    WORKER_CONNECTIONS=1024 \
    \
    CHARSET="utf-8" \
    \
    GZIP_TYPES="application/javascript application/x-javascript application/rss+xml text/javascript text/css image/svg+xml" \
    GZIP_LEVEL=6 \
    \
    CACHE_IGNORE=html \
    CACHE_PUBLIC="ico|jpg|jpeg|png|gif|svg|js|jsx|css|less|swf|eot|ttf|otf|woff|woff2" \
    CACHE_PUBLIC_EXPIRATION=1y \
    \
    CORS_ALLOW_ORIGIN="*" \
    CORS_ALLOW_METHODS="GET, POST, OPTIONS" \
    CORS_ALLOW_HEADERS="DNT,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type"


ADD boot.sh /sbin/boot.sh
RUN chmod +x /sbin/boot.sh

CMD [ "/sbin/boot.sh" ]
