# DOCKER-VERSION 1.2.0  
FROM node:argon  
# Bundle app source  
COPY . /rtdb  
WORKDIR /rtdb  
# Install app dependencies  
RUN npm install  
  
EXPOSE 9001  
CMD ["npm", "start"]  

