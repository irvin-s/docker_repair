  
############################################################  
# Dockerfile to run cricd change-publisher  
############################################################  
  
FROM node:4-slim  
MAINTAINER Bradley Scott  
  
# Copy code to container  
RUN mkdir cricd-change-publisher  
COPY . /cricd-change-publisher  
  
# Get dependencies  
RUN cd cricd-change-publisher \  
&& npm install  
  
# Define working directory.  
WORKDIR /cricd-change-publisher  
  
# Start the service  
CMD npm start  
  
# Expose ports.  
EXPOSE 3100  

