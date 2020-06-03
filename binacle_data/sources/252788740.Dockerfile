FROM node:6.11  
WORKDIR /data  
  
ADD . .  
  
RUN npm install .  
  
CMD bin/run  

