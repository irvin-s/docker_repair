  
############################################################  
# Dockerfile to run cricd-entities sails.js API application  
############################################################  
  
FROM node:4-slim  
MAINTAINER Bradley Scott  
  
RUN npm install -g sails grunt bower pm2 npm-check-updates  
  
# Copy code to container  
RUN mkdir cricd-entities  
COPY . /cricd-entities  
  
# Get dependencies  
RUN cd cricd-entities \  
&& npm install  
  
# Define working directory.  
WORKDIR /cricd-entities  
  
# Start the service  
CMD sails lift  
  
# Expose ports.  
EXPOSE 1337  

