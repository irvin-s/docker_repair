  
############################################################  
# Dockerfile to run cricd batting-processor API  
############################################################  
  
FROM node:4-slim  
MAINTAINER Bradley Scott  
  
# Copy code to container  
RUN mkdir cricd-batting-processor  
COPY . /cricd-batting-processor  
  
# Get dependencies  
RUN cd cricd-batting-processor \  
&& npm install  
  
# Define working directory.  
WORKDIR /cricd-batting-processor  
  
# Start the service  
CMD npm start  
  
# Expose ports.  
EXPOSE 3000  

