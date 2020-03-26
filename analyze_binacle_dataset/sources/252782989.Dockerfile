FROM oberthur/docker-nginx:1.8.1  
MAINTAINER Dawid Malinowski <d.malinowski@oberthur.com>  
  
COPY nginx_1.8.1-1~trusty_amd64.deb /tmp/nginx_1.8.1-1~trusty_amd64.deb  
  
RUN dpkg -i /tmp/nginx_1.8.1-1~trusty_amd64.deb  

