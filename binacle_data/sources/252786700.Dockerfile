# This image will be based on the oficial nodejs docker image  
FROM node:latest  
  
# Commands will run in this directory  
WORKDIR /home/app  
  
# Add all our code inside that directory that lives in the container  
ADD . /home/app  
  
# Install dependencies and generate production dist  
# RUN npm update -g npm  
RUN \  
npm install -g bower gulp && \  
npm install && \  
bower install --config.interactive=false \--allow-root && \  
gulp dist  
  
# Tell Docker we are going to use this port  
EXPOSE 8080  
# The command to run our app when the container is run  
CMD ["npm", "run", "start-prod"]  

