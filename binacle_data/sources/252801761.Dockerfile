FROM node:9.3.0-alpine  
  
ADD ./app /app  
RUN cd /app && npm i  
  
WORKDIR /app  
  
CMD ["npm", "start"]  

