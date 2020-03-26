############################################################  
# Dockerfile to build the Chamarika-accounting microservice container image  
# Based on strongloop/node:latest  
############################################################  
# Setting The Base Image to Use  
FROM strongloop/node:latest  
  
# Defining The Maintainer (Author)  
MAINTAINER William Ondeng'e  
  
# Update the repository sources list  
RUN apt-get update  
  
# Create app directory  
RUN mkdir -p /home/strongloop/app  
WORKDIR /home/strongloop/app  
  
# Install app dependencies  
COPY package.json /home/strongloop/app  
RUN npm install  
  
# Bundle app source  
COPY . /home/strongloop/app  
  
EXPOSE 8080  
  
ENV NODE_ENV production  
  
# defined in package.json  
CMD [ "slc", "run" "."]

