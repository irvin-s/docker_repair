FROM loicmahieu/alpine-envsubst AS generate_conf
WORKDIR /tmp

ARG ADH6_URL="adh6.minet.net"

ARG API_HOST=""
ARG API_PORT=""

ARG FRONTEND_HOST=""
ARG FRONTEND_PORT=""

COPY adh6.template.conf .
RUN cat adh6.template.conf | envsubst '${ADH6_URL} ${API_HOST} ${API_PORT} ${FRONTEND_HOST} ${FRONTEND_PORT}' | tee adh6.conf


FROM alpine:3.9 AS generate_certs
RUN apk add --update openssl

# Make TLS self-signed certificate
RUN openssl genrsa -out /etc/ssl/private/adh6.key 2048 \
    && openssl req -new -key /etc/ssl/private/adh6.key -out /tmp/adh6.csr -subj "/C=FR/ST=Essonne/O=MiNET/CN=reverse_proxy" \
    && openssl x509 -req -days 365 -in /tmp/adh6.csr -signkey /etc/ssl/private/adh6.key -out /etc/ssl/certs/adh6.crt

FROM nginx:1.15.12

COPY --from=generate_certs /etc/ssl/certs/adh6.crt /etc/ssl/certs/
COPY --from=generate_certs /etc/ssl/private/adh6.key /etc/ssl/private/

COPY --from=generate_conf /tmp/adh6.conf /etc/nginx/conf.d/adh6.conf

RUN rm /etc/nginx/conf.d/default.conf

