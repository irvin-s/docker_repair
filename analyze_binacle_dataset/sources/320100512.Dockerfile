FROM alpine
MAINTAINER Aleksandr Lykhouzov <lykhouzov@gmail.com>

# Install Nginx
RUN apk update && apk add nginx \
&& rm -rf /tmp/* /var/tmp/* /var/run/nginx \
&& rm -f /etc/nginx/nginx.conf && mkdir /var/run/nginx \
&& chown nginx /var/run/nginx && chmod 777 /var/run/nginx \
# forward request and error logs to docker log collector
&& ln -sf /dev/stdout /var/log/nginx/docker-access.log \
&& ln -sf /dev/stderr /var/log/nginx/docker-error.log

# nginx site conf
COPY ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 80 443

VOLUME ["/var/www/html"]

CMD ["nginx","-g","daemon off;"]
