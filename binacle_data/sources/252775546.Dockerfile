FROM node:slim  
MAINTAINER Benjamin Hutchins <ben@hutchins.co>  
  
RUN npm install -g node-static  
  
WORKDIR /static  
VOLUME /static  
  
EXPOSE 80  
CMD static --host-address 0.0.0.0 -p 80 --gzip  

