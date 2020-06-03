FROM node:slim  
MAINTAINER Ashley Murphy <ash@strategicdata.com.au>  
  
COPY package.json /gulp/package.json  
WORKDIR /gulp  
  
RUN npm install -g --silent gulp  
RUN npm install --silent  
  
COPY gulpfile.js /gulp/gulpfile.js  
CMD gulp watch  

