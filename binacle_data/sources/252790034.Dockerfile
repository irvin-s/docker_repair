FROM node:5.6.0-slim  
MAINTAINER CAMPHOR-  
  
COPY . /app/  
WORKDIR /app  
  
RUN npm install --production  
  
ENV NODE_ENV production  
  
EXPOSE 3000  
CMD ["npm", "start"]  

