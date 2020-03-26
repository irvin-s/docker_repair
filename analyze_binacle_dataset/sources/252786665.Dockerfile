FROM alpine:latest  
MAINTAINER Denis Pettens <denis.pettens@gmail.com>  
  
# Install bind  
RUN set -x \  
&& apk update \  
&& apk add --upgrade bind \  
&& rm -rf /var/cache/apk/*  
  
EXPOSE 53/udp  
EXPOSE 53/tcp  
  
CMD ["named", "-4", "-g", "-c", "/etc/bind/named.conf"]  

