########################################################  
# Docker file to host a simple Tileset game  
# By alex @ Black Tower Entertainment  
#########################################################  
  
# Set base image  
FROM node:0.12-onbuild  
  
MAINTAINER Alexander Dines  
  
# Copy source  
#COPY ./*.js /home/server/  
#COPY ./src /home/server/  
#COPY ./src/ /home/server/  
#COPY ./*.json /home/server/  
#Copy Client  
#COPY ./public /home/server/  
#Install npm  
RUN cd /home/server/; npm install  
#Run the server  
  
EXPOSE 80  
  
CMD ["node", "/usr/src/app/index.js"]  

