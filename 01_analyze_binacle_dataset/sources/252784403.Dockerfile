FROM node  
  
ADD . /src/  
WORKDIR /src/  
  
RUN npm install  
  
CMD node app.js  
  
EXPOSE 3000  

