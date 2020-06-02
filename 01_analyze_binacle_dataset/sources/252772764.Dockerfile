FROM node  
MAINTAINER Christoffer Rødvik <snapgravy@gmail.com>  
  
# Create Socket Directory  
RUN mkdir /src  
  
# Copy Files  
COPY . /src  
WORKDIR /src  
  
# Install Dependencies  
RUN npm install  
  
# Run Command  
CMD [ "npm", "run", "docker" ]  

