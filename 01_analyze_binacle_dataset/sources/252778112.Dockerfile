# This image will be based on the official nodejs docker image  
FROM node:latest  
  
# Set in what directory commands will run  
WORKDIR /topic  
  
# Put all our code inside that directory that lives in the container  
ADD . /topic  
  
# Install dependencies  
RUN \  
npm install -g http-server  
  
# Tell Docker we are going to use this port  
EXPOSE 9000  
# The command to run our app when the container is run  
CMD ["http-server", ""]  

