FROM nginx:1.15-alpine

COPY openssl.cnf openssl.cnf

RUN set -ex && \
    apk add --no-cache openssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -sha256 -extensions EXT \
        -subj '/CN=localhost' \
        -keyout /etc/ssl/private/localhost.key \
        -out /etc/ssl/private/localhost.crt \
        -config openssl.cnf && \
    rm openssl.cnf

COPY nginx.conf /etc/nginx/nginx.conf
