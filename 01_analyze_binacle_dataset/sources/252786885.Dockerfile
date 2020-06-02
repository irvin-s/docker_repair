FROM node:6  
WORKDIR /argos-frontend  
  
COPY . .  
RUN npm install  
  
EXPOSE 3000  
CMD npm run deploy  

