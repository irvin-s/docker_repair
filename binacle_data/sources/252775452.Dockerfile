FROM node:4  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app/  
RUN npm install  
COPY . /usr/src/app  
RUN npm run build  
  
CMD [ "npm", "start" ]  
  
EXPOSE 3000  

