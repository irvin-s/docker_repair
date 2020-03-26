FROM node:latest  
  
MAINTAINER Paolo Chiabrera <paolo.chiabrera@gmail.com>  
  
# currently only works for development  
ENV NODE_ENV staging  
  
ENV LOG_LEVEL warn  
  
ENV PORT 9160  
ENV PM2_HOME /home/metro/.pm2  
  
# use changes to package.json to force Docker not to use the cache  
# when we change our application's nodejs dependencies:  
ADD package.json /tmp/package.json  
  
RUN cd /tmp && npm install --save pm2@latest -g && npm install --production  
  
RUN mkdir -p /home/metro && cp -a /tmp/node_modules /home/metro  
  
RUN pm2 startup ubuntu  
  
WORKDIR /home/metro  
  
ADD . /home/metro  
  
# replace this with your application's default port  
EXPOSE 9160  
CMD pm2 start /home/metro/app.js -x -i 1 --name metro && pm2 save && pm2 logs

