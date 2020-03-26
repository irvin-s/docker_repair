# Get the image  
FROM node:0.10-slim  
MAINTAINER Chintan Patel  
  
# Copy the Application  
RUN npm install -g live-server  
  
# Default Command  
CMD ["npm", "start"]  
  
# Set NODE_ENV  
ENV NODE_ENV production  
  
# Set Working Directory  
WORKDIR /opt/app/  
  
# Copy the package.json  
COPY dist/package.json /opt/app/  
  
# Installing Dependencies using package.json  
RUN npm install  
  
# Copy the source code from `dist` except node_modules  
COPY dist /opt/app/  

