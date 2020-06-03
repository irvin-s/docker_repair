FROM alpine:3.4  
MAINTAINER Chris Weyl <chris.weyl@dreamhost.com>  
  
RUN apk update && \  
apk add radvd && \  
rm -r /var/cache/  
  
ENTRYPOINT [ "radvd", "--nodaemon", "-p", "/radvd.pid" ]  

