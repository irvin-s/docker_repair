FROM mhart/alpine-node:latest  
  
COPY . /usr/src/node-urandom-server  
  
WORKDIR /usr/src/node-urandom-server  
RUN npm install  
  
EXPOSE 8080  
CMD [ "npm", "start" ]  

