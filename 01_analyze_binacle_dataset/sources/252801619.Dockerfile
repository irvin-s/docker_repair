FROM node:6  
LABEL maintainer www-dev@ebi.ac.uk  
  
# Install Bower & Gulp  
RUN npm install -g bower gulp  
  
# COPY .bowerrc /root/  

