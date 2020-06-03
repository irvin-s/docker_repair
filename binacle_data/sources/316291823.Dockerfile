FROM alpine
MAINTAINER Benedict Lau <benedict.lau@groundupworks.com>

RUN apk add --no-cache nodejs nginx php5-fpm php5-json socat

RUN apk add --no-cache --virtual .build libtool nodejs-npm autoconf automake build-base python &&  \
    npm install scuttlebot \
                ssb-keys \
                ssb-client \
                ssb-feed \
                pull-stream \
                    -g --unsafe-perm ; \
    apk del .build

COPY nginx.conf /etc/nginx/conf.d/default.conf

RUN mkdir /run/nginx; \
    apk add --no-cache --virtual .git git; \
    git clone https://github.com/darkdrgn2k/ssb-web-pi.git ~/ssb-web-pi; \
    cp -r ~/ssb-web-pi/html /var/www/html; \
    cp -r ~/ssb-web-pi/backend /var/www/backend; \
    mkdir /var/www/backend/keys ; \
    chown nobody.nobody -R /var/www/html /var/www/backend; \
    chown nobody.nobody -R /var/www/html/* /var/www/backend/*; \
    apk del .git;\
    ln -s /usr/lib/node_modules /var/www/backend; \
    ln -s /usr/bin/sbot /usr/local/bin/sbot; \
    ln -s /usr/bin/node /usr/bin/nodejs

EXPOSE 80
EXPOSE 8008
EXPOSE 8989

ENTRYPOINT  ~/ssb-web-pi/start-docker.sh
