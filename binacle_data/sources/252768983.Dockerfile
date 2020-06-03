# vim:set ft=dockerfile:  
FROM alpine:latest  
  
MAINTAINER Andrius Kairiukstis <andrius@kairiukstis.com>  
  
RUN apk add --update nginx \  
&& rm -rf /var/cache/apk/* /tmp/* /var/tmp/*  
  
# forward request and error logs to docker log collector  
RUN ln -sf /dev/stdout /var/log/nginx/access.log  
RUN ln -sf /dev/stderr /var/log/nginx/error.log  
  
ENTRYPOINT ["nginx", "-g", "daemon off;"]  

