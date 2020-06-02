FROM alpine:latest  
MAINTAINER Colin Taylor <cjntaylor@gmail.com>  
  
RUN apk add --update shorewall && rm -rf /var/cache/apk/*  
RUN touch /var/log/messages  
  
ENTRYPOINT ["/usr/sbin/shorewall"]  
  
CMD ["help"]  

