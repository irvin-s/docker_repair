FROM node:9.11-slim  
MAINTAINER blurblah@blurblah.net  
  
# Create a directory where this app will be placed  
RUN mkdir -p /usr/src/app  
  
# Change directory  
WORKDIR /usr/src/app  
  
# Copy dependency definitions and install it  
COPY package.json /usr/src/app  
RUN npm install  
  
# Copy all codes to the app directory  
COPY . /usr/src/app  
  
VOLUME /usr/src/app/config/default.yml  
  
# Run the app  
CMD ["node", "importForecast.js"]  

