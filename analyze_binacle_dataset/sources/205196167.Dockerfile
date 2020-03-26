FROM nginx:1.11.4-alpine

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY static /usr/share/nginx/html
