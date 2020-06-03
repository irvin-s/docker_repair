FROM nginx:stable-alpine

COPY ./config/site.conf /etc/nginx/conf.d/default.conf
