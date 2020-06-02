  
############################################################  
# Dockerfile to run cricd next-ball-processor API  
############################################################  
  
FROM node:4-slim  
MAINTAINER Bradley Scott  
  
# Copy code to container  
RUN mkdir cricd-next-ball-processor  
COPY . /cricd-next-ball-processor  
  
# Get dependencies  
RUN cd cricd-next-ball-processor \  
&& npm install  
  
# Define working directory.  
WORKDIR /cricd-next-ball-processor  
  
# Start the service  
CMD npm start  
  
# Expose ports.  
EXPOSE 3003  

