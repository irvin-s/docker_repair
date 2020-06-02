FROM node:6.9.1  
MAINTAINER bwowk <bruno.wowk@gmail.com>  
EXPOSE 12321  
EXPOSE 32123  
EXPOSE 80  
WORKDIR /code  
COPY package.json /code  
RUN npm install  
RUN npm install -g browserify  
  
COPY img /code/img  
COPY css /code/css  
COPY index.htm /code  
COPY js /code/js  
RUN browserify js/Main.js -o js/Browsmos.js  
RUN npm uninstall -g browserify  
COPY Server.js /code  
COPY Orchestrator.js /code  
# COPY node_modules /code/node_modules  

