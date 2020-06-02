FROM node:6  
# Create docs directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Install docs dependencies  
RUN npm install jsdoc express minami  
  
# Bundle docs source  
COPY . /usr/src/app  
  
EXPOSE 4000  
CMD [ "npm", "run", "docs" ]  

