FROM java:8-jre-alpine  
  
MAINTAINER Nick Zahn <hi@cloudunder.io>  
  
RUN apk add --update bash && rm -rf /var/cache/apk/*  

