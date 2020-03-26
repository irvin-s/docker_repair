FROM nginx:alpine
MAINTAINER alec reiter <alecreiter@gmail.com>
RUN rm /etc/nginx/conf.d/*
COPY flaskbb/flaskbb/static /var/www/flaskbb/static
