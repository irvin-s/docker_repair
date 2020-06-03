FROM node:7.5  
WORKDIR /app  
  
RUN touch .env  
  
ADD ./package.json /app/package.json  
  
RUN npm install --production  
  
ADD ./models /app/models  
ADD ./public /app/public  
ADD ./routes /app/routes  
ADD ./templates /app/templates  
ADD ./updates /app/updates  
ADD ./keystone.js /app/keystone.js  
  
CMD node keystone.js  

