  
############################################################  
# Dockerfile to run cricd score-processor API  
############################################################  
  
FROM node:4-slim  
MAINTAINER Bradley Scott  
  
# Copy code to container  
RUN mkdir cricd-score-processor  
COPY . /cricd-score-processor  
  
# Get dependencies  
RUN cd cricd-score-processor \  
&& npm install  
  
# Define working directory.  
WORKDIR /cricd-score-processor  
  
# Start the service  
CMD npm start  
  
# Expose ports.  
EXPOSE 3002  

