FROM node  
  
ENV VER=${VER:-master} \  
REPO=https://github.com/twhtanghk/sails_proxy \  
APP=/usr/src/app  
  
RUN apt-get update && \  
apt-get install -y git && \  
apt-get clean && \  
git clone -b $VER $REPO $APP  
  
WORKDIR $APP  
RUN npm install && \  
node_modules/.bin/bower install --allow-root  
  
EXPOSE 1337  
  
ENTRYPOINT ./entrypoint.sh  

