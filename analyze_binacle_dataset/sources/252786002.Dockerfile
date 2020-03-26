FROM publicisworldwide/node:latest  
  
USER $CONTAINER_USER  
  
# Create app directory  
RUN mkdir -p /home/$CONTAINER_USER/app  
WORKDIR /home/$CONTAINER_USER/app  
  
# Install app dependencies  
ADD package.json /home/$CONTAINER_USER/app  
RUN npm install --production  
  
# Bundle app source  
ADD . /home/$CONTAINER_USER/app  
  
EXPOSE 8080  
ENTRYPOINT [ "npm", "start" ]  

