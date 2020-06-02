FROM maven:3.3.9-jdk-8-alpine  
  
RUN apk add openrc --no-cache  
RUN apk --update add docker  
  
  

