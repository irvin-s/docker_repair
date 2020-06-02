FROM node:onbuild  
WORKDIR /src  
COPY . /src  
  
RUN npm install -g gulp  
RUN npm install --only=dev  
RUN gulp build  
  
WORKDIR /src/dist  
  
RUN npm install --only=prod  
  
EXPOSE 80  
CMD ["node", "server.js"]  

