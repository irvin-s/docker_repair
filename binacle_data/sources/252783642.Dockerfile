# This file was automatically generated  
# changes here will be overwritten  
FROM node:6-alpine  
RUN adduser -u 9999 -g docker -D -g "Docker User" docker && \  
apk --update upgrade && \  
apk add curl ca-certificates && \  
update-ca-certificates && \  
rm -rf /var/cache/apk/* && \  
mkdir -p /usr/local/app && \  
chown -R docker:docker /usr/local/  
WORKDIR /usr/local/app  
USER docker  

