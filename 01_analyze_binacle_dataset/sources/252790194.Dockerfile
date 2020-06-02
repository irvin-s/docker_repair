FROM alpine:latest  
  
MAINTAINER Morgan O'Neal <morgan@cannafo.com>  
  
RUN apk add \--no-cache \--update curl && \  
rm -rf /var/cache/apk/*  
  
ENTRYPOINT ["curl"]  
  
CMD ["-h"]  

