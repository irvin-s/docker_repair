FROM node:4-slim  
  
ENV VER=${VER:-master} \  
REPO=https://github.com/dorissschoi/businessProcessApp \  
APP=/usr/src/app  
  
RUN apt-get update && \  
apt-get -y install git python && \  
apt-get clean  
  
RUN git clone -b $VER $REPO $APP  
  
WORKDIR $APP  
  
RUN npm install bower coffee-script -g && \  
npm install && \  
bower install --allow-root  
  
EXPOSE 1337  
ENTRYPOINT ./entrypoint.sh  

