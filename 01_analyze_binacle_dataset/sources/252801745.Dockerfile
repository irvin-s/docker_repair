FROM node:alpine  
  
RUN apk update && \  
apk upgrade && \  
apk add sshpass rsync openssh  
  
RUN npm install -g @angular/cli tslint typescript  
  
RUN rm -rf /var/cache/apk/*  
  
RUN npm cache clean  
  
RUN mkdir -p /app  
  
WORKDIR /app  
  

