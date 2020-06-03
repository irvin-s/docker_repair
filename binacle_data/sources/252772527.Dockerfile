FROM node:0.12  
MAINTAINER awentzonline  
  
COPY . /app  
WORKDIR /app  
RUN npm install  
  
EXPOSE 80  
CMD ["npm", "run", "peerserver"]  

