FROM maven:3.5.2-jdk-8-alpine  
  
LABEL version="1" \  
maintainer="David Lacourt <david.lacourt@gmail.com>" \  
license="MIT"  
RUN apk update && \  
apk upgrade && \  
apk add \--no-cache \  
bash \  
git \  
openssh  

