FROM alpine:3.6

LABEL maintainer="Webber Takken <webber@takken.io>"

RUN apk add --update nginx
RUN rm -rf /var/cache/apk/* && rm -rf /tmp/*

COPY nginx.conf /etc/nginx/
RUN rm -rf /etc/nginx/conf.d/*
COPY symfony.conf /etc/nginx/conf.d/
COPY upstream.conf /etc/nginx/conf.d/

RUN adduser -D -g '' -G www-data www-data

CMD ["nginx"]

EXPOSE 80
EXPOSE 443
