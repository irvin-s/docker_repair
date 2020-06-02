FROM alpine:3.6  
  
RUN addgroup -S certs  
  
RUN adduser -S -G certs certs  
  
RUN apk update && apk upgrade && \  
apk add \--no-cache --update openssl openjdk8 bash  
  
ADD mkcert.sh /usr/bin/mkcert.sh  
  
USER certs  
  
CMD ["/usr/bin/mkcert.sh"]  
  

