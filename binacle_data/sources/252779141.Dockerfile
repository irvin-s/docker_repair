FROM alpine:3.3  
MAINTAINER Zdenek Farana <zdenek.farana@aproint.com>  
  
RUN apk add --update tcpflow && rm -rf /var/cache/apk/*  
  
ENTRYPOINT ["tcpflow"]  
CMD []

