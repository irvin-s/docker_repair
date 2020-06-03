FROM egovio/nginx-alpine:1.13.8
RUN apk update && apk add acme-client libressl
RUN mkdir -p /var/www/acme
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
#COPY ./sub_filter.conf /tmp/sub_filter.conf
COPY ./default_ssl.conf	/tmp/default_ssl.conf
COPY ./start.sh /usr/bin/start.sh
RUN chmod +x /usr/bin/start.sh
CMD ["/usr/bin/start.sh"]
