FROM nginx

MAINTAINER Giorgos Papaefthymiou <george.yord@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qqy update && \
    apt-get -qqy install gettext-base openssl apache2-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# Catch-all server name, ref: http://nginx.org/en/docs/http/server_names.html#miscellaneous_names
ENV PUBLIC_HOST=_
ENV PUBLIC_PORT=80

ENV NGINX_ERROR_LEVEL=warn
ENV HTPASSWD_USER=admin

ENV SERVED_PATH=/static

ENV SSL_CERT_PATH=/etc/nginx/ssl
ENV HTPASSWD_PATH=/etc/nginx/conf.d/htpasswd

ADD bin/default.conf.tpl /templates/default.conf.tpl
ADD bin/nginx.conf.tpl /templates/nginx.conf.tpl

ADD bin/init.sh /init.sh
RUN chmod +x /init.sh

VOLUME /etc/nginx/ssl
VOLUME /etc/nginx/conf.d/
VOLUME /static

CMD ["/init.sh"]
