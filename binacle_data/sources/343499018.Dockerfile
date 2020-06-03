FROM nginx:1.9
MAINTAINER Wyatt Pan <wppurking@gmail.com>

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY dist/ /dist
