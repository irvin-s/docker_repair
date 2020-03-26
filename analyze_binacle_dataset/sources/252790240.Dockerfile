# Install Node.js docker container  
FROM node:0.10-onbuild  
# Bundle app source  
COPY . /microservice-nodejs  
  
# Install app dependencies  
ADD package.json /microservice-nodejs/package.json  
RUN cd /microservice-nodejs && npm install  
RUN mkdir -p /opt/app && cp -a /microservice-nodejs/node_modules /opt/app/  
  
WORKDIR /opt/app  
ADD . /opt/app  
  
# Environment variables  
ENV NODE_ENV production  
ENV EXPRESS_PORT 80  
EXPOSE 8080  
EXPOSE 5672  
EXPOSE 15672  
CMD ["node", "/microservice-nodejs/server.js"]  

