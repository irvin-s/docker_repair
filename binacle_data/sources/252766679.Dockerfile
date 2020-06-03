# This image will be based on the oficial nodejs docker image  
FROM node:latest  
  
# Commands will run in this directory  
WORKDIR /home/app  
  
# Add all our code inside that directory that lives in the container  
ADD . /home/app  
  
# Install dependencies and generate production dist  
RUN npm update -g npm  
RUN \  
npm install  
# Tell Docker we are going to use this port  
EXPOSE 8080  
# The command to run our app when the container is run  
CMD ["node", "/home/app/server.js"]  

