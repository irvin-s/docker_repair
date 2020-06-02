FROM node:8.9-wheezy  
  
# Install nasm, because it is needed for some node libraries  
RUN apt-get update  
RUN apt-get install nasm  
  
# Install bower and gulp  
RUN npm install -g bower@1.8.2 gulp@3.9.1  
  
# Define working directory.  
WORKDIR /app

