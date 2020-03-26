FROM ubuntu:17.04  
FROM node:6.10.0  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
COPY . /usr/src/app  
RUN npm install  
RUN npm install date-and-time --save  
RUN npm install --save body-parser  
RUN npm install --save multer  
RUN npm install --save cors  
RUN npm install --save morgan  
CMD ["node", "app.js"]  

