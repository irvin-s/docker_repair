FROM quay.io/loicmahieu/alpine-nginx

COPY conf/nginx.conf /etc/nginx/conf/nginx.conf
COPY www /www
