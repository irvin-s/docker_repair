# This image will be based on the official nodejs docker image  
FROM node:latest  
  
RUN mkdir /home/chapi-ventas-ui  
  
# Set in what directory commands will run  
WORKDIR /home/chapi-ventas-ui/  
  
# Put all our code inside that directory that lives in the container  
ADD ./ /home/chapi-ventas-ui/  
  
# Install dependencies  
RUN npm install  
  
# Tell Docker we are going to use this port  
#EXPOSE 8000  
# The command to run our app when the container is run  
#RUN npm start  
#CMD "node", "server.js"

