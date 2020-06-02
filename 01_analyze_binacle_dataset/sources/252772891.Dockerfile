FROM node:latest  
  
MAINTAINER Berry Goudswaard <info@noregression.nl>  
  
RUN npm install -g parse-server  
  
EXPOSE 1337  
CMD ["parse-server"]  

