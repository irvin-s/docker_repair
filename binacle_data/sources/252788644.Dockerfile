## The default node JS is being used. Change this to  
## upgrade the Node.JS Version  
FROM node:5.11.1  
MAINTAINER Heucles Junior <heucles.junior@concretesolutions.com.br>  
  
## Install the Sails framework globally  
RUN npm install -g sails  
  
## Install the PM2 process manager globally  
RUN npm install pm2 -g  
  
## The 1337 is the default port for this service  
EXPOSE 1337  
## Add a limited user and give him permission on the entrypoint dir  
RUN mkdir -p /entrypoint/app  
RUN /usr/sbin/groupadd node -g 1000  
RUN /usr/sbin/useradd -m node -g 1000 -u 1000 -d /entrypoint  
RUN chown -R 1000:1000 /entrypoint  
  
## The /entrypoint volume must be mounted with the root of the  
## node.js application  
VOLUME /entrypoint  
  
## Change the user to node and the dir to the Youse directory,  
## which is where the process must to be started  
USER node  
WORKDIR /entrypoint/app  
  
## Start the main app using PM2  
CMD pm2 start app.js --no-daemon  

