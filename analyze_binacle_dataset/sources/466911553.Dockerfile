FROM nginx:1.12-alpine

RUN apk --update --no-cache add openssl acme-client mc bash \
     && openssl dhparam -dsaparam -out /etc/nginx/dhparam.pem 4096

ADD ./env.conf /etc/nginx/conf.d/configs/env.conf
ADD ./start.sh /start.sh
ADD ./auth_proxy_ldap /etc/nginx/auth_proxy_ldap
ADD ./proxy_params /etc/nginx/proxy_params
ADD ./acme.conf /etc/nginx/conf.d/acme.conf
ADD ./ssl_processing.sh /ssl_processing.sh

RUN mkdir -p /var/www/acme/.well-known/acme-challenge/

EXPOSE 80

STOPSIGNAL SIGTERM

ENTRYPOINT ["/start.sh"]
