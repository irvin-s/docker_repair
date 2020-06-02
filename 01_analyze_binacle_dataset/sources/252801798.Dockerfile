FROM node:4-slim  
MAINTAINER Erik Dasque <erik@frenchguys.com>  
  
# Install base packages  
RUN apt-get update  
RUN apt-get upgrade -y  
  
ADD thats-what-time-it-is.js thats-what-time-it-is.js  
  
# Expose ports  
EXPOSE 8000 7000  
  
CMD node thats-what-time-it-is.js  

