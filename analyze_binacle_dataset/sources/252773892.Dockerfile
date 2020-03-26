FROM maven:3.5.2-jdk-8-alpine  
RUN apk update && apk add \--no-cache bash jq libxml2-utils py-pip &&\  
pip --no-cache-dir install awscli  

