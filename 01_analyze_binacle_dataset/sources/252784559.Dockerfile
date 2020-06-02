FROM node:4.4.0  
RUN mkdir -p /usr/opt/app  
WORKDIR /usr/opt/app  
  
COPY package.json /usr/opt/app/  
RUN npm install  
COPY . /usr/opt/app  
  
EXPOSE 9200  
ENTRYPOINT [ "npm", "start" ]  

