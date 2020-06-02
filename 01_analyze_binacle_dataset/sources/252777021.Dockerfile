FROM node:7  
COPY . /usr/src/app  
WORKDIR /usr/src/app  
RUN npm install && npm cache clean  
  
CMD [ "./hyper-killer" ]  

