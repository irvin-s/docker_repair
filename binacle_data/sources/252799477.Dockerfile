FROM dialonce/nodejs:lts-carbon  
  
RUN mkdir -p /usr/src/app  
  
WORKDIR /usr/src/app  
  
COPY . .  
  
RUN npm install --production && npm run updatedb  
  
CMD ["npm", "start"]  

