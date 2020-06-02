FROM nginx:1.13-alpine

COPY config/ /etc/nginx
COPY dist/* /usr/share/nginx/www/

expose 8080