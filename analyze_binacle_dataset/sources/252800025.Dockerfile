FROM node:latest  
  
MAINTAINER dimkk  
  
  
COPY . /var/www  
WORKDIR /var/www  
  
RUN npm install \  
&& npm install -g typings \  
&& typings install  
  
EXPOSE 3000  
ENTRYPOINT ["node", "index.js"]  

