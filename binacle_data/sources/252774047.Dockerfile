FROM node  
  
MAINTAINER Genar Trias <genar@alvarium.io>  
  
COPY . /app  
  
WORKDIR /app  
  
RUN npm install  
  
ENV NODE_ENV production  
  
EXPOSE 3000  
ENTRYPOINT node app.js  

