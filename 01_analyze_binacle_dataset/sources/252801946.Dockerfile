FROM openjdk:alpine  
  
RUN apk update && apk add acf-openssl  
  
COPY bin /srv/minecraft/

