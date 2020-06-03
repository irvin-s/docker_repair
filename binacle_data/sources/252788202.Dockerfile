  
############################################################  
# Dockerfile to run cricd bowling-processor API  
############################################################  
  
FROM node:4-slim  
MAINTAINER Bradley Scott  
  
# Copy code to container  
RUN mkdir cricd-bowling-processor  
COPY . /cricd-bowling-processor  
  
# Get dependencies  
RUN cd cricd-bowling-processor \  
&& npm install  
  
# Define working directory.  
WORKDIR /cricd-bowling-processor  
  
# Start the service  
CMD npm start  
  
# Expose ports.  
EXPOSE 3001  

