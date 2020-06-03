FROM alpine:latest  
  
MAINTAINER Morgan O'Neal <morgan@cannafo.com>  
  
RUN apk add --no-cache --update zip  
  
ENTRYPOINT ["zip"]  
  
CMD ["-h"]  

