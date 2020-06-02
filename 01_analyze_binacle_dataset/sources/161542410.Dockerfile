FROM zenithar/nano-nginx:latest
MAINTAINER Thibault NORMAND <me@zenithar.org>

COPY nginx /etc/

VOLUME ["/www"]
VOLUME ["/etc/nginx/ssl"]
