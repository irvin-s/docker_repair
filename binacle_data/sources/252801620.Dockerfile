FROM node:6  
LABEL maintainer www-dev@ebi.ac.uk  
  
# Install fontforge  
RUN apt-get update && apt-get install -y fontforge  
  
# Install Grunt  
RUN npm install -g grunt-cli  

