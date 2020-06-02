FROM nginx:latest

MAINTAINER Oleksa Novyk <oleksanovyk@gmail.com>

COPY ./etc/nginx.conf /etc/nginx/nginx.conf

ADD ./dist/ui-docs /var/app/
