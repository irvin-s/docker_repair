FROM openjdk:8-jdk-alpine  
MAINTAINER Jesse DeFer <apache-ant@dotd.com>  
  
RUN apk update  
RUN apk add apache-ant  
  
ENTRYPOINT ["ant"]  

