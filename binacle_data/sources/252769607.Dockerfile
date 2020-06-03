FROM node:0.12-slim  
  
WORKDIR /usr/app  
CMD npm start  
EXPOSE 3000  
ADD . /usr/app/  
RUN npm install  

