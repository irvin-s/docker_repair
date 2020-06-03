FROM alpine:latest  
MAINTAINER Randy Damron <randy.damron@gmail.com>  
  
RUN apk add --update murmur icu-libs && rm -rf /var/cache/apk/*  
  
ADD ["configs/mumble-server.ini", "/data/mumble-server.ini"]  
  
VOLUME ["/data"]  
EXPOSE 64738/udp 64738/tcp  
  
ENTRYPOINT ["/usr/bin/murmurd", "-fg", "-ini", "/data/mumble-server.ini"]  

