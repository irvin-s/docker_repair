FROM node:5.11-slim  
  
EXPOSE 8081  
EXPOSE 9090  
WORKDIR /src  
  
COPY package.json /src/package.json  
  
RUN npm install  
  
COPY . /src  
  
RUN ./build-app.sh  
  
CMD ["npm", "start"]  

