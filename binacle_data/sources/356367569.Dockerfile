FROM nginx

RUN rm -f /etc/nginx/conf.d/*
ADD nginx.conf /etc/nginx/conf.d/web.conf
