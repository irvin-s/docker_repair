FROM maven:3.5.0-jdk-8-alpine  
  
ENV NPM_CONFIG_LOGLEVEL info  
ENV NODE_VERSION 6.10.2  
RUN apk update && apk add nodejs  
  
CMD ["mvn"]  

