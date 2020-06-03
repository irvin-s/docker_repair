FROM node:latest  
RUN mkdir -p /usr/app  
COPY package.json /usr/app  
WORKDIR /usr/app/  
RUN npm install  
COPY ./src /usr/app/src  
EXPOSE 8080  
CMD [ "npm", "start" ]  

