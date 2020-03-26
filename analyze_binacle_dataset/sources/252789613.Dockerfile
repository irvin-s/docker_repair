# Use an official Nodejs runtime  
FROM node:4-onbuild  
#ONBUILD ARG NODE_ENV  
#ONBUILD ENV NODE_ENV $NODE_ENV  
#Working directory  
WORKDIR ./NodejsWebApp1  
RUN pwd  
  
#ONBUILD COPY /NodejsWebApp1/package.json /app  
#ONBUILD COPY /NodejsWebApp1/ /usr/src/app  
# Copy the current directory contents into the container at  
ADD ./NodejsWebApp1 /app  
  
# Make port 80 available to the world outside this container  
EXPOSE 80

