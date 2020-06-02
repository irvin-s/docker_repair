FROM node:latest  
MAINTAINER martin scharm <https://binfalse.de>  
  
# install some common dependencies  
RUN npm install --unsafe-perm -g @angular/cli findup-sync typescript  
  
WORKDIR /usr/src/app  
VOLUME /usr/src/app  
EXPOSE 4200  
# compile the app and run it  
CMD npm install && npm start  
  

