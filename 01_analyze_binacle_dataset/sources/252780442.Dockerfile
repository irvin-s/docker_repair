FROM alpine:3.7  
  
RUN addgroup alpine && adduser -s /bin/sh -D -G alpine alpine \  
&& apk add \--no-cache curl \  
&& rm -rf /apk /tmp/* /var/cache/apk/* /sbin/*  
  
USER alpine  

