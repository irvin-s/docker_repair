FROM alpine:3.6  
MAINTAINER Ken Herner <ken@astronomer.io>  
  
RUN apk add --no-cache \  
bash \  
curl \  
openssl \  
dumb-init  
  
ENTRYPOINT ["/usr/bin/dumb-init", "curl" ]  
CMD ["--help"]  

