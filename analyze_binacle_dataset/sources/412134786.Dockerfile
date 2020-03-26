### Dockerfile
#
#   See https://github.com/russmckendrick/docker

FROM russmckendrick/base:latest
MAINTAINER Russ McKendrick <russ@mckendrick.io>

ENV TERM dumb

RUN apk add --update \
	supervisor nginx && \ 
	rm -rf /var/cache/apk/* && \
	mkdir /tmp/nginx && \
	mkdir -p /var/www/html && \
	echo "Hello from NGINX" > /var/www/html/index.html && \
	chown -R nginx:nginx /var/www/html

COPY files/default.conf /etc/nginx/conf.d/
COPY files/nginx.conf /etc/nginx/nginx.conf
COPY files/supervisord.conf /etc/supervisord.conf

EXPOSE 80 443
CMD ["supervisord"]