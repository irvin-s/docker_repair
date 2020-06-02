FROM alpine:3.3

RUN apk add --update nginx && rm -rf /var/cache/apk/*
RUN mkdir -p /tmp/nginx/client-body

RUN \
    rm -v /etc/nginx/nginx.conf && \
    rm -v /etc/nginx/mime.types && \
    rm -v -rf /etc/nginx/sites-enabled

COPY nginx.conf /etc/nginx
COPY mime.types /etc/nginx
COPY headers.conf /etc/nginx
COPY sites-enabled /etc/nginx/sites-enabled
COPY certs /etc/nginx/certs
COPY public /www/data

VOLUME ["/var/log/nginx"]
VOLUME ["/etc/nginx/certs"]
VOLUME ["/etc/nginx/vhost.d"]

EXPOSE 443

CMD ["nginx"]