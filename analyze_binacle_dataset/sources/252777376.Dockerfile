FROM smebberson/alpine-nginx-nodejs  
MAINTAINER Vladislav Polyakov <cgrass@ya.ru>  
  
ENV NODE_VERSION=v9.5.0 NPM_VERSION=5.6.0  
  
RUN apk upgrade && apk update  
  
# Stream the nginx logs to stdout and stderr  
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \  
ln -sf /dev/stderr /var/log/nginx/error.log  
  
# Build the npm modules  
ADD root /  
WORKDIR /app  
  
RUN npm install  
  
RUN npm run build  
  
EXPOSE 80

