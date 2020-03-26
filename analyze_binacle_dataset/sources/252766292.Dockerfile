FROM node:0.10  
ENV NODE_PATH_ROOT /usr/src/env/  
ENV NODE_PATH ${NODE_PATH_ROOT}/node_modules/  
  
RUN mkdir -p /usr/src/app ${NODE_PATH_ROOT}  
  
WORKDIR ${NODE_PATH_ROOT}  
ADD npm-shrinkwrap.json ${NODE_PATH_ROOT}/npm-shrinkwrap.json  
ADD package.json ${NODE_PATH_ROOT}/package.json  
RUN npm install  
  
WORKDIR /usr/src/app  
ADD . /usr/src/app  
  
EXPOSE 80  
CMD [ "node", "app.js", "80", "0.0.0.0" ]  

