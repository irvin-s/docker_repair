FROM alpine:latest  
  
MAINTAINER Imran Ismail <imran@127labs.com>  
  
COPY wait-for-it.sh /  
  
ENTRYPOINT ["./wait-for-it.sh"]  

