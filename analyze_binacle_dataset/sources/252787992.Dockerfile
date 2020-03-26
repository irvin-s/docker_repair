FROM node:7-alpine  
  
MAINTAINER craneyuan <yuanxingnepu@gmail.com>  
  
ARG VERSION=3.2.3  
LABEL version=$VERSION  
  
RUN npm install --global gitbook-cli &&\  
gitbook fetch ${VERSION} &&\  
npm cache clear &&\  
rm -rf /tmp/*  
  
WORKDIR /server/gitbook  
  
EXPOSE 4000 35729  
CMD /usr/local/bin/gitbook serve  

