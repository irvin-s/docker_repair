FROM formapro/nginx-php-fpm:7.3-latest-all-exts

COPY ./cli.ini /etc/php/7.3/cli/conf.d/1-dev_cli.ini
COPY ./entrypoiny.sh /usr/local/bin/entrypoint.sh
RUN chmod u+x /usr/local/bin/entrypoint.sh
RUN apt-get update && apt-get -y --no-install-recommends --no-install-suggests install netcat

RUN mkdir -p /app
WORKDIR /app

CMD /usr/local/bin/entrypoint.sh
