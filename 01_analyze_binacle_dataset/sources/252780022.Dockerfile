# See the README.md for usage and configuration info  
FROM node:8-alpine  
COPY . /app  
WORKDIR /app  
RUN npm install --production --no-optional  
CMD ["npm", "start"]  
  

