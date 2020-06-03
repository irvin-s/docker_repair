FROM node:9.11  
MAINTAINER Andy Riley <https://github.com/andyianriley>  
  
COPY . /server  
WORKDIR /server/  
RUN cd /server && \  
yarn install  
  
CMD [ "yarn", "start" ]  

