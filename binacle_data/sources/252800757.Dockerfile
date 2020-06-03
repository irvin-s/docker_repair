FROM node  
  
ENV VER=${VER:-master} \  
REPO=https://github.com/dorissschoi/db-test \  
APP=/usr/src/app  
  
RUN apt-get update && \  
apt-get install -y git vim && \  
apt-get clean && \  
git clone -b $VER $REPO $APP  
  
WORKDIR $APP  
RUN npm install && \  
node_modules/.bin/bower install --allow-root  
  
EXPOSE 1337  
  
ENTRYPOINT ./entrypoint.sh  

