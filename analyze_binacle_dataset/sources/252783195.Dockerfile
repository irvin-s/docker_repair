FROM alpine:latest  
MAINTAINER dcflachs  
  
RUN apk add --no-cache clamav freshclam  
RUN apk add --update bash && rm -rf /var/cache/apk/*  
  
VOLUME /var/lib/clamav  
  
ENTRYPOINT ["/bin/sh"]  

