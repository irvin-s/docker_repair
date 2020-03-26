### Set the base image to nodejs  
FROM node:6.9.5  
ADD package.json /tmp/package.json  
RUN cd /tmp && npm install --only=production  
RUN mkdir -p /opt/generpro && cp -a /tmp/node_modules /opt/generpro/  
  
### Create required folders for app  
RUN mkdir -p /opt/generpro/log  
  
### Copy application  
ADD generpro.js /opt/generpro  
ADD README.md /opt/generpro  
ADD generpro.properties /opt/generpro  
ADD apiary.apib /opt/generpro  
ADD static /opt/generpro/static  
  
ADD generpro_modules /opt/generpro/generpro_modules  
ADD package.json /opt/generpro/package.json  
ADD log4js_config.json /opt/generpro/log4js_config.json  
  
EXPOSE 3000  
### Exec application  
WORKDIR /opt/generpro  
ENTRYPOINT npm start  

