FROM node:6.9.5  
ADD ./package.json /app/package.json  
WORKDIR /app  
  
RUN npm install  
ADD . /app  
  
CMD npm start  

