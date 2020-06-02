FROM nginx:latest
MAINTAINER Konrad Cerny <info@konradcerny.cz>

COPY ./default.conf /etc/nginx/conf.d/default.conf
