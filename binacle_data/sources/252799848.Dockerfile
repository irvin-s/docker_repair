### Set the base image to nodejs  
FROM node:4.5.0  
ADD package.json /tmp/package.json  
RUN cd /tmp && npm install  
RUN mkdir -p /opt/api && cp -a /tmp/node_modules /opt/api/  
  
### Create required folders for app  
RUN mkdir -p /opt/api/logs  
  
### Copy application  
ADD api.js /opt/api  
ADD README.md /opt/api  
ADD api.properties /opt/api  
ADD apiary.apib /opt/api  
ADD static /opt/api/static  
  
ADD api_modules /opt/api/api_modules  
ADD package.json /opt/api/package.json  
ADD log4js_config.json /opt/api/log4js_config.json  
  
EXPOSE 3000  
### Exec application  
WORKDIR /opt/api  
ENTRYPOINT npm start  

