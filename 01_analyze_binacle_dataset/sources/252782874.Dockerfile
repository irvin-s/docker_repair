FROM node:6.6  
  
ADD . /client  
  
WORKDIR /client  
  
RUN npm install  
  
EXPOSE 3000  
  
EXPOSE 3001  
  
EXPOSE 5000  
  
CMD npm start  

