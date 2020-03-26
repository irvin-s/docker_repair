FROM nginx:alpine

RUN rm /etc/nginx/conf.d/default.conf
ADD conf/nginx.conf /etc/nginx/nginx.conf
ADD conf.d /etc/nginx/conf.d