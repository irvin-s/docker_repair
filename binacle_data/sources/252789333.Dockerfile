FROM node:argon  
  
COPY ./ .  
  
RUN npm install  
  
CMD [ "npm", "start" ]  
  

