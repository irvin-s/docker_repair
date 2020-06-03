# vim:set ft=dockerfile:  
FROM alpine:edge  
  
MAINTAINER Andrius Kairiukstis <andrius@kairiukstis.com>  
  
RUN apk add --update --no-cache \  
tg \  
&& rm -rf /var/cache/apk/* /tmp  
  
CMD ["/usr/bin/telegram-cli"]  

