#  
# Alpine Linux - OpenJDK8 Dockerfile  
#  
FROM alpine:latest  
  
MAINTAINER Huub Daems <buuhsmead@gmail.com>  
  
RUN apk add --no-cache ansible  
  
COPY opt /opt  
  
WORKDIR /opt/ansible  
  

