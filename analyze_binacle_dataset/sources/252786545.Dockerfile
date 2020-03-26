FROM node:7  
MAINTAINER tools@docker.com  
  
ENTRYPOINT ["authenticator"]  
RUN npm install --global authenticator-cli@1.0.2  

