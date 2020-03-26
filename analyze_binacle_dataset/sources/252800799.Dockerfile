FROM node:onbuild  
WORKDIR /src  
ADD . /src  
  
RUN npm install -g gulp bower  
RUN npm install --only=dev  
RUN gulp build-prod  
  
WORKDIR /src/dist  
  
RUN npm install --only=prod  
RUN bower install --allow-root  
  
EXPOSE 80  
CMD ["node", "server.js"]  

