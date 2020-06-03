FROM node:6  
MAINTAINER Stein-Otto Svorstol <steinotto@svorstol.com>  
  
# Create app directory  
RUN mkdir -p /app  
WORKDIR /app  
  
EXPOSE 3000  
# Copy application  
COPY . /app  
  
# Build image  
RUN npm install  

