FROM nginx:1.13-alpine

COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /usr/share/nginx/html/static
COPY dist/. /usr/share/nginx/html/