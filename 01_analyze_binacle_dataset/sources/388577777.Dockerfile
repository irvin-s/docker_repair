FROM nginx-fpm

RUN mkdir -p /opt/phantomjs/bin
ADD phantomjs.bin /opt/phantomjs/bin/phantomjs
COPY nginx.conf /docker/configuration/nginx.conf
RUN apt-get update && apt-get install -y php5-curl mtr-tiny nmap

ENTRYPOINT ["/docker/script/entrypoint.sh"]
CMD ["nginx-php-fpm"]