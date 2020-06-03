FROM alpine:3.2  
RUN apk add --update haproxy && rm -rf /var/cache/apk/*  
  
VOLUME ["/data"]  
  
ENTRYPOINT ["haproxy", "-f", "/data/haproxy.cfg"]  

