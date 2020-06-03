FROM phusion/baseimage
MAINTAINER Codelitt Inc


RUN apt-get update \
	&& apt-get install  -y \
						ca-certificates \
						nginx \
						curl 

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
